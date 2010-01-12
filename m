Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bay0-omc3-s28.bay0.hotmail.com ([65.54.190.166])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NUjfz-0003tn-9y
	for kexec@lists.infradead.org; Tue, 12 Jan 2010 16:33:07 +0000
Message-ID: <BAY114-W48ACEBC2A986827933C7BDD6C0@phx.gbl>
From: Zitt Zitterkopf <zittware@hotmail.com>
Subject: RE: Problems compiling kexec-tools
Date: Tue, 12 Jan 2010 08:33:01 -0800
In-Reply-To: <20100112003930.GB20676@verge.net.au>
References: <BAY114-W49E2846C6D653AB15A9A03DD6C0@phx.gbl>,
	<20100112003930.GB20676@verge.net.au>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1233943893=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
Cc: kexec@lists.infradead.org

--===============1233943893==
Content-Type: multipart/alternative;
	boundary="_b4a2f83c-2f60-40f3-9bc9-dcf6e27351f6_"

--_b4a2f83c-2f60-40f3-9bc9-dcf6e27351f6_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



> > I've installed zlib:
> >=20
> > zlib-1.2.3-29.4.moblin2.i586.rpm
> >=20
> > zlib-devel-1.2.3-29.4.moblin2.i586.rpm
> >=20
> > so I'm unsure what I've done wrong.
>=20
> Just a guess=2C but do you have a static version of libz installed?
> That is=2C did zlib-devel install a libz.a file?


Yes=3B libz.a is installed... but I may have installed=20

zlib-static-1.2.3-29.4.moblin2.i586.rpm

being over zelous with the dependancy install.

=20

I tried=20

rpm -e zlib-static-1.2.3-29.4.moblin2.i586.rpm

as root but it says "not installed".
 		 	   		  =

--_b4a2f83c-2f60-40f3-9bc9-dcf6e27351f6_
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
<BR>&gt=3B &gt=3B I've installed zlib:<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B z=
lib-1.2.3-29.4.moblin2.i586.rpm<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B zlib-dev=
el-1.2.3-29.4.moblin2.i586.rpm<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B so I'm un=
sure what I've done wrong.<BR>&gt=3B <BR>&gt=3B Just a guess=2C but do you =
have a static version of libz installed?<BR>&gt=3B That is=2C did zlib-deve=
l install a libz.a file?<BR><BR>
Yes=3B libz.a is installed... but I may have installed <BR>
zlib-static-1.2.3-29.4.moblin2.i586.rpm<BR>
being over zelous with the dependancy install.<BR>
&nbsp=3B<BR>
I tried <BR>
rpm -e zlib-static-1.2.3-29.4.moblin2.i586.rpm<BR>
as root but it says "not installed".<BR> 		 	   		  </body>
</html>=

--_b4a2f83c-2f60-40f3-9bc9-dcf6e27351f6_--


--===============1233943893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1233943893==--

