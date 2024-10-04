window.addEventListener("load", () => {
  const sections = document.querySelectorAll("#container>section");
  const snbul = document.querySelector(".snb>ul");
  const snblis = document.querySelectorAll(".snb>ul>li");
  const footer = document.querySelector("#footer");


  let devHeight;
  devHeight = window.innerHeight;
  console.log(devHeight);


  window.addEventListener('resize', () => {
    devHeight = window.innerHeight;
  });

  snbul.addEventListener("mouseover", () => {
    snbul.classList.add("on");
  });


  let currentPageIndex = 0;


  snblis.forEach((snbli, i) => {
    if (snbul.classList == (`on`)); {
      snbli.addEventListener("mouseover", () => {
        snbli.classList.add("on");
      })
      snbli.addEventListener("mouseout", () => {
        snbli.classList.remove("on");
      })
      snbli.addEventListener("click", e => {
        e.preventDefault();
        scrollTo(sections[i], i);
      })
    }
  });

  snbul.addEventListener("mouseout", () => {
    snbul.classList.remove("on");
  })

  sections.forEach((section, i) => {
    section.style.height = `${devHeight}px`
    document.addEventListener("scroll", e => {
      let scrolls = document.querySelector('html').scrollTop;
      if (scrolls >= (i * devHeight) && scrolls < (i + 1) * devHeight) {
        activation(i, snblis);
      }
      if (scrolls <= 180) {
        snbul.style.opacity = '0';
      } else {
        snbul.style.opacity = `1`;
      }
    })
  })
  const con1bt = document.querySelector(".con1bt");
  console.log(con1bt);
  con1bt.addEventListener("click", e => {
    e.preventDefault();
    currentPageIndex = 1;
    window.scroll({
      top: sections[1].offsetTop,
      behavior: "smooth"
    });
  })


  window.addEventListener("wheel", e => {
    e.preventDefault();
    if (e.deltaY > 0) {
      if (currentPageIndex < sections.length - 1) { // 페이지 인덱스의 상한 체크
        currentPageIndex++;
        window.scroll({
          top: sections[currentPageIndex].offsetTop,
          behavior: "smooth"
        });
      } else if (currentPageIndex === sections.length - 1) {
        window.scroll({
          top: footer.offsetTop,
          behavior: "smooth"
        });
      }
    } else if (e.deltaY < 0) {
      if (currentPageIndex > 0) { // 페이지 인덱스의 하한 체크
        currentPageIndex--;
        window.scroll({
          top: sections[currentPageIndex].offsetTop,
          behavior: "smooth"
        });
      }
    }
  }, {
    passive: false
  });

  function activation(index, list) {
    for (let el of list) {
      el.classList.remove("on");
    }
    list[index].classList.add("on");
  }


  function scrollTo(obj, i) {
    let height = obj.offsetTop;
    currentPageIndex = i;
    snblis[i].classList.add("on");
    window.scroll({
      top: height,
      behavior: "smooth"
    });
  }
})