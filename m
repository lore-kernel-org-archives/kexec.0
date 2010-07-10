Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f177.google.com ([209.85.216.177])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OXRvP-00063S-Kc
	for kexec@lists.infradead.org; Sat, 10 Jul 2010 04:44:29 +0000
Received: by qyk1 with SMTP id 1so3602597qyk.15
	for <kexec@lists.infradead.org>; Fri, 09 Jul 2010 21:44:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100709064324.GA24576@verge.net.au>
References: <AANLkTink0yPL5tiAZ88LsALQ0Xf0EeJjPOHCV-YO5ll5@mail.gmail.com>
	<1278656898.25847.2.camel@localhost>
	<20100709064324.GA24576@verge.net.au>
Date: Sat, 10 Jul 2010 10:14:25 +0530
Message-ID: <AANLkTilsFiyT0hLzHO2cvoZzyu7Bdizsdhr9v_sAGODd@mail.gmail.com>
Subject: Re: kexec for powerpc mpc85xx processors
From: krish <radhakrishna.p@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1424239823=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Matthew McClintock <msm@freescale.com>, kexec@lists.infradead.org

--===============1424239823==
Content-Type: multipart/alternative; boundary=0016363103e795fb9b048b012cd3

--0016363103e795fb9b048b012cd3
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am using linux-2.6.34.1 version for both mpc83xx and mpc85xx processors.
This version of kernel supports kexec for both 83xx and 85xx processors.
I have been using ELDK toolchain for PowerPC processors.
I am using u-boot as boot loader and uImage & dtb images as Linux images.

I have downloaded 2.0.2-rc1 package and tried to compile for mpc83xx.
I have used following command to configure kexec-tools for ppc.
./configure --prefix=/home/krishna/work/kexec-tools-6dd624d/
CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc LD=/opt/ELDK41/usr/bin/ppc_6xx-ld
BUILD_CC=/usr/bin/gcc --target=ppc --host=i686
CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc
TARGET_CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc;

The compilation was broken for PPC.

If the above configuration was wrong, please help me to configure the
package for ppc.

Thanks in advance.

On Fri, Jul 9, 2010 at 12:13 PM, Simon Horman <horms@verge.net.au> wrote:

> On Fri, Jul 09, 2010 at 01:28:18AM -0500, Matthew McClintock wrote:
> > On Fri, 2010-07-09 at 11:39 +0530, krish wrote:
> > > Hi,
> > >
> > > Is kexec-tools support powerpc mpc85xx processors. If so, please help
> > > me to compile the package for powerpc processors.
> > >
> >
> > Some work has been done recently on the kernel side and kexec side.
> > First, what version of the kernel are you running? Secondly, you will
> > need to get kexec from git or possibly a very recent version for it to
> > work.
>
> Current git and 2.0.2-rc1 are the same thing at this moment :-)
>



-- 
Regards,
Radha Krishna
"Yesterday is history, Tomorrow is mystery, Today is gift"

--0016363103e795fb9b048b012cd3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am using linux-2.6.34.1 version for both mpc83xx and mpc85xx p=
rocessors. This version of kernel supports kexec for both 83xx and 85xx pro=
cessors.<br>I have been using ELDK toolchain for PowerPC processors.<br>
I am using u-boot as boot loader and uImage &amp; dtb images as Linux image=
s.<br><br>I have downloaded 2.0.2-rc1 package and tried to compile for mpc8=
3xx.<br>I have used following command to configure kexec-tools for ppc.<br>
./configure --prefix=3D/home/krishna/work/kexec-tools-6dd624d/ CC=3D/opt/EL=
DK41/usr/bin/ppc_6xx-gcc LD=3D/opt/ELDK41/usr/bin/ppc_6xx-ld BUILD_CC=3D/us=
r/bin/gcc --target=3Dppc --host=3Di686 CC=3D/opt/ELDK41/usr/bin/ppc_6xx-gcc=
 TARGET_CC=3D/opt/ELDK41/usr/bin/ppc_6xx-gcc;<br>
<br>The compilation was broken for PPC.<br><br>If the above configuration w=
as wrong, please help me to configure the package for ppc.<br><br>Thanks in=
 advance.<br><br><div class=3D"gmail_quote">On Fri, Jul 9, 2010 at 12:13 PM=
, Simon Horman <span dir=3D"ltr">&lt;<a href=3D"mailto:horms@verge.net.au">=
horms@verge.net.au</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Fri, Jul 09, 2010 at 01:28:18AM -0500, Matthew McClintock wrote:<br>
&gt; On Fri, 2010-07-09 at 11:39 +0530, krish wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; Is kexec-tools support powerpc mpc85xx processors. If so, please =
help<br>
&gt; &gt; me to compile the package for powerpc processors.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Some work has been done recently on the kernel side and kexec side.<br=
>
&gt; First, what version of the kernel are you running? Secondly, you will<=
br>
&gt; need to get kexec from git or possibly a very recent version for it to=
<br>
&gt; work.<br>
<br>
</div>Current git and 2.0.2-rc1 are the same thing at this moment :-)<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Regards,<br>Radha Krish=
na<br>&quot;Yesterday is history, Tomorrow is mystery, Today is gift&quot;<=
br>

--0016363103e795fb9b048b012cd3--


--===============1424239823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1424239823==--

