Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out2.libero.it ([212.52.84.42])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JMpl5-0001bm-9z
	for kexec@lists.infradead.org; Wed, 06 Feb 2008 19:16:41 +0000
Received: from MailRelay10.libero.it (192.168.32.119) by smtp-out2.libero.it
	(7.3.120) id 4688F31B166966DA for kexec@lists.infradead.org;
	Wed, 6 Feb 2008 19:50:00 +0100
Date: Wed,  6 Feb 2008 19:50:00 +0100
Message-Id: <JVTYZC$E64E1D094E8A300A7302EDC040AEE85A@libero.it>
Subject: Re: Still on kexec for SH4 architecture, please help
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
To: lethal <lethal@linux-sh.org>
Cc: kexec <kexec@lists.infradead.org>, matteo_pampolini <matteo_pampolini@yahoo.it>

Hello Paul,
I am a collegue of Matteo Pampolini; thanks a lot about your last suggest, =
but I have still one problem.

I changed the:
P1 (0x80000000) + memory start (0x0c000000) + 0x00210000 or'ed in zImage_sh=
_load() that you suggested
in such way:
CONFIG_PAGE_OFFSET(0x80000000) + CONFIG_MEMORY_START (0x04400000) + CONFIG_=
BOOT_LINK_OFFSET (0x0080000)

and I changed the initiliaziation start memory range to set available my CO=
NFIG_MEMORY_START address.

The log that I got is the follow and I can=B4t see the new kernel really re=
stating:

./kexec -l new_zImage --type=3DzImage-sh --append=3D"console=3DttyAS1,11520=
0" --empty-zero=3D84401000

....
....
empty_zero =3D 0x04401000
area =3D 0x04400000
Starting new kernel
kexec information
  segment[0]: 0x04401000 - 0x04402000 (0x00001000)
  segment[1]: 0x04c00000 - 0x04d5a000 (0x0015a000)
  start     : 0x84c00000

Do you still see any error?

Sincerely

Paolo Cortesi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
