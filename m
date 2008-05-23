Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jzdkr-0000N3-5N
	for kexec@lists.infradead.org; Fri, 23 May 2008 20:20:45 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <4836AC3C.3090005@in.ibm.com>
Date: Fri, 23 May 2008 13:14:42 -0700
In-Reply-To: <4836AC3C.3090005@in.ibm.com> (Sharyathi Nagesh's message of
	"Fri, 23 May 2008 17:06:28 +0530")
Message-ID: <m1ve144w25.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: correction to compat_sys_kexec_load
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sharyathi Nagesh <sharyath@in.ibm.com>
Cc: akpm@osdl.org, mohd.omar@in.ibm.com, IndhuDurai@in.ibm.com, maneesh@in.ltcfwd.linux.ibm.com, Kexec Mailing List <kexec@lists.infradead.org>, fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, mohan@in.ibm.com, sachinp@in.ibm.com

Sharyathi Nagesh <sharyath@in.ibm.com> writes:

> Hi
>   While testing with kexec tool, I observed some problems. When application
> (kexec) is 32 bit and kernel is 64 bit I observed that loading crash kernel
> works without any issues but unloading crash kernel fails.
> --------------------------------------------------------
> running strace over 'kexec -u -p'
> show the problem to be with sys_kexec_load() call
>
> sys_kexec_load(0, 0, 0, 0x1, 0)         = -1 EINVAL (Invalid argument)
> write(2, "kexec_load (0 segments) failed: "..., 49
> kexec_load (0 segments) failed: Invalid argument
> ) = 4

Yes.  This is a bug.  Although not in the kernel implementation.

> --------------------------------------------------------
>
> This is patch to fix the problem, I think kernel code had a typo where in:
> if((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH) was used instead of
> if((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH)

Nope.  We do the latter check after we have fixed up the arguments
and call sys_kexec_load.  The check really is meant to filter out
KEXEC_ARCH_DEFAULT.


> This patch takes care of that, I have tested the patch it worked fine for
> me. Please review the patch and let me know of your views. This patch is based
> on linux-2.6.26-rc3.

That patch as it exists is actively bad.  It removes the check for a really
nasty gotcha if someone passes in KEXEC_ARCH_DEFAULT in 32bit mode.  Code
expecting a 32bit handoff and getting a 64bit handoff will explode in fun
ways.  You happened to test the one corner case where this does not matter.

What we need to do is fix /sbin/kexec to pass in the correct
architecture of the kernel for unload as it does for load.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
