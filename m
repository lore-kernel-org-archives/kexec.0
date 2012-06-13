Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from plane.gmane.org ([80.91.229.3])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SedDf-0006Za-Q9
 for kexec@lists.infradead.org; Wed, 13 Jun 2012 02:22:05 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glkk-kexec@m.gmane.org>) id 1SedDS-0001KU-Sv
 for kexec@lists.infradead.org; Wed, 13 Jun 2012 04:21:50 +0200
Received: from 117.57.96.111 ([117.57.96.111])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Wed, 13 Jun 2012 04:21:50 +0200
Received: from xiyou.wangcong by 117.57.96.111 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Wed, 13 Jun 2012 04:21:50 +0200
From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: Kexec: where does the kernel image get relocated?
Date: Wed, 13 Jun 2012 02:21:34 +0000 (UTC)
Message-ID: <jr8tfd$enn$1@dough.gmane.org>
References: <9A3DED9B-FB11-49CC-A51E-40ED03E24999@vt.edu>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Thu, 07 Jun 2012 at 22:47 GMT, Ben Shelton <beshelto@vt.edu> wrote:
> Hi all,
>
> I'm working on a distributed-computing project where we'd like to boot multiple instances of the Linux kernel on the same machine.  We'd like to leverage kexec to decompress each guest kernel and copy it to an area within the physical address space.
>
> From following through the code and using GDB/QEMU, it seems like the steps to reboot with kexec look like this:
>
> - Decompress the kernel somewhere (not necessarily contiguous)
> - In relocate_kernel_64.S, copy the kernel to a contiguous space and jump/return to purgatory
> - In purgatory, reinitialize the hardware if necessary, then jump to the start of the kernel
>
> My issue is that I can't seem to find where the address to which the kernel is copied in step 2 is defined.  Can anyone give me a brief description of how this works?
>

The kernel relocates itself, you can check the code under
#ifdef CONFIG_RELOCATABLE in arch/x86/boot/compressed/head_64.S and
arch/x86/boot/compressed/misc.c.

Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
