Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1azwnE-0004xn-31
 for kexec@lists.infradead.org; Tue, 10 May 2016 01:49:00 +0000
Date: Tue, 10 May 2016 09:48:35 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kdump: Fix gdb macros work work with newer and 64-bit
 kernels
Message-ID: <20160510014835.GB2629@x1.redhat.com>
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

Hi Corey,

On 05/09/16 at 07:10am, Corey Minyard wrote:
> >>>diff --git a/Documentation/kdump/gdbmacros.txt b/Documentation/kdump/gdbmacros.txt
> >>>index 9b9b454..e5bbd8d 100644
> >>>--- a/Documentation/kdump/gdbmacros.txt
> >>>+++ b/Documentation/kdump/gdbmacros.txt
> >>>@@ -54,42 +54,43 @@ document bttnobp
> >>>  	dump all thread stack traces on a kernel compiled with !CONFIG_FRAME_POINTER
> >>>  end
> >>>+define btthreadstruct
> >This is a nice wrapping, but I guess you want to name it as
> >btthreadstack, right? Since I didn't get at all why it's related to
> >thread_struct except of getting 'sp'.
> >
> 
> The name is based on what is passed into the function.  You do a
> backtrace when given a thread structure.  In my experience it is
> best to name functions based upon how the function's user sees it.
> Though I'm not stuck on the name, if you would prefer btthreadstack.

About the name, in fact a task struct is passed in. Mainly there's a
thread_struct defined in x86 ARCH, I thought you are handling
thread_struct related things when I look at the first glance.
btthreadstack is far better name that that, I like it.

******************************
arch/x86/include/asm/processor.h
struct thread_struct {         
        /* Cached TLS descriptors: */   
        struct desc_struct      tls_array[GDT_ENTRY_TLS_ENTRIES];
        unsigned long           sp0;    
        unsigned long           sp;     
#ifdef CONFIG_X86_32           
        unsigned long           sysenter_cs;
#else
......
}

Thanks
Baoquan

> 
> >>>+	set var $pid_task = $arg0
> >>>+
> >>>+	printf "\npid %d; comm %s:\n", $pid_task.pid, $pid_task.comm
> >>>+	printf "task struct: "
> >>>+	print $pid_task
> >>>+	printf "===================\n"
> >>>+	set var $stackp = $pid_task.thread.sp
> >>>+	set var $stack_top = ($stackp & ~4095) + 4096
> >>>+	set var $stack_bot = ($stackp & ~4095)
> >>>+
> >>>+	set $stackp = *((unsigned long *) $stackp)
> >>>+	while (($stackp < $stack_top) && ($stackp > $stack_bot))
> >>>+		set var $addr = *(((unsigned long *) $stackp) + 1)
> >>>+		info symbol $addr
> >>>+		set $stackp = *((unsigned long *) $stackp)
> >>>+	end
> >>>+end
> >>>+document btthreadstruct
> >>>+	 dump a thread stack using the given task structure pointer
> >>>+end

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
