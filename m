Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NXyTN-0001Kh-66
	for kexec@lists.infradead.org; Thu, 21 Jan 2010 14:57:30 +0000
Received: by yxe40 with SMTP id 40so44950yxe.28
	for <kexec@lists.infradead.org>; Thu, 21 Jan 2010 06:57:24 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 21 Jan 2010 20:27:23 +0530
Message-ID: <4d358c531001210657k5c683b51sa2eda66e0787020d@mail.gmail.com>
Subject: kexec_load failed: Bad address - mips64 /Octeon Cavium
From: Vishnu Yadav <vishnuyadav@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0544538752=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============0544538752==
Content-Type: multipart/alternative; boundary=001636c5bfb7afe48a047dadebed

--001636c5bfb7afe48a047dadebed
Content-Type: text/plain; charset=ISO-8859-1

I am trying to run kexec on mips 64 bit . on Octeon Cavium card.
 I have applied the mips patches as told on net and somewhere in  this
mailing list.

I get below error .

./kexec -l vmlinux.64
kexec_load failed: Bad address
entry       = 0x14deaa0 flags = 80000
nr_segments = 1
segment[0].buf   = 0x5555718010
segment[0].bufsz = 55cb00
segment[0].mem   = 0x1100000
segment[0].memsz = 58b000


my kexec ver is - kexec-tools 2.0.1 released 13th August 2009

and
linux runnig on mips Octeon is -
Linux (none) 2.6.27.7-Cavium-Octeon #3 SMP Thu Jan 21 17:23:38 IST 2010
mips64 unknown


Pls help me ..


-- 
Best Regards,

Vishnu Yadav

--001636c5bfb7afe48a047dadebed
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am trying to run kexec on mips 64 bit . on Octeon Cavium card.<br>=A0I ha=
ve applied the mips patches as told on net and somewhere in=A0 this mailing=
 list.<br><br>I get below error .<br><br>./kexec -l vmlinux.64 <br>kexec_lo=
ad failed: Bad address<br>
entry=A0=A0=A0=A0=A0=A0 =3D 0x14deaa0 flags =3D 80000<br>nr_segments =3D 1<=
br>segment[0].buf=A0=A0 =3D 0x5555718010<br>segment[0].bufsz =3D 55cb00<br>=
segment[0].mem=A0=A0 =3D 0x1100000<br>segment[0].memsz =3D 58b000<br clear=
=3D"all"><br><br>my kexec ver is - kexec-tools 2.0.1 released 13th August 2=
009<br>
<br>and <br>linux runnig on mips Octeon is - <br>Linux (none) 2.6.27.7-Cavi=
um-Octeon #3 SMP Thu Jan 21 17:23:38 IST 2010 mips64 unknown<br><br><br>Pls=
 help me ..<br><br><br>-- <br>Best Regards,<br><br>Vishnu Yadav<br>

--001636c5bfb7afe48a047dadebed--


--===============0544538752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0544538752==--

