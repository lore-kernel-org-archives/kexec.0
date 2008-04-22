Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JoBAJ-0005nd-2P
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 05:35:39 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3M5ZX3B010021
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 01:35:33 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3M5ZXEF180866
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 01:35:33 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3M5ZNaj016612
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 01:35:23 -0400
Message-ID: <480D790D.7080403@in.ibm.com>
Date: Tue, 22 Apr 2008 11:05:09 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: Question about forcing kernel panic on PowerMac G5 by kexec
	command
References: <200804210517.m3L5Hq61011769@toshiba.co.jp>
In-Reply-To: <200804210517.m3L5Hq61011769@toshiba.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: gib <suchada.pitchayasamanya@toshiba.co.jp>
Cc: kexec@lists.infradead.org

gib wrote:
> Hello all,
> =

>  =

> =

> I=92m working on PowerMac G5 complied with CONFIG_KEXEC =3D y.
> =

> It=92s work fine with Kexec command option l ( kexec =96l /boot/vmlinux=
=85 ) =

> but after the capture kernel pre-loading ( by kexec =96p /boot/vmlinux=85=
 ),
> =

Hi Suchada,

What kernel version you are trying? Also what level of kexec-tools you use?

I hope you are aware that you need two different kernels for kdump, =

first one is meant for normal use and another one is kdump kernel. Did =

you compile the kdump kernel with CONFIG_CRASH_DUMP?

> when I forced kernel panic by =93echo c > /proc/sysrq-trigger=94 the cons=
ole =

> kept showing =93Sending IPI to other CPU=94 and did not go to the next st=
ep.
> =

>  =

> =

> According to this list there was some problem about kdump in ppc970 based=
 CPU which PowerMac=92s CPU are.

There was a interrupt routing problem with specific ppc970 cpu type, but =

that problem is fixed now.

Regards,
Mohan.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
