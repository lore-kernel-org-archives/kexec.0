Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-da0-f44.google.com ([209.85.210.44])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UZSIC-0004Cz-UB
 for kexec@lists.infradead.org; Mon, 06 May 2013 20:45:54 +0000
Received: by mail-da0-f44.google.com with SMTP id z8so1995177daj.31
 for <kexec@lists.infradead.org>; Mon, 06 May 2013 13:45:26 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 6 May 2013 22:45:26 +0200
Message-ID: <CAKwJggYX4hnsMBtGz82y40xzUiR6c7FRYvmLpacUMjcNeEayrw@mail.gmail.com>
Subject: kernel parameter 'memmap ' is failing to ioremap with error
 "Malformed early option memmap"
From: Mehul Wagle <mehulwagle@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

I am on SUSE 11 (Patch 1) and trying to boot the kernel with param
=91memmap=92 (i.e. memmap=3D<SizeInG>$<StartAddrInG>). The intention is to
reserve <SizeInG> GB portion of the memory starting at address
<StartAddrInG>.


Example:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Added the parameter =93memmap=3D100G\$4G=94 to kernel boot commandline via =
yast
(NOTE: Escape character is needed for Grub2 loader)


Effect:
=3D=3D=3D=3D=3D=3D
$ cat /proc/cmdline

root=3D/dev/disk/by-id/scsi-3600605b000f5ae5014d40a7c099e544c-part2
resume=3D/dev/disk/by-id/scsi-3600605b000f5ae5014d40a7c099e544c-part1
splash=3Dsilent memmap=3D100G\$4G


Error faced during kernel boot (snippet from dmesg):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    0.000000] Malformed early option 'memmap
=85
[ 1109.873280] ioremap of the image failed(1)


Question:
=3D=3D=3D=3D=3D=3D=3D=3D
Is this a bug with kexec or some other known problem? Would appreciate
any help from the forum.

Regards,
Mehul Wagle

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
