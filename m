Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QPjtE-0006Ds-Ew
	for kexec@lists.infradead.org; Thu, 26 May 2011 23:22:55 +0000
Received: from joe.akashicho.tokyo.vergenet.net (116.58.178.162.static.zoot.jp
	[116.58.178.162])
	by kirsty.vergenet.net (Postfix) with ESMTP id A995024067
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 09:22:49 +1000 (EST)
Resent-Message-ID: <20110526232248.GB2815@verge.net.au>
Resent-To: kexec@lists.infradead.org
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QPYXB-0007Js-V5
	for kexec@lists.infradead.org; Thu, 26 May 2011 11:15:23 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p4QBFGq8017924
	for <kexec@lists.infradead.org>; Thu, 26 May 2011 11:15:16 GMT
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p4QBFGNA2195476
	for <kexec@lists.infradead.org>; Thu, 26 May 2011 12:15:16 +0100
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p4QBFGe4007967
	for <kexec@lists.infradead.org>; Thu, 26 May 2011 12:15:16 +0100
In-Reply-To: <20110525195321.GD6724@redhat.com>
References: <20110524203542.GH3860@redhat.com>
	<1621913139.202658.1306270052667.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<OF341326C7.0D81F89A-ONC125789B.002DB6ED-C125789B.002FC7A0@de.ibm.com>
	<20110525195321.GD6724@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/8] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
From: Reinhard Buendgen <BUENDGEN@de.ibm.com>
Message-ID: <OF05104FA0.A922963A-ONC125789C.003BDAA9-C125789C.003DD130@de.ibm.com>
Date: Thu, 26 May 2011 13:15:14 +0200
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0033059687=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>

This is a multipart message in MIME format.
--===============0033059687==
Content-Type: multipart/alternative; boundary="=_alternative 003DD0B9C125789C_="

This is a multipart message in MIME format.
--=_alternative 003DD0B9C125789C_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Vivek,

I/O is not restricted to disk I/O (it may be network I/O, data sent to=20
crtypto cards etc.) and it is not always direct, Device drivers may have=20
buffers to which such data is copied.=20

So it is more than just keys, and it may change over time.
I do not think hardwiring a filter in makedumpfile is a good idea because=20
you would need a new makedumpfile release for every Distribution=20
(release).

Allowing to configure makedumpfile allows each distribution and each=20
platform to provide appropriate filters.

Mit freundlichen Gr=FC=DFen/Best Regards/Cordialement=20

Reinhard

Dr. Reinhard B=FCndgen=20
RAS & Crypto Architect for Linux on System z=20
Virtualization and Systems Management=20
=20
Mail:buendgen@de.ibm.com
Phone: ++49-(0)7031-16-1130
Fax: ++49-(0)7031-16-3456=20
=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Dirk Wittkopp=20
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294





From:   Vivek Goyal <vgoyal@redhat.com>
To:     Reinhard Buendgen/Germany/IBM@IBMDE
Cc:     Dave Anderson <anderson@redhat.com>, Ananth N Mavinakayanahalli=20
<ananth@in.ibm.com>, kexec@lists.infradead.org, Mahesh J Salgaonkar=20
<mahesh@linux.vnet.ibm.com>, "Ken'ichi Ohmichi"=20
<oomichi@mxs.nes.nec.co.jp>, V Srivatsa <vsrivatsa@in.ibm.com>
Date:   25.05.2011 21:53
Subject:        Re: [PATCH v2 0/8] makedumpfile: makedumpfile enhancement=20
to filter out kernel data from vmcore



On Wed, May 25, 2011 at 10:41:55AM +0200, Reinhard Buendgen wrote:
> Hi,
>=20
> to answer Vivek questions first: Eventually we want to be able to erase=20
> all data that a customer may consider sensitive to her privacy. In=20
> addition to encryption key that may be the contents (i.e. payload=20
within)=20
> of all kinds of I/O buffers. Consider you are running a kvm based=20
> hypervisor and want its dump to be analyized while promising your=20
> customers whose guests you run on that hypervisor that none of their=20
data=20
> will be externalized. Or consider your system reads a spreadsheat with=20
> bank account or health information. You might not want to send fractions =


> of that information sitting in some buffers to a service organization.

So for direct IO, buffer is still in user space and should be filtered
out when we filter out user space pages using mkdumpfile. For kvm, I am
assuming that all the pages belong to qemu process and once we are
filtering out user space pages, any data belonging to guest will go away.

So atleast for above examples it does not sound as if we need symbol
erase infrastructure.

>=20
> to answer Daves concern: there is no intention that crash should ever=20
look=20
> into the erased structures. In theroy it should not be needed because=20
the=20
> contents of structures to be deleted should be irrelevant to kernel=20
> debugging.

So what are those kernel structures which we are planning to delete and
are irrelevant to kernel debugging by crash?

I think we are missing something here. If there are only few known
structures we want to get rid of, lets hardcode it in makedumpfile
instead of giving user a generic infrastructure. That way we know
that we are not leaking information at the same time making sure
that analysis tools are working.

Thanks
Vivek


--=_alternative 003DD0B9C125789C_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Vivek,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I/O is not restricted to disk I/O (it
may be network I/O, data sent to crtypto cards etc.) and it is not always
direct, Device drivers may have buffers to which such data is copied. </fon=
t>
<br>
<br><font size=3D2 face=3D"sans-serif">So it is more than just keys, and it
may change over time.</font>
<br><font size=3D2 face=3D"sans-serif">I do not think hardwiring a filter in
makedumpfile is a good idea because you would need a new makedumpfile relea=
se
for every Distribution (release).</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Allowing to configure makedumpfile a=
llows
each distribution and each platform to provide appropriate filters.</font>
<br><font size=3D2 face=3D"sans-serif"><br>
</font><font size=3D2 face=3D"Verdana">Mit freundlichen Gr=FC=DFen/Best Reg=
ards/Cordialement
<br>
</font><font size=3D5 face=3D"Brush Script"><br>
Reinhard</font>
<p>
<hr noshade>
<table width=3D100%>
<tr>
<td width=3D34%><font size=3D2 face=3D"Verdana"><b>Dr. Reinhard B=FCndgen <=
/b></font><font size=3D1 color=3D#5f5f5f face=3D"Verdana"><br>
RAS &amp; Crypto Architect for Linux on System z <br>
Virtualization and Systems Management </font>
<td width=3D1%><font size=3D1 face=3D"Verdana">&nbsp;</font>
<td width=3D23%><font size=3D1 face=3D"Verdana">Mail:</font><a href=3Dmailt=
o:buendgen@de.ibm.com><font size=3D1 color=3Dblue face=3D"Verdana"><u>buend=
gen@de.ibm.com</u></font></a><font size=3D1 face=3D"Verdana"><br>
Phone: ++49-(0)7031-16-1130<br>
Fax: ++49-(0)7031-16-3456 </font>
<td width=3D1%><font size=3D1 face=3D"Verdana">&nbsp;</font>
<td width=3D38%><font size=3D1 face=3D"Verdana">IBM Deutschland Research &a=
mp;
Development GmbH</font><font size=3D1 color=3D#5f5f5f face=3D"Verdana"><br>
Vorsitzender des Aufsichtsrats: Martin Jetter<br>
Gesch=E4ftsf=FChrung: Dirk Wittkopp <br>
Sitz der Gesellschaft: B=F6blingen<br>
Registergericht: Amtsgericht Stuttgart, HRB 243294</font></table>
<br>
<p>
<hr noshade>
<br>
<br>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Vivek Goyal &lt;vgoyal@redh=
at.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Reinhard Buendgen/Germany/I=
BM@IBMDE</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Dave Anderson &lt;anderson@=
redhat.com&gt;,
Ananth N Mavinakayanahalli &lt;ananth@in.ibm.com&gt;, kexec@lists.infradead=
.org,
Mahesh J Salgaonkar &lt;mahesh@linux.vnet.ibm.com&gt;, &quot;Ken'ichi Ohmic=
hi&quot;
&lt;oomichi@mxs.nes.nec.co.jp&gt;, V Srivatsa &lt;vsrivatsa@in.ibm.com&gt;<=
/font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">25.05.2011 21:53</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [PATCH v2
0/8] makedumpfile: makedumpfile enhancement to filter out kernel data from
vmcore</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2>On Wed, May 25, 2011 at 10:41:55AM +0200, Reinhard
Buendgen wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; to answer Vivek questions first: Eventually we want to be able to
erase <br>
&gt; all data that a customer may consider sensitive to her privacy. In
<br>
&gt; addition to encryption key that may be the contents (i.e. payload
within) <br>
&gt; of all kinds of I/O buffers. Consider you are running a kvm based
<br>
&gt; hypervisor and want its dump to be analyized while promising your
<br>
&gt; customers whose guests you run on that hypervisor that none of their
data <br>
&gt; will be externalized. Or consider your system reads a spreadsheat
with <br>
&gt; bank account or health information. You might not want to send fractio=
ns
<br>
&gt; of that information sitting in some buffers to a service organization.=
<br>
<br>
So for direct IO, buffer is still in user space and should be filtered<br>
out when we filter out user space pages using mkdumpfile. For kvm, I am<br>
assuming that all the pages belong to qemu process and once we are<br>
filtering out user space pages, any data belonging to guest will go away.<b=
r>
<br>
So atleast for above examples it does not sound as if we need symbol<br>
erase infrastructure.<br>
<br>
&gt; <br>
&gt; to answer Daves concern: there is no intention that crash should ever
look <br>
&gt; into the erased structures. In theroy it should not be needed because
the <br>
&gt; contents of structures to be deleted should be irrelevant to kernel
<br>
&gt; debugging.<br>
<br>
So what are those kernel structures which we are planning to delete and<br>
are irrelevant to kernel debugging by crash?<br>
<br>
I think we are missing something here. If there are only few known<br>
structures we want to get rid of, lets hardcode it in makedumpfile<br>
instead of giving user a generic infrastructure. That way we know<br>
that we are not leaking information at the same time making sure<br>
that analysis tools are working.<br>
<br>
Thanks<br>
Vivek<br>
</font></tt>
<br>
--=_alternative 003DD0B9C125789C_=--



--===============0033059687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0033059687==--


