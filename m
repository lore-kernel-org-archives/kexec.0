Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vms173025pub.verizon.net ([206.46.173.25])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aLZc2-0004OH-Qu
 for kexec@lists.infradead.org; Tue, 19 Jan 2016 16:58:36 +0000
Received: from serve.minyard.net ([173.57.176.17]) by vms173025.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul
 16 2014))
 with ESMTPA id <0O1700M7FLSCR410@vms173025.mailsrvcs.net> for
 kexec@lists.infradead.org; Tue, 19 Jan 2016 10:57:53 -0600 (CST)
From: minyard@acm.org
Subject: [PATCH] kdump: Fix gdb macros work work with newer and 64-bit kernels
Date: Tue, 19 Jan 2016 10:57:44 -0600
Message-id: <1453222664-20379-1-git-send-email-minyard@acm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Lots of little changes needed to be made to clean these up, remove the
four byte pointer assumption and traverse the pid queue properly.
Also consolidate the traceback code into a single function instead
of having three copies of it.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 Documentation/kdump/gdbmacros.txt | 90 +++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 50 deletions(-)

diff --git a/Documentation/kdump/gdbmacros.txt b/Documentation/kdump/gdbmacros.txt
index 9b9b454..e5bbd8d 100644
--- a/Documentation/kdump/gdbmacros.txt
+++ b/Documentation/kdump/gdbmacros.txt
@@ -15,14 +15,14 @@
 
 define bttnobp
 	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
-	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
+	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
 	set $init_t=&init_task
 	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
 	while ($next_t != $init_t)
 		set $next_t=(struct task_struct *)$next_t
 		printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
 		printf "===================\n"
-		set var $stackp = $next_t.thread.esp
+		set var $stackp = $next_t.thread.sp
 		set var $stack_top = ($stackp & ~4095) + 4096
 
 		while ($stackp < $stack_top)
@@ -31,12 +31,12 @@ define bttnobp
 			end
 			set $stackp += 4
 		end
-		set $next_th=(((char *)$next_t->pids[1].pid_list.next) - $pid_off)
+		set $next_th=(((char *)$next_t->thread_group.next) - $pid_off)
 		while ($next_th != $next_t)
 			set $next_th=(struct task_struct *)$next_th
 			printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
 			printf "===================\n"
-			set var $stackp = $next_t.thread.esp
+			set var $stackp = $next_t.thread.sp
 			set var $stack_top = ($stackp & ~4095) + 4096
 
 			while ($stackp < $stack_top)
@@ -45,7 +45,7 @@ define bttnobp
 				end
 				set $stackp += 4
 			end
-			set $next_th=(((char *)$next_th->pids[1].pid_list.next) - $pid_off)
+			set $next_th=(((char *)$next_th->thread_group.next) - $pid_off)
 		end
 		set $next_t=(char *)($next_t->tasks.next) - $tasks_off
 	end
@@ -54,42 +54,43 @@ document bttnobp
 	dump all thread stack traces on a kernel compiled with !CONFIG_FRAME_POINTER
 end
 
+define btthreadstruct
+	set var $pid_task = $arg0
+
+	printf "\npid %d; comm %s:\n", $pid_task.pid, $pid_task.comm
+	printf "task struct: "
+	print $pid_task
+	printf "===================\n"
+	set var $stackp = $pid_task.thread.sp
+	set var $stack_top = ($stackp & ~4095) + 4096
+	set var $stack_bot = ($stackp & ~4095)
+
+	set $stackp = *((unsigned long *) $stackp)
+	while (($stackp < $stack_top) && ($stackp > $stack_bot))
+		set var $addr = *(((unsigned long *) $stackp) + 1)
+		info symbol $addr
+		set $stackp = *((unsigned long *) $stackp)
+	end
+end
+document btthreadstruct
+	 dump a thread stack using the given task structure pointer
+end
+
+
 define btt
 	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
-	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
+	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
 	set $init_t=&init_task
 	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
 	while ($next_t != $init_t)
 		set $next_t=(struct task_struct *)$next_t
-		printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
-		printf "===================\n"
-		set var $stackp = $next_t.thread.esp
-		set var $stack_top = ($stackp & ~4095) + 4096
-		set var $stack_bot = ($stackp & ~4095)
+		btthreadstruct $next_t
 
-		set $stackp = *($stackp)
-		while (($stackp < $stack_top) && ($stackp > $stack_bot))
-			set var $addr = *($stackp + 4)
-			info symbol $addr
-			set $stackp = *($stackp)
-		end
-
-		set $next_th=(((char *)$next_t->pids[1].pid_list.next) - $pid_off)
+		set $next_th=(((char *)$next_t->thread_group.next) - $pid_off)
 		while ($next_th != $next_t)
 			set $next_th=(struct task_struct *)$next_th
-			printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
-			printf "===================\n"
-			set var $stackp = $next_t.thread.esp
-			set var $stack_top = ($stackp & ~4095) + 4096
-			set var $stack_bot = ($stackp & ~4095)
-
-			set $stackp = *($stackp)
-			while (($stackp < $stack_top) && ($stackp > $stack_bot))
-				set var $addr = *($stackp + 4)
-				info symbol $addr
-				set $stackp = *($stackp)
-			end
-			set $next_th=(((char *)$next_th->pids[1].pid_list.next) - $pid_off)
+			btthreadstruct $next_th
+			set $next_th=(((char *)$next_th->thread_group.next) - $pid_off)
 		end
 		set $next_t=(char *)($next_t->tasks.next) - $tasks_off
 	end
@@ -101,7 +102,7 @@ end
 define btpid
 	set var $pid = $arg0
 	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
-	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
+	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
 	set $init_t=&init_task
 	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
 	set var $pid_task = 0
@@ -113,29 +114,18 @@ define btpid
 			set $pid_task = $next_t
 		end
 
-		set $next_th=(((char *)$next_t->pids[1].pid_list.next) - $pid_off)
+		set $next_th=(((char *)$next_t->thread_group.next) - $pid_off)
 		while ($next_th != $next_t)
 			set $next_th=(struct task_struct *)$next_th
 			if ($next_th.pid == $pid)
 				set $pid_task = $next_th
 			end
-			set $next_th=(((char *)$next_th->pids[1].pid_list.next) - $pid_off)
+			set $next_th=(((char *)$next_th->thread_group.next) - $pid_off)
 		end
 		set $next_t=(char *)($next_t->tasks.next) - $tasks_off
 	end
 
-	printf "\npid %d; comm %s:\n", $pid_task.pid, $pid_task.comm
-	printf "===================\n"
-	set var $stackp = $pid_task.thread.esp
-	set var $stack_top = ($stackp & ~4095) + 4096
-	set var $stack_bot = ($stackp & ~4095)
-
-	set $stackp = *($stackp)
-	while (($stackp < $stack_top) && ($stackp > $stack_bot))
-		set var $addr = *($stackp + 4)
-		info symbol $addr
-		set $stackp = *($stackp)
-	end
+	btthreadstruct $pid_task
 end
 document btpid
 	backtrace of pid
@@ -145,7 +135,7 @@ end
 define trapinfo
 	set var $pid = $arg0
 	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
-	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
+	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
 	set $init_t=&init_task
 	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
 	set var $pid_task = 0
@@ -157,13 +147,13 @@ define trapinfo
 			set $pid_task = $next_t
 		end
 
-		set $next_th=(((char *)$next_t->pids[1].pid_list.next) - $pid_off)
+		set $next_th=(((char *)$next_t->thread_group.next) - $pid_off)
 		while ($next_th != $next_t)
 			set $next_th=(struct task_struct *)$next_th
 			if ($next_th.pid == $pid)
 				set $pid_task = $next_th
 			end
-			set $next_th=(((char *)$next_th->pids[1].pid_list.next) - $pid_off)
+			set $next_th=(((char *)$next_th->thread_group.next) - $pid_off)
 		end
 		set $next_t=(char *)($next_t->tasks.next) - $tasks_off
 	end
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
