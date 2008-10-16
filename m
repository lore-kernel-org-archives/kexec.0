Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wa-out-1112.google.com ([209.85.146.180])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KqWwk-0004Fj-H6
	for kexec@lists.infradead.org; Thu, 16 Oct 2008 17:47:39 +0000
Received: by wa-out-1112.google.com with SMTP id v33so90352wah.2
	for <kexec@lists.infradead.org>; Thu, 16 Oct 2008 10:47:36 -0700 (PDT)
Message-ID: <ba7d8f720810161047p7d003901g35f969404fa77b0f@mail.gmail.com>
Date: Thu, 16 Oct 2008 13:47:36 -0400
From: "Dan Upton" <upton.dan.linux@gmail.com>
Subject: kexec on x86_64: entry32_regs not found cannot get
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org

Hi all,

I'm trying to use kexec to help debug some scheduler work I'm doing,
but I can't seem to get kexec to load the kernel.  I'm using
kexec-tols-testing-20080227.  I built my kernel as relocatable so I
can just use it for both the system kernel and the crash dump kernel.
Following the directions from kdump.txt under the Linx documentation
tree:

> /usr/local/sbin/kexec -p /boot/vmlinuz-2.6.24.3 --initrd=/boot/initrd-2.6.24.3.img --append="root=/dev/VolGroup00/LogVol00 1 irqpoll maxcpus=1 reset_devices"
Symbol: entry32_regs not found cannot get

The only thing I came across on Google for that error were two patches
on this list, http://lists.infradead.org/pipermail/kexec/2008-March/001444.html
and http://lists.infradead.org/pipermail/kexec/2008-March/001448.html
.  When I applied either of those patches and tried to rebuild, I get
a make error:

make: *** No rule to make target `purgatory/arch/x86_64/entry64-32.S',
needed by `purgatory/arch/x86_64/entry64-32.o'. Stop.

In fact, it doesn't look like the tarball I got has any of the .S
files in the makefile that should be under purgatory/arch/x86_64.  Any
help, or has there been another kexec release since then?

Thanks,
-dan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
