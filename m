Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IM0vi-0004ni-VT
	for kexec@lists.infradead.org; Fri, 17 Aug 2007 08:27:56 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7HCRlps009437
	for <kexec@lists.infradead.org>; Fri, 17 Aug 2007 08:27:47 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7HCRloZ467104
	for <kexec@lists.infradead.org>; Fri, 17 Aug 2007 08:27:47 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7HCRlB2024589
	for <kexec@lists.infradead.org>; Fri, 17 Aug 2007 08:27:47 -0400
Date: Fri, 17 Aug 2007 17:58:03 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [RFC][PATCH 1/3] Embed vmcoreinfo into kernel file
Message-ID: <20070817122803.GB18167@in.ibm.com>
References: <20070816042008.GB20860@in.ibm.com>
	<20070817154331oomichi@mail.jp.nec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070817154331oomichi@mail.jp.nec.com>
Reply-To: vgoyal@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, Bernhard Walle <bwalle@suse.de>, kexec-ml <kexec@lists.infradead.org>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>

On Fri, Aug 17, 2007 at 03:43:31PM +0900, Ken'ichi Ohmichi wrote:
[..]
> >- There is another important field which I would like to see in vmcoreinfo
> >  and that is time of crash (lets say CRASH_TIME). This will indicate the
> >  timestamp when did system actually crash. One can read the time in
> >  crash_kexec(), fill in the field and then save vmcore info note.
> >
> >  For this, either you need to scan the vmcoreinfo note again and fill in
> >  the time stamp. Or you need to do vmcoreinfo note saving after crash
> >  instead of boot time.
> 
> Is it necessary of the field for timestamp ?
> The crash utility can display the time of crash already like the following.
> 
> # crash vmlinux vmcore
> [snip]
>       KERNEL: vmlinux
>     DUMPFILE: vmcore
>         CPUS: 2
>         DATE: Tue Jul 10 20:41:50 2007  <- Here
>       UPTIME: 00:04:58
> LOAD AVERAGE: 0.12, 0.22, 0.11
>        TASKS: 88
>     NODENAME: peak
>      RELEASE: 2.6.16.46-0.12-default
>      VERSION: #1 SMP Thu May 17 14:00:09 UTC 2007
>      MACHINE: ia64  (1000 Mhz)
>       MEMORY: 5.5 GB
>        PANIC: "SysRq : Trigger a crashdump"
>          PID: 3455
>      COMMAND: "bash"
>         TASK: e0000040f2f40000  [THREAD_INFO: e0000040f2f410d0]
>          CPU: 0
>        STATE: TASK_RUNNING (SYSRQ)
> 
> 

But this requires a debug compiled vmlinux to be available on the system
and that's a rarity. For example, we are exporting UTSNAME also which 
can be retrieved by opening vmcore with crash.

By exporting this, now one can write a small utility in second kernel,
which can just look at the /proc/vmcore in second kernel, determine that
machine had crashed and send a notification over network to other machine
with crash time stamp.
 
[..]
> +#define SYMBOL(name) \
> +	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
> +#define SIZE(name) \
> +	vmcoreinfo_append_str("SIZE(%s)=%d\n", #name, sizeof(struct name))
> +#define OFFSET(name, field) \
> +	vmcoreinfo_append_str("OFFSET(%s.%s)=%d\n", #name, #field, &(((struct name *)0)->field))
> +#define LENGTH(name, value) \
> +	vmcoreinfo_append_str("LENGTH(%s)=%d\n", #name, value)
> +#define CONFIG(name) \
> +	vmcoreinfo_append_str("CONFIG_%s=%c\n", #name, CONFIG_##name)
> +

Have you tested CONFIG(). For me it did not work? Are you getting output
like CONFIG_KEXEC=y with above macro?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
