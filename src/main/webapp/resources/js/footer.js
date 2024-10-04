window.addEventListener("load",()=>{
const topBt = document.querySelector(".topButton");
console.log(topBt);

topBt.addEventListener("click",e=>{
  e.preventDefault();
  currentPageIndex = 0;
  window.scroll({
    top:0,
    left:0,
    behavior:"smooth"
  });
});

document.addEventListener("scroll",e=>{
  let scrolls = document.querySelector('html').scrollTop;
  if(scrolls<=180){
    topBt.style.opacity = `0`;
  }else{
    topBt.style.opacity = `1`;
  }
})
})
