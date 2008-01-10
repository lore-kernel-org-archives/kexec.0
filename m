Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailwasher.lanl.gov ([204.121.3.2])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JClhZ-0006h0-UN
	for kexec@lists.infradead.org; Thu, 10 Jan 2008 00:55:29 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailwasher.lanl.gov (Postfix) with ESMTP id BC473EC8104
	for <kexec@lists.infradead.org>; Wed,  9 Jan 2008 17:45:32 -0700 (MST)
Received: from mailwasher.lanl.gov (localhost.localdomain [127.0.0.1])
	by mailwasher.lanl.gov (Postfix) with ESMTP id 92DD6EC8324
	for <kexec@lists.infradead.org>; Wed,  9 Jan 2008 17:45:32 -0700 (MST)
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
	by mailwasher.lanl.gov (Postfix) with ESMTP id 8F009EC8104
	for <kexec@lists.infradead.org>; Wed,  9 Jan 2008 17:45:32 -0700 (MST)
Received: from nmt-mail.lanl.gov (nmt-mail.lanl.gov [128.165.4.122])
	by mailrelay2.lanl.gov (8.13.8/8.13.8/(ccn-5)) with ESMTP id
	m0A0jW5J030259
	for <kexec@lists.infradead.org>; Wed, 9 Jan 2008 17:45:32 -0700
Received: from [128.165.248.199] (glacier.lanl.gov [128.165.248.199])
	by nmt-mail.lanl.gov (Postfix) with ESMTP id F147121C002
	for <kexec@lists.infradead.org>; Wed,  9 Jan 2008 17:45:28 -0700 (MST)
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <8B2A78E5-2911-4F96-91AD-BEE846B76B4A@lanl.gov>
From: kevint <kevint@lanl.gov>
Subject: x86_64 kernel relocation question
Date: Wed, 9 Jan 2008 17:45:28 -0700
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0745189163=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


--===============0745189163==
Content-Type: multipart/alternative; boundary=Apple-Mail-17-427912458


--Apple-Mail-17-427912458
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hello,

I am relatively new to kexec, and am running into some problems with  
relocations when I try to use kexec to load several different X86_64  
kernels.  I think this is the correct list to post to, but please  
point me in the right direction if it isn't.

Here is some of the information on my test environment:

$ kexec --version
kexec-tools-testing 20071030 released 30th October 2007

$ uname -r
2.6.21.5

RHEL5 Kernel:
$ file /tmp/vmlinuz
/tmp/vmlinuz: ELF 64-bit LSB shared object, AMD x86-64, version 1,  
stripped

Buildroot generated kernel (bzImage) with initramfs:
# file /tmp/linux-kernel-2.6.21.5-x86_64
/tmp/linux-kernel-2.6.21.5-x86_64: Linux kernel x86 boot executable  
RO-rootFS, root_dev 0x801, swap_dev 0x5, Normal VGA

Here is the output I am getting:
(note:  I usually have more options, but i get same errors regardless)

$ kexec -l /tmp/vmlinuz
Unhandled rela relocation: 4258616

I noticed this line in the source file, kexec/arch/x86_64/kexec-elf- 
rel-x86_64.c:

die("Unhandled rela relocation: %lu\n", reloc_name(r_type));

I figured %lu should be %s, so I changed it, and got the following  
output:

$ kexec -l /tmp/vmlinuz
Unhandled rela relocation: R_X86_64_PLT32

I noticed that it is not handled by kexec/arch/x86_64/kexec-elf-rel- 
x86_64.c, so figured I either am trying to kexec an incompatible  
kernel image or this relocation needs to be handled.  I made it  
further by hacking in a (non-working) case for this relocation type,  
but then came across R_X86_64_GOTPCREL.  I don't think calculating  
the relocation address for a PLT or a GOT relocation is trivial, so I  
am hoping I am doing something else wrong.

I would appreciate any help you can provide.

Thank you!

********************************************
Kevin Tegtmeier
HPC-3 Scientific Computing Resources
Los Alamos National Laboratory
email:  kevint at lanl dot gov
********************************************




--Apple-Mail-17-427912458
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; ">Hello,<DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I am relatively new to =
kexec, and am running into some problems with relocations when I try to =
use kexec to load several different X86_64 kernels.=A0 I think this is =
the correct list to post to, but please point me in the right direction =
if it isn't.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Here is some of the =
information on my test environment:</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>$ kexec =
--version</DIV><DIV>kexec-tools-testing 20071030 released 30th October =
2007</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>$ uname =
-r </DIV><DIV>2.6.21.5</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>RHEL5 =
Kernel:</DIV><DIV>$=A0file /tmp/vmlinuz </DIV><DIV>/tmp/vmlinuz: ELF =
64-bit LSB shared object, AMD x86-64, version 1, stripped</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Buildroot generated kernel =
(bzImage) with initramfs:</DIV><DIV># file =
/tmp/linux-kernel-2.6.21.5-x86_64 =
</DIV><DIV>/tmp/linux-kernel-2.6.21.5-x86_64: Linux kernel x86 boot =
executable RO-rootFS, root_dev 0x801, swap_dev 0x5, Normal =
VGA</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>Here is =
the output I am getting:</DIV><DIV>(note:=A0 I usually have more =
options, but i get same errors regardless)</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>$ kexec -l /tmp/vmlinuz =
</DIV><DIV>Unhandled rela relocation: 4258616</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I noticed this line in the =
source file, kexec/arch/x86_64/kexec-elf-rel-x86_64.c:</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>die("Unhandled rela =
relocation: %lu\n", reloc_name(r_type));</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I figured %lu should be %s, =
so I changed it, and got the following output:</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>$ kexec -l =
/tmp/vmlinuz</DIV><DIV>Unhandled rela relocation: =
R_X86_64_PLT32</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I noticed that it is not =
handled by=A0kexec/arch/x86_64/kexec-elf-rel-x86_64.c, so figured I =
either am trying to kexec an incompatible kernel image or this =
relocation needs to be handled.=A0 I made it further by hacking in a =
(non-working) case for this relocation type, but then came =
across=A0R_X86_64_GOTPCREL.=A0 I don't think calculating the relocation =
address for a PLT or a GOT relocation is trivial, so I am hoping I am =
doing something else wrong.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I would appreciate any help =
you can provide.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Thank =
you!</DIV><DIV><BR><DIV> <SPAN class=3D"Apple-style-span" =
style=3D"border-collapse: separate; border-spacing: 0px 0px; color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><DIV>********************************************</DIV><DIV>Kevin =
Tegtmeier</DIV><DIV>HPC-3 Scientific Computing Resources</DIV><DIV>Los =
Alamos National Laboratory</DIV><DIV>email:=A0 kevint at lanl dot =
gov</DIV><DIV>********************************************</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN> =
</DIV><BR></DIV></BODY></HTML>=

--Apple-Mail-17-427912458--


--===============0745189163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0745189163==--

