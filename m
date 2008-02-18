Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out2.libero.it ([212.52.84.42])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JR9IG-0003oG-6V
	for kexec@lists.infradead.org; Mon, 18 Feb 2008 16:56:40 +0000
Received: from MailRelay10.libero.it (192.168.32.119) by smtp-out2.libero.it
	(7.3.120) id 4688F31B177639AC for kexec@lists.infradead.org;
	Mon, 18 Feb 2008 17:48:31 +0100
Date: Mon, 18 Feb 2008 17:44:06 +0100
Message-Id: <JWG15I$EBDC9FA8F8CDE357E3E6CD9A2C5E20CF@libero.it>
Subject: Re:kexec problem on SH platform nr 2
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec <kexec@lists.infradead.org>
Cc: "matteo.pampolini" <matteo.pampolini@elsagdatamat.com>

Please please help me.

Hello,
I am still hacking the kexec-tool over SH4 platform using Paul suggests, bu=
t I have still the problem.

First I try to change the flags passed to kexec_load(..,..,..,kexec_flags).
In kexec-tools it was set to KEXEC_ARCH_DEFAULT; I set it KEXEC_ARCH_SH as =
well as in kernel include/linux/kexec.h =


Then I changed the:
P1 (0x80000000) + memory start (0x0c000000) + 0x00210000 or'ed in zImage_sh=
_load() that you suggested
in such way:
CONFIG_PAGE_OFFSET(0x80000000) + CONFIG_MEMORY_START (0x04400000) + CONFIG_=
BOOT_LINK_OFFSET (0x0080000)

and I changed the initiliaziation start memory range to set available my CO=
NFIG_MEMORY_START address.

The log that I got is the follow and I can=B4t see the new kernel really re=
stating, after I lauch

./kexec -l new_zImage --type=3DzImage-sh --append=3D"console=3DttyAS1,11520=
0" --empty-zero=3D84401000


The log....
....
empty_zero =3D 0x04401000
area =3D 0x04400000
Starting new kernel
kexec information
  segment[0]: 0x04401000 - 0x04402000 (0x00001000)
  segment[1]: 0x04c00000 - 0x04d5a000 (0x0015a000)
  start     : 0x84c00000

Can you still see any error?

Sincerely

Paolo Cortesi


> Hi,
> my name is Paolo Cortesi I'am working over one SH4 platform board ST71XX =
with linux kernel 2.6.17.
> =

> I need to spawn a new Linux kernel over the Linux Kernel which is running=
, without the overhead of boot firmware, and I think that your kexec-tool c=
ould be suitable for this target.
>  =

> I try to use kexec following the steps:
> =

> 1) I select the CONFIG_KEXEC option while building the runnig kernel.
> =

> 2) I download your last recent version of kexec-tool which support SH4 pl=
atform
> =

>    I used your .gz reachable by link:    =

>    http://www.vergenet.net/linux/kexec/kexec-tools/
> =

> 3) I launch the the configure by my script:
> =

> 	export CC=3Dsh4-linux-uclibc-gcc
> 	export LD=3Dsh4-linux-uclibc-ld
> 	export AR=3Dsh4-linux-uclibc-ar
> 	export CFLAGS=3D"-DSHLINUX -D__SHLINUX__ -Wall -O2 -ml -m4 -pipe -fomit-=
frame-pointer -fno-strict-aliasing"
> 	./configure --host=3Dsh4-linux =

> =

> 4) I cross compile. During compilation I comment the invoke of /*crash_se=
tup_regs(&fixed_regs, regs);*/ procedure that's called in crash_kexec proce=
dure of kernel/kexec.c file (I could not find any implementation of this pr=
ocedure).
> =

> 5) I launch the runnig kernel, which execute:
>    kexec -l new_zImage --./kexec -l zImage --type=3DzImage-sh --append=3D=
"command_line"
>    kexec -e
> =

> Should be the wright procedure.
> =

> But I have one NULL pointer deferenced when it=B4s called the last assemb=
ler procedure
> reboot_code_buffer (relocate_new_kernel) which is invoked in the kernel C=
 procedure arch/sh/... machine_kexec.c
> =

> Have you got an idea of the problem? Have you ever run your tool using on=
e intrd kernel running
> =

> Thanks in advance.
> =

> Paolo Cortesi.
> =

> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
