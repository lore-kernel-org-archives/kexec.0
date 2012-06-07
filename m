Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lennier.cc.vt.edu ([198.82.162.213])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SclUx-0007t5-IA
 for kexec@lists.infradead.org; Thu, 07 Jun 2012 22:48:12 +0000
Received: from dagger.cc.vt.edu (dagger.cc.vt.edu [198.82.163.114])
 by lennier.cc.vt.edu (8.13.8/8.13.8) with ESMTP id q57MlesD003567
 for <kexec@lists.infradead.org>; Thu, 7 Jun 2012 18:47:40 -0400
From: Ben Shelton <beshelto@vt.edu>
Subject: Kexec: where does the kernel image get relocated?
Date: Thu, 7 Jun 2012 18:47:35 -0400
Message-Id: <9A3DED9B-FB11-49CC-A51E-40ED03E24999@vt.edu>
Mime-Version: 1.0 (Apple Message framework v1278)
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
Cc: Antonio Barbalace <antoniob@vt.edu>

Hi all,

I'm working on a distributed-computing project where we'd like to boot multiple instances of the Linux kernel on the same machine.  We'd like to leverage kexec to decompress each guest kernel and copy it to an area within the physical address space.

From following through the code and using GDB/QEMU, it seems like the steps to reboot with kexec look like this:

- Decompress the kernel somewhere (not necessarily contiguous)
- In relocate_kernel_64.S, copy the kernel to a contiguous space and jump/return to purgatory
- In purgatory, reinitialize the hardware if necessary, then jump to the start of the kernel

My issue is that I can't seem to find where the address to which the kernel is copied in step 2 is defined.  Can anyone give me a brief description of how this works?

Thanks,
Ben
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
