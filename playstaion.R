library(rvest)ㅣ
library(RSelenium)
remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4446L,
  browserName = "chrome"
)

remDr$open()

remDr$navigate('https://search.shopping.naver.com/detail/detail.nhn?nv_mid=13357846403&cat_id=50001733&frm=NVSHBRD&query=&NaPm=ct%3Dk3hgjsd4%7Cci%3Dff1d3ad9cffe3a4827cfbe1f09e39bddba131262%7Ctr%3Dslsl%7Csn%3D95694%7Chk%3D1382cf77b9b4b9f7882404983e7f4303d28b111b')
All_review=c()
for(i in 1:11) {  
  a=i 
  first="shop.detail.ReviewHandler.page(" 
  secon=", ''); return false;" 
  script=paste(first,a,secon,sep='') 
  pagemove <- remDr$executeScript(script, args = 1:2) 
  source<-remDr$getPageSource()[[1]] 
  main <- read_html(source)
  mainfo=html_nodes(main,css='.atc')
  review=mainfo%>%html_text() 
  All_review=c(All_review,review)
}
remDr$close()

All_review
