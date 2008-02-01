Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out1.libero.it ([212.52.84.41])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JKsqF-0001ZT-Bb
	for kexec@lists.infradead.org; Fri, 01 Feb 2008 10:09:57 +0000
Received: from mailrelay12.libero.it (192.168.32.131) by smtp-out1.libero.it
	(7.3.120) id 47137F850A3A18ED for kexec@lists.infradead.org;
	Fri, 1 Feb 2008 11:09:50 +0100
Date: Fri,  1 Feb 2008 11:08:01 +0100
Message-Id: <JVK1HD$5366A883E65055C12EDC0F157808300E@libero.it>
Subject: kexec problem on SH platform nr 2
MIME-Version: 1.0
From: "paolo\.cortesi\@inwind\.it" <paolo.cortesi@inwind.it>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec <kexec@lists.infradead.org>

Hi,
my name is Paolo Cortesi I'am working over one SH4 platform board ST71XX wi=
th linux kernel 2.6.17.

I need to spawn a new Linux kernel over the Linux Kernel which is running, =
without the overhead of boot firmware, and I think that your kexec-tool cou=
ld be suitable for this target.
 =

I try to use kexec following the steps:

1) I select the CONFIG_KEXEC option while building the runnig kernel.

2) I download your last recent version of kexec-tool which support SH4 plat=
form

   I used your .gz reachable by link:    =

   http://www.vergenet.net/linux/kexec/kexec-tools/

3) I launch the the configure by my script:

	export CC=3Dsh4-linux-uclibc-gcc
	export LD=3Dsh4-linux-uclibc-ld
	export AR=3Dsh4-linux-uclibc-ar
	export CFLAGS=3D"-DSHLINUX -D__SHLINUX__ -Wall -O2 -ml -m4 -pipe -fomit-fr=
ame-pointer -fno-strict-aliasing"
	./configure --host=3Dsh4-linux =


4) I cross compile. During compilation I comment the invoke of /*crash_setu=
p_regs(&fixed_regs, regs);*/ procedure that's called in crash_kexec procedu=
re of kernel/kexec.c file (I could not find any implementation of this proc=
edure).

5) I launch the runnig kernel, which execute:
   kexec -l new_zImage --./kexec -l zImage --type=3DzImage-sh --append=3D"c=
ommand_line"
   kexec -e

Should be the wright procedure.

But I have one NULL pointer deferenced when it=B4s called the last assemble=
r procedure
reboot_code_buffer (relocate_new_kernel) which is invoked in the kernel C p=
rocedure arch/sh/... machine_kexec.c

Have you got an idea of the problem? Have you ever run your tool using one =
intrd kernel running

Thanks in advance.

Paolo Cortesi.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
