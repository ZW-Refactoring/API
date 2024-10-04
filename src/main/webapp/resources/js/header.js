window.addEventListener("load", () => {
  const headerWrap = document.querySelector(".headerWrap");
  const h1 = document.querySelector("h1");
  const gnblis = document.querySelectorAll(".gnb>ul>li");
  h1.addEventListener("mouseover", e => {
    headerWrap.classList.add("on");
  })
  h1.addEventListener("mouseout", e => {
    if (document.querySelector('html').scrollTop <= 180) {
      headerWrap.classList.remove("on");
    }
  })

  h1.addEventListener("click", e => {
    location.href = "/";
  })

  document.addEventListener("scroll", e => {
    let scrolls = document.querySelector('html').scrollTop;
    if (scrolls <= 180) {
      headerWrap.classList.remove("on");
    } else {
      headerWrap.classList.add("on");
    }
  })

  const menubt = document.querySelector(".menubt");
  const mobwarp = document.querySelector(".mobwrap");
  const mobul = document.querySelector(".mobul");

  menubt.addEventListener("click", e => {
    e.preventDefault();
    mobwarp.classList.toggle("on");
    mobul.classList.toggle("on");
  })
})
