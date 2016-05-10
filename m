Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1azwcT-0000EV-7W
 for kexec@lists.infradead.org; Tue, 10 May 2016 01:37:53 +0000
Date: Tue, 10 May 2016 09:37:28 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kdump: Fix gdb macros work work with newer and 64-bit
 kernels
Message-ID: <20160510013728.GA2629@x1.redhat.com>
References: <1456408291-29559-1-git-send-email-minyard@acm.org>
 <5720AEDC.3080409@acm.org> <20160509051724.GA2460@x1.redhat.com>
 <57307E53.4060300@acm.org> <20160509142953.GA2978@x1>
 <5730AF76.3000608@mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5730AF76.3000608@mvista.com>
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
To: Corey Minyard <cminyard@mvista.com>
Cc: Corey Minyard <minyard@acm.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On 05/09/16 at 10:40am, Corey Minyard wrote:
> >>>>>  define bttnobp
> >>>>>  	set $tasks_off=((size_t)&((struct task_struct *)0)->tasks)
> >>>>>-	set $pid_off=((size_t)&((struct task_struct *)0)->pids[1].pid_list.next)
> >>>>>+	set $pid_off=((size_t)&((struct task_struct *)0)->thread_group.next)
> >>>This is a quite nice fix.
> >>>
> >>>>>  	set $init_t=&init_task
> >>>>>  	set $next_t=(((char *)($init_t->tasks).next) - $tasks_off)
> >>>>>  	while ($next_t != $init_t)
> >>>>>  		set $next_t=(struct task_struct *)$next_t
> >>>>>  		printf "\npid %d; comm %s:\n", $next_t.pid, $next_t.comm
> >>>>>  		printf "===================\n"
> >>>>>-		set var $stackp = $next_t.thread.esp
> >>>>>+		set var $stackp = $next_t.thread.sp
> >>>>>  		set var $stack_top = ($stackp & ~4095) + 4096
> >Missed one place here. Currently the kernel stack is decided by
> >THREAD_SIZE since the definition:
> >
> >union thread_union {
> >         struct thread_info thread_info;
> >         unsigned long stack[THREAD_SIZE/sizeof(long)];
> >};
> >
> >Should we get the top and bottom of stack according to this now?
> >
> >Correct me if I was wrong.
> 
> I think you are correct.  We should use something like:
> 
>    set var $stack_top = ($stackp & ~(sizeof(thread_union) - 1)) +
>    sizeof(thread_union)
> 
> Is this what you are suggesting?

Exactly, it's cool. Thanks!



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
