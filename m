Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate6.uk.ibm.com ([194.196.100.166])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pz3V4-0006OG-EU
	for kexec@lists.infradead.org; Mon, 14 Mar 2011 08:51:40 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate6.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p2E8pWAV005207
	for <kexec@lists.infradead.org>; Mon, 14 Mar 2011 08:51:32 GMT
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p2E8po1M1593408
	for <kexec@lists.infradead.org>; Mon, 14 Mar 2011 08:51:50 GMT
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p2E8pVdO029015
	for <kexec@lists.infradead.org>; Mon, 14 Mar 2011 08:51:31 GMT
In-Reply-To: <20110314160528.943d9149.oomichi@mxs.nes.nec.co.jp>
References: <1823425025.382709.1299852470929.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<4D7DB32B.9030705@linux.vnet.ibm.com>
	<20110314160528.943d9149.oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/6] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
From: Reinhard Buendgen <BUENDGEN@de.ibm.com>
Message-ID: <OF551E2EE1.486CA207-ONC1257853.002F9F47-C1257853.0030A8D2@de.ibm.com>
Date: Mon, 14 Mar 2011 09:51:35 +0100
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1927719137=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Michael Holzheu <michael.holzheu@de.ibm.com>

This is a multipart message in MIME format.
--===============1927719137==
Content-Type: multipart/alternative; boundary="=_alternative 0030A7D6C1257853_="

This is a multipart message in MIME format.
--=_alternative 0030A7D6C1257853_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I do not think the list of erased symbols must be secret. After all we use =

a special value to do most of the erasing. Thus hinting at what was=20
erased.=20
The intention of this item is certainly not to unduly confuse service.=20

this work shall increase the customers confidence that no sensitive data=20
may leak through a dump - clearly at the cost with very low probability=20
some problems may no longer be analyzed. - But that's all you can do if=20
sensitive data is really needed to analyze a problem.

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





From:   "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
To:     Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc:     Dave Anderson <anderson@redhat.com>, V Srivatsa=20
<vsrivatsa@in.ibm.com>, kexec@lists.infradead.org, Ananth N=20
Mavinakayanahalli <ananth@in.ibm.com>, Reinhard Buendgen/Germany/IBM@IBMDE
Date:   14.03.2011 08:08
Subject:        Re: [PATCH v1 0/6] makedumpfile: makedumpfile enhancement=20
to filter out kernel data from vmcore




Hi Mahesh,

On Mon, 14 Mar 2011 11:48:19 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >=20
> >=20
> > ----- Original Message -----
> >> Hi All,
> >>
> >> Please find the makedumpfile enhancement patchset that introduces a=20
data
> >> filtering feature which enables makedumpfile to filter out desired=20
kernel
> >> symbol data and it's members from the specified VMCORE file. The data =

to be
> >> filtered out is poisoned with character 'X' (58 in Hex).
> >>
> >> This feature will be very useful for the customers who wants to erase =

the
> >> customer sensitive data like security keys and other confidential=20
data, in
> >> DUMPFILE before sending it to support team for analysis.
> >>
> >> This feature introduces a filter config file where, using filter=20
commands,
> >> user can specify desired kernel data symbols and it's members that=20
need to be
> >> filtered out while creating o/p DUMPFILE. The Syntax for filter=20
commands are
> >> provided in the filter.conf(8) man page.
> >>
> >> The first 4 patches prepares the base work for filtering framework.=20
The last 2
> >> patches implements the generic filtering framework to erase desired=20
kernel
> >> data.
> >>
> >> I have tested these patches on x86=5F64 and s390x architecture against=
=20
RHEL6 GA
> >> kernel. The feature supports filtering data from ELF as well as=20
kdump-compressed
> >> formatted dump.
> >>
> >> Please review the patchset and let me know your comments.
> >>
> >> Thanks,
> >> -Mahesh.
> >=20
> > Hi Mahesh,
> >=20
> > Is there any notation in the filtered ELF kdump or compressed kdump=20
file
> > that filtering has been done?  Given that there may be potential=20
ramifications
> > in crash utility behavior (or outright failure?), the crash utility=20
should
> > display a warning message early on during invocation.
>=20
> Hmm... I did not think about it. I am thinking of following approach:
>=20
> - Set a bit in dump=5Flevel (DL=5FFILTER=5FKERNEL=5FDATA =3D> 0x800) that=
 will
> denote that filtering has been done.
> - For compressed kdump file we anyway have dump=5Flevel available in kdump
> sub header
> - For ELF kdump, currently we do not have any way to convey dump=5Flevel
> info to crash utility (Ken'chi, correct me if I am wrong). How about
> introducing an additional ELF note (NT=5FDUMP=5FLEVEL) that will include
> dump=5Flevel info.

On your above approach, a member of support team for analysis cannot
know what symbols are erased.
And he/she will not believe the received dumpfile from a customer site.

I have one question, do you think it is better not to inform support
team of the erased symbols ?
Is also the list of the erased symbols secret ?


Thanks
Ken'ichi Ohmichi


--=_alternative 0030A7D6C1257853_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Hi,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I do not think the list of erased sy=
mbols
must be secret. After all we use a special value to do most of the erasing.
Thus hinting at what was erased. </font>
<br><font size=3D2 face=3D"sans-serif">The intention of this item is certai=
nly
not to unduly confuse service. </font>
<br>
<br><font size=3D2 face=3D"sans-serif">this work shall increase the custome=
rs
confidence that no sensitive data may leak through a dump - clearly at
the cost with very low probability some problems may no longer be analyzed.
- But that's all you can do if sensitive data is really needed to analyze
a problem.</font>
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
&nbsp;</font><font size=3D1 face=3D"sans-serif">&quot;Ken'ichi Ohmichi&quot;
&lt;oomichi@mxs.nes.nec.co.jp&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Mahesh Jagannath Salgaonkar
&lt;mahesh@linux.vnet.ibm.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Dave Anderson &lt;anderson@=
redhat.com&gt;,
V Srivatsa &lt;vsrivatsa@in.ibm.com&gt;, kexec@lists.infradead.org, Ananth
N Mavinakayanahalli &lt;ananth@in.ibm.com&gt;, Reinhard Buendgen/Germany/IB=
M@IBMDE</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">14.03.2011 08:08</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [PATCH v1
0/6] makedumpfile: makedumpfile enhancement to filter out kernel data from
vmcore</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2><br>
Hi Mahesh,<br>
<br>
On Mon, 14 Mar 2011 11:48:19 +0530<br>
Mahesh Jagannath Salgaonkar &lt;mahesh@linux.vnet.ibm.com&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; ----- Original Message -----<br>
&gt; &gt;&gt; Hi All,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Please find the makedumpfile enhancement patchset that introd=
uces
a data<br>
&gt; &gt;&gt; filtering feature which enables makedumpfile to filter out
desired kernel<br>
&gt; &gt;&gt; symbol data and it's members from the specified VMCORE file.
The data to be<br>
&gt; &gt;&gt; filtered out is poisoned with character 'X' (58 in Hex).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This feature will be very useful for the customers who wants
to erase the<br>
&gt; &gt;&gt; customer sensitive data like security keys and other confiden=
tial
data, in<br>
&gt; &gt;&gt; DUMPFILE before sending it to support team for analysis.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This feature introduces a filter config file where, using
filter commands,<br>
&gt; &gt;&gt; user can specify desired kernel data symbols and it's members
that need to be<br>
&gt; &gt;&gt; filtered out while creating o/p DUMPFILE. The Syntax for
filter commands are<br>
&gt; &gt;&gt; provided in the filter.conf(8) man page.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The first 4 patches prepares the base work for filtering
framework. &nbsp;The last 2<br>
&gt; &gt;&gt; patches implements the generic filtering framework to erase
desired kernel<br>
&gt; &gt;&gt; data.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I have tested these patches on x86=5F64 and s390x architecture
against RHEL6 GA<br>
&gt; &gt;&gt; kernel. The feature supports filtering data from ELF as well
as kdump-compressed<br>
&gt; &gt;&gt; formatted dump.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Please review the patchset and let me know your comments.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; -Mahesh.<br>
&gt; &gt; <br>
&gt; &gt; Hi Mahesh,<br>
&gt; &gt; <br>
&gt; &gt; Is there any notation in the filtered ELF kdump or compressed
kdump file<br>
&gt; &gt; that filtering has been done? &nbsp;Given that there may be poten=
tial
ramifications<br>
&gt; &gt; in crash utility behavior (or outright failure?), the crash utili=
ty
should<br>
&gt; &gt; display a warning message early on during invocation.<br>
&gt; <br>
&gt; Hmm... I did not think about it. I am thinking of following approach:<=
br>
&gt; <br>
&gt; - Set a bit in dump=5Flevel (DL=5FFILTER=5FKERNEL=5FDATA =3D&gt; 0x800=
) that
will<br>
&gt; denote that filtering has been done.<br>
&gt; - For compressed kdump file we anyway have dump=5Flevel available in
kdump<br>
&gt; sub header<br>
&gt; - For ELF kdump, currently we do not have any way to convey dump=5Flev=
el<br>
&gt; info to crash utility (Ken'chi, correct me if I am wrong). How about<b=
r>
&gt; introducing an additional ELF note (NT=5FDUMP=5FLEVEL) that will inclu=
de<br>
&gt; dump=5Flevel info.<br>
<br>
On your above approach, a member of support team for analysis cannot<br>
know what symbols are erased.<br>
And he/she will not believe the received dumpfile from a customer site.<br>
<br>
I have one question, do you think it is better not to inform support<br>
team of the erased symbols ?<br>
Is also the list of the erased symbols secret ?<br>
<br>
<br>
Thanks<br>
Ken'ichi Ohmichi<br>
</font></tt>
<br>
--=_alternative 0030A7D6C1257853_=--


--===============1927719137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1927719137==--

