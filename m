Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from duck.dooz.org ([194.146.227.125])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Np1XC-0006ug-Ok
	for kexec@lists.infradead.org; Tue, 09 Mar 2010 15:39:54 +0000
Received: from bee.dooz.org (serris.dooz.org [88.166.229.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by duck.dooz.org (Postfix) with ESMTP id 8ED43C809C
	for <kexec@lists.infradead.org>; Tue,  9 Mar 2010 16:39:49 +0100 (CET)
Date: Tue, 9 Mar 2010 16:39:48 +0100
From: =?iso-8859-1?Q?Lo=EFc?= Minier <lool@dooz.org>
Subject: Trouble with vmlinuz (bzImage) but works with vmlinux (uncompressed)
Message-ID: <20100309153948.GB9004@bee.dooz.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

        Hey folks

 I'm testing kexec on ARM under qemu-system-arm with a mach-versatile
 kernel (lightly patched).  kexec only works if I pass a vmlinux, but
 hangs if I pass a vmlinuz.  This sounds like an address computation
 issue to me.

 It would seem to me there are two issues here:
 - kexec-tools should work in both cases, perhaps the address
   computation is wrong when using a bzImage?
 - kexec-tools should uncompress the vmlinuz kernel into a vmlinux one
   before loading it as to allow skipping the "Uncompressing Linux..."
   step at kexec -e time -- would make the actual kernel switch a faster
   operation.

 What do you folks think?

 If people want to reproduce, kernel can be grabbed from:
    http://ports.ubuntu.com/ubuntu-ports/dists/lucid/main/installer-armel/c=
urrent/images/versatile/netboot/
 you'll need some rootfs such as an Ubuntu lucid (10.04) armel
 userspace.  I'm using this kernel to start qemu and am converting it to
 vmlinux with the attached script.

 Instructions to reproduce are available in the Ubuntu bug where we
 track this at:
    https://bugs.launchpad.net/ubuntu/+source/linux/+bug/518567

    Thanks for your insights!

PS: is there a bug tracker for kexec?  I didn't find it in
http://bugzilla.kernel.org/enter_bug.cgi
--=20
Lo=EFc Minier

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: attachment; filename=vmlinuz-to-vmlinux
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl -n
# vmlinuz-to-vmlinux - uncompresses a bzImage kernel into a vmlinux one
# Copyright (C) 2010 Canonical Ltd
# Author: Lo=EFc Minier <lool@dooz.org>
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# SOFTWARE IN THE PUBLIC INTEREST, INC. BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTH=
ER
# DEALINGS IN THE SOFTWARE.
#
# Except as contained in this notice, the name of the author shall not be u=
sed
# in advertising or otherwise to promote the sale, use or other dealings in
# this Software without prior written authorization from the author.

use strict;
use warnings;

use IO::Uncompress::Gunzip qw(gunzip $GunzipError);

BEGIN { $/ =3D undef }

my $magic =3D pack 'H*', "1f8b0800";

s/.*?\Q$magic\E/$magic/s
    or die "Couldn't find magic bytes";

gunzip \$_ =3D> \*STDOUT
    or die "gunzip failed: $GunzipError";


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--17pEHd4RhPHOinZp--

