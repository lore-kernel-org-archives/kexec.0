Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1azmCT-0005HX-9y
 for kexec@lists.infradead.org; Mon, 09 May 2016 14:30:22 +0000
Date: Mon, 9 May 2016 22:29:53 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kdump: Fix gdb macros work work with newer and 64-bit
 kernels
Message-ID: <20160509142953.GA2978@x1>
References: <1456408291-29559-1-git-send-email-minyard@acm.org>
 <5720AEDC.3080409@acm.org> <20160509051724.GA2460@x1.redhat.com>
 <57307E53.4060300@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <57307E53.4060300@acm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Corey Minyard <minyard@acm.org>
Cc: Corey Minyard <cminyard@mvista.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On 05/09/16 at 07:10am, Corey Minyard wrote:
> On 05/09/2016 12:18 AM, Baoquan He wrote:
> >Hi Corey,
> >
> >I am trying to review this patch now, and these fixes contained are very
> >great. Just several concerns are added in inline comment.
> >
> >By the way, did you run this in your side?
> 
> Yes, I tested on x86, x86_64, ARM and MIPS.
> 
> Comments inline...

That's awesome. I will have a try too.

> >>>diff --git a/Documentation/kdump/gdbmacros.txt b/Documentation/kdump/gdbmacros.txt
> >>>index 9b9b454..e5bbd8d 100644
> >>>--- a/Documentation/kdump/gdbmacros.txt
> >>>+++ b/Documentation/kdump/gdbmacros.txt
> >>>@@ -15,14 +15,14 @@
> >>>  define bttnobp
> >>>  	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
> >>>-	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
> >>>+	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
> >This is a quite nice fix.
> >
> >>>  	set $init_t=&init_task
> >>>  	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
> >>>  	while ($next_t != $init_t)
> >>>  		set $next_t=(struct task_struct *)$next_t
> >>>  		printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
> >>>  		printf "===================\n"
> >>>-		set var $stackp = $next_t.thread.esp
> >>>+		set var $stackp = $next_t.thread.sp
> >>>  		set var $stack_top = ($stackp & ~4095) + 4096

Missed one place here. Currently the kernel stack is decided by
THREAD_SIZE since the definition:

union thread_union {
        struct thread_info thread_info;
        unsigned long stack[THREAD_SIZE/sizeof(long)];
};

Should we get the top and bottom of stack according to this now?

Correct me if I was wrong.

Thanks
Baoquan

> >>>  		while ($stackp < $stack_top)
> >>>@@ -31,12 +31,12 @@ define bttnobp
> >>>  			end
> >>>  			set $stackp += 4
> >>>  		end

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
