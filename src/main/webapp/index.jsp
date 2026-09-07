<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Learnly — Learning Space</title>
<style>
:root{
  --bg:#f7f8fc; --surface:#fff; --ink:#171927; --muted:#73778b;
  --line:#e8eaf2; --primary:#6d5dfc; --primary2:#8d7cff;
  --soft:#eeecff; --green:#20b486; --orange:#ff9f43; --shadow:0 18px 50px rgba(31,27,75,.09);
}
*{box-sizing:border-box} body{margin:0;font-family:Inter,ui-sans-serif,system-ui,-apple-system,Segoe UI,sans-serif;background:var(--bg);color:var(--ink)}
button,input{font:inherit}.app{display:flex;min-height:100vh}
.sidebar{width:250px;background:#fff;border-right:1px solid var(--line);padding:24px 16px;position:fixed;inset:0 auto 0 0;z-index:10}
.logo{display:flex;align-items:center;gap:10px;padding:6px 12px 28px;font-weight:800;font-size:21px}
.logo-mark{width:36px;height:36px;border-radius:12px;background:linear-gradient(135deg,#6d5dfc,#a18cff);display:grid;place-items:center;color:#fff;box-shadow:0 8px 20px #7566fc40}
.nav{display:grid;gap:6px}.nav button{border:0;background:none;color:#70758a;text-align:left;padding:12px 14px;border-radius:13px;cursor:pointer;display:flex;gap:12px;align-items:center;font-weight:600}
.nav button:hover,.nav button.active{background:var(--soft);color:var(--primary)}
.nav .admin-link{margin-top:12px;color:#d14e78}.nav .admin-link.active{background:#fff0f5;color:#d14e78}
.user-mini{position:absolute;bottom:22px;left:20px;right:20px;padding:12px;background:#fafaff;border:1px solid var(--line);border-radius:16px;display:flex;align-items:center;gap:10px}
.avatar{width:38px;height:38px;border-radius:50%;display:grid;place-items:center;background:#dcd7ff;color:#5547ce;font-weight:800}
.main{margin-left:250px;width:calc(100% - 250px);padding:28px 42px 60px}
.topbar{display:flex;align-items:center;justify-content:space-between;margin-bottom:30px}.search{width:min(420px,45vw);background:#fff;border:1px solid var(--line);padding:12px 16px;border-radius:14px;outline:none}.top-actions{display:flex;gap:10px;align-items:center}
.iconbtn{border:1px solid var(--line);background:#fff;width:42px;height:42px;border-radius:13px;cursor:pointer}.profile-btn{display:flex;align-items:center;gap:9px;border:0;background:none;font-weight:700;cursor:pointer}
.view{display:none}.view.active{display:block}.hero{background:linear-gradient(115deg,#211d49,#5d4ee9);color:#fff;border-radius:28px;padding:36px 38px;position:relative;overflow:hidden;box-shadow:var(--shadow)}
.hero:after{content:"";position:absolute;width:260px;height:260px;border-radius:50%;background:#fff1;right:-50px;top:-100px;box-shadow:-100px 190px 0 40px #fff0}
.hero h1{font-size:38px;line-height:1.05;margin:0 0 12px;max-width:620px}.hero p{color:#dcd9ff;max-width:620px;font-size:15px}.hero .pill{display:inline-flex;padding:7px 11px;border-radius:20px;background:#ffffff1c;font-size:12px;font-weight:700;margin-bottom:20px}
.grid{display:grid;grid-template-columns:repeat(3,1fr);gap:18px;margin-top:22px}.card{background:#fff;border:1px solid var(--line);border-radius:20px;padding:20px;box-shadow:0 8px 30px rgba(30,25,70,.04)}
.card h3{margin:8px 0 7px}.muted{color:var(--muted);font-size:14px}.section-head{display:flex;justify-content:space-between;align-items:end;margin:8px 0 18px}.section-head h2{margin:0;font-size:25px}
.announcement{display:flex;gap:15px;align-items:flex-start}.dot{width:11px;height:11px;background:var(--primary);border-radius:50%;margin-top:7px;flex:none}.date{font-size:12px;color:#9a9daf}
.course-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:18px}.course{padding:0;overflow:hidden}.cover{height:135px;background:linear-gradient(135deg,#dcd7ff,#f5f3ff);display:flex;align-items:end;padding:16px;position:relative}.cover span{background:#fff;padding:6px 9px;border-radius:9px;font-size:11px;font-weight:800;color:#6254dc}.course-body{padding:18px}.progress{height:7px;background:#eeeef5;border-radius:10px;overflow:hidden;margin:14px 0 8px}.progress i{display:block;height:100%;background:linear-gradient(90deg,#6d5dfc,#a58cff);border-radius:10px}
.library-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:15px}.resource{padding:18px}.resource-icon{width:45px;height:45px;border-radius:13px;background:#f0efff;display:grid;place-items:center;color:#6254dc;font-weight:800}
.profile-card{display:grid;grid-template-columns:130px 1fr;gap:30px;align-items:center}.big-avatar{width:120px;height:120px;border-radius:35px;background:linear-gradient(135deg,#cfc8ff,#eeeaff);display:grid;place-items:center;font-size:38px;font-weight:900;color:#5d4edc}
.stats{display:flex;gap:14px;margin-top:18px}.stat{background:#fafaff;border:1px solid var(--line);padding:14px 18px;border-radius:15px}.stat b{font-size:22px;display:block}
.admin{background:#fff}.admin-head{background:#191631;color:#fff;border-radius:25px;padding:28px}.admin-tabs{display:flex;gap:8px;margin:20px 0}.admin-tabs button{border:1px solid var(--line);background:#fff;border-radius:11px;padding:9px 13px;cursor:pointer}.admin-tabs button.active{background:#191631;color:#fff}
.table{width:100%;border-collapse:collapse}.table th,.table td{text-align:left;padding:15px;border-bottom:1px solid var(--line);font-size:14px}.badge{padding:5px 9px;border-radius:20px;background:#e9fbf4;color:#178b69;font-size:11px;font-weight:800}
.primary{background:var(--primary);color:#fff;border:0;padding:11px 15px;border-radius:12px;font-weight:700;cursor:pointer}.secondary{background:#fff;color:var(--ink);border:1px solid var(--line);padding:11px 15px;border-radius:12px;font-weight:700;cursor:pointer}
.login-overlay{position:fixed;inset:0;background:#17152cdd;z-index:100;display:none;place-items:center;padding:20px}.login-box{background:#fff;width:min(430px,100%);padding:30px;border-radius:25px}.login-box h2{margin-top:0}.field{margin:14px 0}.field label{display:block;font-size:12px;font-weight:800;margin-bottom:7px;color:#666a7e}.field input{width:100%;padding:12px;border:1px solid var(--line);border-radius:12px;outline:none}.error{color:#d14e78;font-size:13px;display:none;margin-top:10px}
.toast{position:fixed;right:25px;bottom:25px;background:#1d1939;color:#fff;padding:13px 17px;border-radius:13px;display:none;z-index:120}
@media(max-width:900px){.sidebar{width:76px}.logo span,.nav button span,.user-mini div:last-child{display:none}.main{margin-left:76px;width:calc(100% - 76px);padding:22px}.grid,.course-grid{grid-template-columns:1fr 1fr}.library-grid{grid-template-columns:1fr 1fr}}
@media(max-width:600px){.main{padding:15px}.topbar .search{display:none}.grid,.course-grid,.library-grid{grid-template-columns:1fr}.hero h1{font-size:29px}.profile-card{grid-template-columns:1fr}.sidebar{width:64px}.main{margin-left:64px;width:calc(100% - 64px)}}
</style>
</head>
<body>
<div class="app">
<aside class="sidebar">
  <div class="logo"><div class="logo-mark">L</div><span>Learnly</span></div>
  <nav class="nav">
    <button class="active" data-view="announcements">◉ <span>Announcements</span></button>
    <button data-view="courses">▣ <span>Courses</span></button>
    <button data-view="library">◫ <span>Library</span></button>
    <button data-view="profile">◎ <span>Profile</span></button>
    <button data-view="help">?</span> <span>Help</span></button>
    <button class="admin-link" id="adminNav" data-view="admin" style="display:none">⚙ <span>Admin Panel</span></button>
  </nav>
  <div class="user-mini"><div class="avatar" id="miniAvatar">H</div><div><b id="miniName">Student</b><div class="muted" id="miniRole">Student</div></div></div>
</aside>

<main class="main">
<header class="topbar">
  <input class="search" placeholder="Search courses, resources..." oninput="filterCards(this.value)">
  <div class="top-actions"><button class="iconbtn">⌕</button><button class="iconbtn">◔</button><button class="profile-btn" onclick="showView('profile')"><div class="avatar" id="topAvatar">H</div><span id="topName">Student</span></button></div>
</header>

<section id="announcements" class="view active">
  <div class="hero"><div class="pill">YOUR LEARNING SPACE</div><h1>Learn something today.<br>Build something tomorrow.</h1><p>Your private learning hub for courses, notes, resources and everything you need to keep moving forward.</p><button class="primary" onclick="showView('courses')">Explore courses →</button></div>
  <div class="section-head"><h2>Latest announcements</h2><span class="muted">Stay in the loop</span></div>
  <div class="grid">
    <div class="card announcement"><i class="dot"></i><div><b>New SQL Mastery course is live</b><p class="muted">Start with window functions, CTEs and real business cases.</p><span class="date">Today · 9:30 AM</span></div></div>
    <div class="card announcement"><i class="dot"></i><div><b>Weekly challenge posted</b><p class="muted">Solve this week's analytics case before Sunday.</p><span class="date">Yesterday</span></div></div>
    <div class="card announcement"><i class="dot"></i><div><b>New resources added</b><p class="muted">Check the Library for interview preparation material.</p><span class="date">Sep 4, 2026</span></div></div>
  </div>
</section>

<section id="courses" class="view">
  <div class="section-head"><div><h2>Courses</h2><p class="muted">Continue where you left off.</p></div><button class="secondary">All courses</button></div>
  <div class="course-grid">
    <div class="card course"><div class="cover"><span>DATA ANALYTICS</span></div><div class="course-body"><h3>SQL Mastery</h3><p class="muted">From fundamentals to advanced business analytics.</p><div class="progress"><i style="width:72%"></i></div><small class="muted">72% complete · 18 lessons</small></div></div>
    <div class="card course"><div class="cover"><span>BI & REPORTING</span></div><div class="course-body"><h3>Power BI Essentials</h3><p class="muted">Build dashboards, models and powerful DAX measures.</p><div class="progress"><i style="width:43%"></i></div><small class="muted">43% complete · 14 lessons</small></div></div>
    <div class="card course"><div class="cover"><span>CAREER</span></div><div class="course-body"><h3>Analytics Interview Lab</h3><p class="muted">Cases, guesstimates, metrics and stakeholder thinking.</p><div class="progress"><i style="width:18%"></i></div><small class="muted">18% complete · 11 lessons</small></div></div>
  </div>
</section>

<section id="library" class="view">
  <div class="section-head"><div><h2>Library</h2><p class="muted">Your collection of useful learning material.</p></div></div>
  <div class="library-grid">
    <div class="card resource"><div class="resource-icon">PDF</div><h3>SQL Cheat Sheet</h3><p class="muted">Quick reference for joins, windows and dates.</p></div>
    <div class="card resource"><div class="resource-icon">DOC</div><h3>Case Study Framework</h3><p class="muted">A repeatable framework for analytics cases.</p></div>
    <div class="card resource"><div class="resource-icon">VID</div><h3>DAX Fundamentals</h3><p class="muted">Short video lessons and examples.</p></div>
    <div class="card resource"><div class="resource-icon">XLS</div><h3>Practice Dataset</h3><p class="muted">Realistic datasets for hands-on practice.</p></div>
  </div>
</section>

<section id="profile" class="view">
  <div class="card profile-card"><div class="big-avatar" id="bigAvatar">H</div><div><span class="badge" id="profileRole">STUDENT</span><h2 id="profileName">Student</h2><p class="muted">Learning journey · Analytics track</p><div class="stats"><div class="stat"><b>4</b><small class="muted">Courses</small></div><div class="stat"><b>28</b><small class="muted">Lessons</small></div><div class="stat"><b>72%</b><small class="muted">Progress</small></div></div></div></div>
</section>

<section id="help" class="view">
  <div class="section-head"><div><h2>How can we help?</h2><p class="muted">Everything you need to use Learnly.</p></div></div>
  <div class="grid">
    <div class="card"><h3>Getting started</h3><p class="muted">Open Courses to start a lesson. Your progress can be tracked automatically once Firebase is connected.</p></div>
    <div class="card"><h3>Need access?</h3><p class="muted">Ask the administrator to add your account or grant access to a course.</p></div>
    <div class="card"><h3>Something not working?</h3><p class="muted">Contact the administrator with the course name and a screenshot of the issue.</p></div>
  </div>
</section>

<section id="admin" class="view admin">
  <div class="admin-head"><span class="pill">ADMINISTRATOR</span><h1>Control your learning space.</h1><p>Manage courses, announcements, resources and student access from one place.</p></div>
  <div class="admin-tabs"><button class="active">Overview</button><button onclick="toast('Course editor ready for Firebase integration')">Courses</button><button onclick="toast('Resource manager ready for Firebase integration')">Library</button><button onclick="toast('User management ready for Firebase integration')">Students</button></div>
  <div class="card"><div class="section-head"><h2>Recent activity</h2><button class="primary" onclick="toast('New course form opened')">+ Add course</button></div>
  <table class="table"><tr><th>Item</th><th>Type</th><th>Status</th><th>Updated</th></tr>
  <tr><td>SQL Mastery</td><td>Course</td><td><span class="badge">Published</span></td><td>Today</td></tr>
  <tr><td>Weekly challenge</td><td>Announcement</td><td><span class="badge">Live</span></td><td>Yesterday</td></tr>
  <tr><td>SQL Cheat Sheet</td><td>Library</td><td><span class="badge">Published</span></td><td>Sep 4</td></tr></table></div>
</section>
</main>
</div>

<div class="login-overlay" id="loginOverlay">
<div class="login-box">
<h2>Welcome back</h2><p class="muted">Sign in to your private learning space.</p>
<div class="field"><label>USER ID</label><input id="loginId" value="student"></div>
<div class="field"><label>PASSWORD</label><input id="loginPass" type="password" value="learn123"></div>
<button class="primary" style="width:100%" onclick="login()">Sign in</button>
<div class="error" id="loginError">Invalid credentials.</div>
<p class="muted" style="font-size:12px;margin-bottom:0">Demo: <b>admin / admin123</b> or <b>student / learn123</b></p>
</div></div>
<div class="toast" id="toast"></div>

<script>
const users={admin:{password:'admin123',name:'Administrator',role:'admin'},student:{password:'learn123',name:'Student',role:'student'}};
let currentUser=null;
function showView(id){
 document.querySelectorAll('.view').forEach(v=>v.classList.remove('active'));
 document.getElementById(id).classList.add('active');
 document.querySelectorAll('.nav button').forEach(b=>b.classList.toggle('active',b.dataset.view===id));
 window.scrollTo({top:0,behavior:'smooth'});
}
document.querySelectorAll('.nav button').forEach(b=>b.addEventListener('click',()=>showView(b.dataset.view)));
function login(){
 const id=document.getElementById('loginId').value.trim().toLowerCase(), pass=document.getElementById('loginPass').value;
 if(users[id]&&users[id].password===pass){
  currentUser=users[id]; document.getElementById('loginOverlay').style.display='none';
  const initial=currentUser.name[0];
  ['miniAvatar','topAvatar','bigAvatar'].forEach(x=>document.getElementById(x).textContent=initial);
  document.getElementById('miniName').textContent=currentUser.name; document.getElementById('miniRole').textContent=currentUser.role==='admin'?'Administrator':'Student';
  document.getElementById('topName').textContent=currentUser.name; document.getElementById('profileName').textContent=currentUser.name;
  document.getElementById('profileRole').textContent=currentUser.role.toUpperCase();
  document.getElementById('adminNav').style.display=currentUser.role==='admin'?'flex':'none';
  showView('announcements'); toast('Signed in successfully');
 }else document.getElementById('loginError').style.display='block';
}
function toast(msg){const t=document.getElementById('toast');t.textContent=msg;t.style.display='block';setTimeout(()=>t.style.display='none',2200)}
function filterCards(q){q=q.toLowerCase();document.querySelectorAll('.card,.course').forEach(c=>{c.style.opacity=(!q||c.innerText.toLowerCase().includes(q))?'1':'.25'})}
document.getElementById('loginOverlay').style.display='grid';
</script>
</body>
</html>
