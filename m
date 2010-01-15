Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bay0-omc3-s9.bay0.hotmail.com ([65.54.190.147])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NVrEJ-0007Ug-Nd
	for kexec@lists.infradead.org; Fri, 15 Jan 2010 18:49:12 +0000
Message-ID: <BAY114-W336F3329F5DE1A53218CC5DD690@phx.gbl>
From: Zitt Zitterkopf <zittware@hotmail.com>
Subject: RE: Problems compiling kexec-tools
Date: Fri, 15 Jan 2010 10:47:10 -0800
In-Reply-To: <4B4E029E.4020404@am.sony.com>
References: <BAY114-W49E2846C6D653AB15A9A03DD6C0@phx.gbl>,
	<4B4E029E.4020404@am.sony.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2119436800=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: geoffrey.levand@am.sony.com
Cc: kexec@lists.infradead.org

--===============2119436800==
Content-Type: multipart/alternative;
	boundary="_72a20e56-477b-4bc3-b4e9-0b91a6fc8037_"

--_72a20e56-477b-4bc3-b4e9-0b91a6fc8037_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> BTW=2C have you looked at the petitboot bootloader? For
> the most part it is a better choice than kboot.
> It provides essentially all the functionality that
> kboot does=2C plus more=2C it is easier to build=2C and it
> is a currently maintained project.
>=20
> The petitboot package can be built for x86. That is
> how much of its development is done=2C but OpenWRT does
> not yet support an x86 build of petitboot (that
> would create a grub second stage image). My plan is
> to add x86 PC support next. I don't think it is very
> difficult to do=2C I just have not had time to do it.


petitboot looks interesting=3B but I need the tool chain ready to go for x8=
6.

Currently For our project=2C we are using a patched version of kboot which =
runs on x86.

=20

I do see some benefit for petitboot with the graphical menu. Ideally we'd n=
eed a version which reads each partition looking for multiple /boot kernels=
 and present a method to select each one using a alpha char. Kinda like the=
 old System Commander app.

=20

In my config=3B I'll have multiple linux kernels on the disk. I envision ha=
ving Android=2C Moblin2.0=2C and several other flavors of linux in partitio=
ns and needing to boot to each at runtime.
 		 	   		  =

--_72a20e56-477b-4bc3-b4e9-0b91a6fc8037_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
&gt=3B BTW=2C have you looked at the petitboot bootloader? For<BR>&gt=3B th=
e most part it is a better choice than kboot.<BR>&gt=3B It provides essenti=
ally all the functionality that<BR>&gt=3B kboot does=2C plus more=2C it is =
easier to build=2C and it<BR>&gt=3B is a currently maintained project.<BR>&=
gt=3B <BR>&gt=3B The petitboot package can be built for x86. That is<BR>&gt=
=3B how much of its development is done=2C but OpenWRT does<BR>&gt=3B not y=
et support an x86 build of petitboot (that<BR>&gt=3B would create a grub se=
cond stage image). My plan is<BR>&gt=3B to add x86 PC support next. I don't=
 think it is very<BR>&gt=3B difficult to do=2C I just have not had time to =
do it.<BR><BR>
petitboot looks interesting=3B but I need the tool chain ready to go for x8=
6.<BR>
Currently For our project=2C&nbsp=3Bwe are using a patched version of kboot=
 which runs on x86.<BR>
&nbsp=3B<BR>
I do see some benefit for petitboot with the graphical menu. Ideally we'd n=
eed a version which reads each partition looking for multiple /boot kernels=
 and present a method to select each one using a alpha char. Kinda like the=
 old System Commander app.<BR>
&nbsp=3B<BR>
In my config=3B I'll have multiple linux kernels on the disk. I envision ha=
ving Android=2C Moblin2.0=2C and several other flavors of linux in partitio=
ns and needing to boot to each at runtime.<BR> 		 	   		  </body>
</html>=

--_72a20e56-477b-4bc3-b4e9-0b91a6fc8037_--


--===============2119436800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2119436800==--

