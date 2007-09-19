Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail0.lsil.com ([147.145.40.20])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IXqnf-0001py-8F
	for kexec@lists.infradead.org; Wed, 19 Sep 2007 00:04:35 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: kdump info request
Date: Tue, 18 Sep 2007 22:04:21 -0600
Message-ID: <9738BCBE884FDB42801FAD8A7769C2657E2A01@NAMAIL1.ad.lsil.com>
References: <9738BCBE884FDB42801FAD8A7769C26501B2C43C@NAMAIL1.ad.lsil.com>
	<20070919035337.GA7068@in.ibm.com>
From: "Mukker, Atul" <Atul.Mukker@lsi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0373959759=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: Kexec Mailing List <kexec@lists.infradead.org>

This is a multi-part message in MIME format.

--===============0373959759==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7FA72.285A969E"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7FA72.285A969E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for the reply. I guess we have pretty much nailed down device =
bringup sequence when loading under capture kernel. Our concern is: the =
capture kernel has a significant smaller memory footprint. Our RAID =
driver itself has a large memory requirement, some of which could fail =
allocation when loaded under the capture kernel.

If we could somehow determine that we are being called in context of =
capture kernel, we can dynamically lower driver memory requirement (at =
cost of lower IO throughout of-course, which is ok for this brief =
context).

Thanks
-Atul

-----Original Message-----
From: Vivek Goyal [mailto:vgoyal@in.ibm.com]
Sent: Tue 9/18/2007 9:53 PM
To: Mukker, Atul
Cc: vgoyal@in.ibm.com; Kexec Mailing List
Subject: Re: kdump info request
=20
On Tue, Sep 18, 2007 at 03:13:42PM -0600, Mukker, Atul wrote:
> Hello Vivek, Hari:
>=20
> =20
>=20
> Excuse me for contacting you direct, but seems like you 2 can point me
> to a right direction for a kdump question we have.
>=20
> =20
>=20
> We are trying to make sure our RAID driver works ok when kernel is
> loaded with kdump. Is there a way for driver to detect this condition;
> that is, current kernel is running with kdump. We need this =
information
> so we can scale down certain operations in the driver.
>=20

Hi Atul,

What do you mean by detecting if current kernel is running with kdump? =
Do=20
you mean that you want to know the moment somebody loads a capture =
kernel
by kexec -p and driver will change some of its behaviour?

I think that's not the right way to go about. Explain the issue
a little bit in detail.

Generally drivers run into issues while initializing in second kernel =
and
one of the way to handle it is reset the device before going further =
with
initialization. I am hoping your RAID controller provides some kind of
reset mechanism from software.

Thanks
Vivek



------_=_NextPart_001_01C7FA72.285A969E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>RE: kdump info request</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Thanks for the reply. I guess we have pretty much =
nailed down device bringup sequence when loading under capture kernel. =
Our concern is: the capture kernel has a significant smaller memory =
footprint. Our RAID driver itself has a large memory requirement, some =
of which could fail allocation when loaded under the capture kernel.<BR>
<BR>
If we could somehow determine that we are being called in context of =
capture kernel, we can dynamically lower driver memory requirement (at =
cost of lower IO throughout of-course, which is ok for this brief =
context).<BR>
<BR>
Thanks<BR>
-Atul<BR>
<BR>
-----Original Message-----<BR>
From: Vivek Goyal [<A =
HREF=3D"mailto:vgoyal@in.ibm.com">mailto:vgoyal@in.ibm.com</A>]<BR>
Sent: Tue 9/18/2007 9:53 PM<BR>
To: Mukker, Atul<BR>
Cc: vgoyal@in.ibm.com; Kexec Mailing List<BR>
Subject: Re: kdump info request<BR>
<BR>
On Tue, Sep 18, 2007 at 03:13:42PM -0600, Mukker, Atul wrote:<BR>
&gt; Hello Vivek, Hari:<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; Excuse me for contacting you direct, but seems like you 2 can point =
me<BR>
&gt; to a right direction for a kdump question we have.<BR>
&gt;<BR>
&gt;&nbsp;<BR>
&gt;<BR>
&gt; We are trying to make sure our RAID driver works ok when kernel =
is<BR>
&gt; loaded with kdump. Is there a way for driver to detect this =
condition;<BR>
&gt; that is, current kernel is running with kdump. We need this =
information<BR>
&gt; so we can scale down certain operations in the driver.<BR>
&gt;<BR>
<BR>
Hi Atul,<BR>
<BR>
What do you mean by detecting if current kernel is running with kdump? =
Do<BR>
you mean that you want to know the moment somebody loads a capture =
kernel<BR>
by kexec -p and driver will change some of its behaviour?<BR>
<BR>
I think that's not the right way to go about. Explain the issue<BR>
a little bit in detail.<BR>
<BR>
Generally drivers run into issues while initializing in second kernel =
and<BR>
one of the way to handle it is reset the device before going further =
with<BR>
initialization. I am hoping your RAID controller provides some kind =
of<BR>
reset mechanism from software.<BR>
<BR>
Thanks<BR>
Vivek<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7FA72.285A969E--


--===============0373959759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0373959759==--

