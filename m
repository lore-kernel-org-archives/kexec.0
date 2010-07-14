Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]
	helo=VA3EHSOBE004.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OZ4Dw-0005O7-8P
	for kexec@lists.infradead.org; Wed, 14 Jul 2010 15:50:21 +0000
Received: from mail55-va3 (localhost.localdomain [127.0.0.1])	by
	mail55-va3-R.bigfish.com (Postfix) with ESMTP id B917CC4859D	for
	<kexec@lists.infradead.org>; Wed, 14 Jul 2010 15:50:14 +0000 (UTC)
Received: from VA3EHSMHS006.bigfish.com (unknown [10.7.14.248])	by
	mail55-va3.bigfish.com (Postfix) with ESMTP id 9F12313701EA	for
	<kexec@lists.infradead.org>; Wed, 14 Jul 2010 15:49:38 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6EFnXL6018032	for
	<kexec@lists.infradead.org>; Wed, 14 Jul 2010 08:49:33 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6EG2Qxk019103	for <kexec@lists.infradead.org>;
	Wed, 14 Jul 2010 11:02:26 -0500 (CDT)
MIME-Version: 1.0
Content-Class: urn:content-classes:message
Subject: Re: [linuxppc-release] [PATCH] Fix case where phys_addr_t != unsigned
	long when reading proc entries
Date: Wed, 14 Jul 2010 08:49:30 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A750730347904B@az33exm25.fsl.freescale.net>
In-Reply-To: <1279121556-8069-1-git-send-email-msm@freescale.com>
References: <1279121556-8069-1-git-send-email-msm@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0196890634=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: McClintock Matthew-B29882 <msm@freescale.com>
Cc: kexec@lists.infradead.org

--===============0196890634==
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB236C.25C4F09B"
Content-Class: urn:content-classes:message

------_=_NextPart_001_01CB236C.25C4F09B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Matthew McClintock wrote:
> +unsigned long long initrd_base, initrd_size;
> +unsigned long long devicetree_base, devicetree_size;

These should be declared uint64_t, to match the code that assigns them.

> +				if (n =3D=3D 4) {
> +					kernel_end =3D ((uint32_t *)buf)[0];
> +				} else if (n =3D=3D 8) {

How about
=09
	n =3D=3D sizeof(uint32_t)

and

	n =3D=3D sizeof(uint64_t)

?

+			memset(fname, 0, sizeof(fname));
+			strcpy(fname, device_tree);
+			strcat(fname, dentry->d_name);
+			strcat(fname, "/linux,initrd-start");

Why not use sprintf() instead of three strcxx calls?

--=20
Timur Tabi
Linux kernel developer

------_=_NextPart_001_01CB236C.25C4F09B
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Re: [linuxppc-release] [PATCH] Fix case where phys_addr_t !=3D =
unsigned long when reading proc entries</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Matthew McClintock wrote:<BR>
&gt; +unsigned long long initrd_base, initrd_size;<BR>
&gt; +unsigned long long devicetree_base, devicetree_size;<BR>
<BR>
These should be declared uint64_t, to match the code that assigns =
them.<BR>
<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (n =3D=3D 4) {<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel_end =3D ((uint32_t =
*)buf)[0];<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (n =3D=3D 8) {<BR>
<BR>
How about<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n =3D=3D sizeof(uint32_t)<BR>
<BR>
and<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n =3D=3D sizeof(uint64_t)<BR>
<BR>
?<BR>
<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(fname, 0, =
sizeof(fname));<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(fname, =
device_tree);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcat(fname, =
dentry-&gt;d_name);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcat(fname, =
&quot;/linux,initrd-start&quot;);<BR>
<BR>
Why not use sprintf() instead of three strcxx calls?<BR>
<BR>
--<BR>
Timur Tabi<BR>
Linux kernel developer<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB236C.25C4F09B--


--===============0196890634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0196890634==--

