Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x242.google.com ([2607:f8b0:400e:c03::242])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b0I3e-0006Xe-Gi
 for kexec@lists.infradead.org; Wed, 11 May 2016 00:31:23 +0000
Received: by mail-pa0-x242.google.com with SMTP id i5so2249928pag.3
 for <kexec@lists.infradead.org>; Tue, 10 May 2016 17:31:01 -0700 (PDT)
From: minyard@acm.org
Subject: [PATCH v2] kdump: Fix gdb macros work work with newer and 64-bit
 kernels
Date: Tue, 10 May 2016 19:30:55 -0500
Message-Id: <1462926655-9390-1-git-send-email-minyard@acm.org>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>
Cc: Corey Minyard <cminyard@mvista.com>, minyard@acm.org

From: Corey Minyard <cminyard@mvista.com>

Lots of little changes needed to be made to clean these up, remove the
four byte pointer assumption and traverse the pid queue properly.
Also consolidate the traceback code into a single function instead
of having three copies of it.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---

Changes since v1:

Rename btthreadstruct to btthreadstack

Use sizeof(union thread_union) for the stack size instead of a hardcoded
4096.

 Documentation/kdump/gdbmacros.txt | 96 ++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 52 deletions(-)

diff --git a/Documentation/kdump/gdbmacros.txt b/Documentation/kdump/gdbmacros.txt
index 9b9b454..35f6a98 100644
--- a/Documentation/kdump/gdbmacros.txt
+++ b/Documentation/kdump/gdbmacros.txt
@@ -15,15 +15,16 @@
 
 define bttnobp
 	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
-	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
+	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
 	set $init_t=&init_task
 	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
+	set var $stacksize = sizeof(union thread_union)
 	while ($next_t != $init_t)
 		set $next_t=(struct task_struct *)$next_t
 		printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
 		printf "===================\n"
-		set var $stackp = $next_t.thread.esp
-		set var $stack_top = ($stackp & ~4095) + 4096
+		set var $stackp = $next_t.thread.sp
+		set var $stack_top = ($stackp & ~($stacksize - 1)) + $stacksize
 
 		while ($stackp < $stack_top)
 			if (*($stackp) > _stext && *($stackp) < _sinittext)
@@ -31,13 +32,13 @@ define bttnobp
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
-			set var $stack_top = ($stackp & ~4095) + 4096
+			set var $stackp = $next_t.thread.sp
+			set var $stack_top = ($stackp & ~($stacksize - 1)) + stacksize
 
 			while ($stackp < $stack_top)
 				if (*($stackp) > _stext && *($stackp) < _sinittext)
@@ -45,7 +46,7 @@ define bttnobp
 				end
 				set $stackp += 4
 			end
-			set $next_th=(((char *)$next_th->pids[1].pid_list.next) - $pid_off)
+			set $next_th=(((char *)$next_th->thread_group.next) - $pid_off)
 		end
 		set $next_t=(char *)($next_t->tasks.next) - $tasks_off
 	end
@@ -54,42 +55,44 @@ document bttnobp
 	dump all thread stack traces on a kernel compiled with !CONFIG_FRAME_POINTER
 end
 
+define btthreadstack
+	set var $pid_task = $arg0
+
+	printf "\npid %d; comm %s:\n", $pid_task.pid, $pid_task.comm
+	printf "task struct: "
+	print $pid_task
+	printf "===================\n"
+	set var $stackp = $pid_task.thread.sp
+	set var $stacksize = sizeof(union thread_union)
+	set var $stack_top = ($stackp & ~($stacksize - 1)) + $stacksize
+	set var $stack_bot = ($stackp & ~($stacksize - 1))
+
+	set $stackp = *((unsigned long *) $stackp)
+	while (($stackp < $stack_top) && ($stackp > $stack_bot))
+		set var $addr = *(((unsigned long *) $stackp) + 1)
+		info symbol $addr
+		set $stackp = *((unsigned long *) $stackp)
+	end
+end
+document btthreadstack
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
-
-		set $stackp = *($stackp)
-		while (($stackp < $stack_top) && ($stackp > $stack_bot))
-			set var $addr = *($stackp + 4)
-			info symbol $addr
-			set $stackp = *($stackp)
-		end
+		btthreadstack $next_t
 
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
+			btthreadstack $next_th
+			set $next_th=(((char *)$next_th->thread_group.next) - $pid_off)
 		end
 		set $next_t=(char *)($next_t->tasks.next) - $tasks_off
 	end
@@ -101,7 +104,7 @@ end
 define btpid
 	set var $pid = $arg0
 	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
-	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
+	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
 	set $init_t=&init_task
 	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
 	set var $pid_task = 0
@@ -113,29 +116,18 @@ define btpid
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
+	btthreadstack $pid_task
 end
 document btpid
 	backtrace of pid
@@ -145,7 +137,7 @@ end
 define trapinfo
 	set var $pid = $arg0
 	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
-	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
+	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
 	set $init_t=&init_task
 	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
 	set var $pid_task = 0
@@ -157,13 +149,13 @@ define trapinfo
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
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
