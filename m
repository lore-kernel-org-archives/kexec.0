Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IDE5N-0007aU-IW
	for kexec@lists.infradead.org; Tue, 24 Jul 2007 02:41:36 -0400
Subject: Re: Determine version of kernel that produced vmcore
In-reply-to: <46A518C6.5070108@redhat.com>
Message-Id: <20070724154150oomichi@mail.jp.nec.com>
References: <46A518C6.5070108@redhat.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Tue, 24 Jul 2007 15:41:50 +0900
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
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org


Hi Dave,

2007/07/23 17:08:22 -0400, Dave Anderson <anderson@redhat.com> wrote:
> > From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
>...
> >
> > BTW, we should test makedumpfile by each linux(-rc1 ?) releases.
> > Now, I test the makedumpfile functions by comparing the crash utility's
> > output of /proc/vmcore and the one of the filtered dumpfile.
> > Often, the crash utility cannot read /proc/vmcore of the latest kernel.
> > Does anybody know the crash's option that the crash can run loosely for
> > the early test ?
>
>There is no "loosely-run" option for the crash utility.
>
>When you state "cannot read /proc/vmcore", I'm presuming that
>you mean that something fails during initialization due to
>the "shifting sands" of the upstream kernel (and which should
>be reported to the crash-utility list so that it can be
>addressed...)

As you said, I saw some problems that the crash utility failed
during the initialization. I will report them to the crash-utility
list if I find them.


>There are a couple debug-only options that prevent crash from
>accessing certain subsystems during initialization, such as
>"--no_kmem_cache" to avoid traversing the kmalloc/slab subsystem,
>and "--no_modules" to avoid traversing the vmalloc'd module list.
>Those two may help if you have an "incomplete" dumpfile that is
>missing pages that *should* be there.  There's also a "-f" to
>force the use of split vmlinux/vmlinux.debug pair whose CRC's
>do not match.  But if you're using a simple -g build vmlinux
>files, that option wouldn't apply.

Thank you for the information.
I will use the above options until we update the crash utility.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
