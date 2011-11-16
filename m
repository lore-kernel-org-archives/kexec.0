Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-fx0-f49.google.com ([209.85.161.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQfOf-0000FR-QO
 for kexec@lists.infradead.org; Wed, 16 Nov 2011 13:19:27 +0000
Received: by faar25 with SMTP id r25so1840723faa.36
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 05:19:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAM_iQpUQ_3B1x+1DTuZ47DBcPbQ89cVWAqjPcR13zaNnimfQ8g@mail.gmail.com>
References: <1318376345.2050.20.camel@boudreau> <j9r5m5$b18$1@dough.gmane.org>
 <1321296650.2066.17.camel@boudreau>
 <CAM_iQpVJnGK6UkqS3R7xJiuHfVaeYF=j9wTBh7xOvFF3R0RYXA@mail.gmail.com>
 <1321397853.4198.21.camel@boudreau>
 <CAM_iQpUQ_3B1x+1DTuZ47DBcPbQ89cVWAqjPcR13zaNnimfQ8g@mail.gmail.com>
Date: Wed, 16 Nov 2011 08:19:23 -0500
Message-ID: <CAMMEr5m9yn7s-DoCvuRtHeJL9JEuhWWjpUS-r=cuyV4pYyOZAg@mail.gmail.com>
Subject: Re: Crash during vmcore_init
From: Tim Hartrick <tim@edgecast.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2971501362389092335=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

--===============2971501362389092335==
Content-Type: multipart/alternative; boundary=f46d04479f73d70ca404b1d9f3e4

--f46d04479f73d70ca404b1d9f3e4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

America,

To clarify, crashkernel=3D480@2G or @1G doesn"t work either.  Further, for
older kernels (2.6.32) it was possible to create crashkernel areas larger
than 480M (crashkernel=3D512M).  Starting somewhere around 2.6.36, this
stopped working.  Are you saying this was an intentional change?

tim
On Nov 16, 2011 4:47 AM, "Am=E9rico Wang" <xiyou.wangcong@gmail.com> wrote:

> On Wed, Nov 16, 2011 at 6:57 AM, Tim Hartrick <tim@edgecast.com> wrote:
> >
> > Americo,
> >
> > I downloaded the source for kexec-tools 1:2.0.2-1ubuntu3 and rebuilt it
> > with -DDEBUG and installed.  Below are the results using the
> > 2.6.38-8-server Ubuntu kernel as base and crashkernel.  Note that the
> > crashkernel size has been increased to 479M.
>
>
> Thanks for testing!
>
> >
> > While I have the list's attention, I would like to mention another
> > problem in this area.  The 2.6.38-8-server kernel cannot create a
> > crashkernel area greater than 479M in size (e.g. crashkernel=3D480M).  =
If
> > the crashkernel is relocated (e.g. crashkernel=3D480M@8G), then the ker=
nel
> > will create the area but kexec (1:2.0.1-1ubuntu3) fails while attemptin=
g
> > to load crashkernel into the reserved area.
>
>
> I am afraid kexec can't load the kernel to memory above 4G.
>
> >
> > This is a fatal problem since the 2.6.38-8-server kernel running as
> > crashkernel requires more than 479M of crashkernel area to successfully
> > take a dump on our systems.  I will be happy to provide additional
> > information about this one as well.
>
> Well, this is not kernel problem, it is a problem of your kdump tool
> on Ubuntu, the initrd of the second kernel should do as minimum things
> as possible.
>
>
> > Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D
> 0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400
> > Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D
> 0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400
> > Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D
> 0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400
> > Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D
> 0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400
> > Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D
> 0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400
> > Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D
> 0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400
> > Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D
> 0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400
> > Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D
> 0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400
>
> You have 8 cpus, but it is strange that these PT_NOTE program headers
> are all same...
>
> So, can you show us the output of the following commands on your machine?
>
> #hexdump -C /sys/kernel/crash_notes
> #for i in /sys/devices/system/cpu/cpu*/crash_notes; do hexdump -C $i; don=
e
>
> Thanks.
>

--f46d04479f73d70ca404b1d9f3e4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>America,</p>
<p>To clarify, crashkernel=3D480@2G or @1G doesn&quot;t work either.=A0 Fur=
ther, for older kernels (2.6.32) it was possible to create crashkernel area=
s larger than 480M (crashkernel=3D512M).=A0 Starting somewhere around 2.6.3=
6, this stopped working.=A0 Are you saying this was an intentional change?<=
/p>

<p>tim</p>
<div class=3D"gmail_quote">On Nov 16, 2011 4:47 AM, &quot;Am=E9rico Wang&qu=
ot; &lt;<a href=3D"mailto:xiyou.wangcong@gmail.com">xiyou.wangcong@gmail.co=
m</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On Wed, Nov 16, 2011 at 6:57 AM, Tim Hartrick &lt;<a href=3D"mailto:tim@edg=
ecast.com">tim@edgecast.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Americo,<br>
&gt;<br>
&gt; I downloaded the source for kexec-tools 1:2.0.2-1ubuntu3 and rebuilt i=
t<br>
&gt; with -DDEBUG and installed. =A0Below are the results using the<br>
&gt; 2.6.38-8-server Ubuntu kernel as base and crashkernel. =A0Note that th=
e<br>
&gt; crashkernel size has been increased to 479M.<br>
<br>
<br>
Thanks for testing!<br>
<br>
&gt;<br>
&gt; While I have the list&#39;s attention, I would like to mention another=
<br>
&gt; problem in this area. =A0The 2.6.38-8-server kernel cannot create a<br=
>
&gt; crashkernel area greater than 479M in size (e.g. crashkernel=3D480M). =
=A0If<br>
&gt; the crashkernel is relocated (e.g. crashkernel=3D480M@8G), then the ke=
rnel<br>
&gt; will create the area but kexec (1:2.0.1-1ubuntu3) fails while attempti=
ng<br>
&gt; to load crashkernel into the reserved area.<br>
<br>
<br>
I am afraid kexec can&#39;t load the kernel to memory above 4G.<br>
<br>
&gt;<br>
&gt; This is a fatal problem since the 2.6.38-8-server kernel running as<br=
>
&gt; crashkernel requires more than 479M of crashkernel area to successfull=
y<br>
&gt; take a dump on our systems. =A0I will be happy to provide additional<b=
r>
&gt; information about this one as well.<br>
<br>
Well, this is not kernel problem, it is a problem of your kdump tool<br>
on Ubuntu, the initrd of the second kernel should do as minimum things<br>
as possible.<br>
<br>
<br>
&gt; Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D =
0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400<br>
&gt; Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D =
0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400<br>
&gt; Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D =
0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400<br>
&gt; Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D =
0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400<br>
&gt; Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D =
0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400<br>
&gt; Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D =
0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400<br>
&gt; Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D =
0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400<br>
&gt; Elf header: p_type =3D 4, p_offset =3D 0xdb74000000000000 p_paddr =3D =
0xdb74000000000000 p_vaddr =3D 0x0 p_filesz =3D 0x400 p_memsz =3D 0x400<br>
<br>
You have 8 cpus, but it is strange that these PT_NOTE program headers<br>
are all same...<br>
<br>
So, can you show us the output of the following commands on your machine?<b=
r>
<br>
#hexdump -C /sys/kernel/crash_notes<br>
#for i in /sys/devices/system/cpu/cpu*/crash_notes; do hexdump -C $i; done<=
br>
<br>
Thanks.<br>
</blockquote></div>

--f46d04479f73d70ca404b1d9f3e4--


--===============2971501362389092335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2971501362389092335==--

