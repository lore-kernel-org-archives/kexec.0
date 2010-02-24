Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f172.google.com ([209.85.211.172])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nk8Cr-0006DW-BK
	for kexec@lists.infradead.org; Wed, 24 Feb 2010 03:46:41 +0000
Received: by ywh2 with SMTP id 2so2712157ywh.24
	for <kexec@lists.infradead.org>; Tue, 23 Feb 2010 19:46:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <572af9171002231157u72e6524aqed6375855b998e82@mail.gmail.com>
References: <4d358c531001280506p2169fad8gdde3c23d989870e1@mail.gmail.com>
	<20100221224825.GI5712@verge.net.au>
	<572af9171002231157u72e6524aqed6375855b998e82@mail.gmail.com>
Date: Wed, 24 Feb 2010 09:16:34 +0530
Message-ID: <4d358c531002231946h1c37ae7fka0cb4e149bc84df9@mail.gmail.com>
Subject: Re: mip64: kexec: Probem in allocating resevr mem
From: Vishnu Yadav <vishnuyadav@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1369262450=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

--===============1369262450==
Content-Type: multipart/alternative; boundary=0016e68dd5f248a8ef048050836d

--0016e68dd5f248a8ef048050836d
Content-Type: text/plain; charset=ISO-8859-1

Thanks Maxim for detailed analysys.

i could see how the
BOOT_MEM_RESERVED is used.
I think in my case since the kernel was cavium the tuned kernel. and in that
when i gave 64Mb as start address for reserving memory it worked.

Regards,
Vishnu

On Wed, Feb 24, 2010 at 1:27 AM, Maxim Uvarov <muvarov@gmail.com> wrote:

>  Vishnu Yadav,
>
> If you don't see reserved memory region on mips in /proc/iomem than it
> is definitely kernel issue. You can check:
> 1. you have continuous memory segment, which is enough for booting new
> kernel in low 512M. (In general you can reserve memory at any address
> but kernel can be booted if it is in lower 512M),
> 2. you specified right crashkernel= option. And it points to real
> memory segment.
> 3. crashkernel was  parsed right in the kernel.
>
> dmesg |grep mem - will print existence memory segments in format
> X(memory size) @(at) Y(memory address).
> cat /proc/iomem - should show  that memory is really reserved. If you
> don't see reserved segments then you have to debug how kernel reserves
> area for crashkernel (BOOT_MEM_RESERVED).
>
> Best regards,
> Maxim Uvarov.
>
> 2010/2/22 Simon Horman <horms@verge.net.au>:
>  > On Thu, Jan 28, 2010 at 06:36:07PM +0530, Vishnu Yadav wrote:
> >> Hi
> >> I am  not able to reserve the memory in mips 64 plateform for "crash
> kernel"
> >>
> >> in below function of arch/mips/kernel/setup.c file of kernel code
> >> reserve_bootmem(start, size , flags)
> >> if i put flags= BOOTMEM_DEFAULT then this function succeeds but doesnt
> >> reserve  mem of crash kernel .. i verified it by seeing /proc/iomem
> >>
> >> but if i put flags= BOOTMEM_EXCLUSIVE .. this function itself fails and
> >> again no memry is reseved.
> >>
> >>
> >> Pls suggest me how to resevre mem regio for "crash kernel" in mips 64.
> NOTE-
> >> I have applied kernel as well as user spaces patches for running kexec
> on
> >> mips64.
> >
> > Does Maxim Uvarov's recent patch help you at all?
> >
> > http://lists.infradead.org/pipermail/kexec/2010-February/003816.html
> >
>
>
>
> --
> Best regards,
> Maxim Uvarov
>



-- 
Best Regards,

Vishnu Yadav

--0016e68dd5f248a8ef048050836d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Thanks Maxim for detailed analysys.</div>
<div>=A0</div>
<div>i could see how the </div>
<div>BOOT_MEM_RESERVED is used.</div>
<div>I think in my case since the=A0kernel was cavium the tuned kernel. and=
 in that when i gave 64Mb as start address for reserving memory it worked. =
</div>
<div>=A0</div>
<div>Regards,</div>
<div>Vishnu<br><br></div>
<div class=3D"gmail_quote">On Wed, Feb 24, 2010 at 1:27 AM, Maxim Uvarov <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:muvarov@gmail.com">muvarov@gmail.com<=
/a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">=A0Vishnu Yadav,<br><br>If you d=
on&#39;t see reserved memory region on mips in /proc/iomem than it<br>is de=
finitely kernel issue. You can check:<br>
1. you have continuous memory segment, which is enough for booting new<br>k=
ernel in low 512M. (In general you can reserve memory at any address<br>but=
 kernel can be booted if it is in lower 512M),<br>2. you specified right cr=
ashkernel=3D option. And it points to real<br>
memory segment.<br>3. crashkernel was =A0parsed right in the kernel.<br><br=
>dmesg |grep mem - will print existence memory segments in format<br>X(memo=
ry size) @(at) Y(memory address).<br>cat /proc/iomem - should show =A0that =
memory is really reserved. If you<br>
don&#39;t see reserved segments then you have to debug how kernel reserves<=
br>area for crashkernel (BOOT_MEM_RESERVED).<br><br>Best regards,<br>Maxim =
Uvarov.<br><br>2010/2/22 Simon Horman &lt;<a href=3D"mailto:horms@verge.net=
.au">horms@verge.net.au</a>&gt;:<br>

<div>
<div></div>
<div class=3D"h5">&gt; On Thu, Jan 28, 2010 at 06:36:07PM +0530, Vishnu Yad=
av wrote:<br>&gt;&gt; Hi<br>&gt;&gt; I am =A0not able to reserve the memory=
 in mips 64 plateform for &quot;crash kernel&quot;<br>&gt;&gt;<br>&gt;&gt; =
in below function of arch/mips/kernel/setup.c file of kernel code<br>
&gt;&gt; reserve_bootmem(start, size , flags)<br>&gt;&gt; if i put flags=3D=
 BOOTMEM_DEFAULT then this function succeeds but doesnt<br>&gt;&gt; reserve=
 =A0mem of crash kernel .. i verified it by seeing /proc/iomem<br>&gt;&gt;<=
br>
&gt;&gt; but if i put flags=3D BOOTMEM_EXCLUSIVE .. this function itself fa=
ils and<br>&gt;&gt; again no memry is reseved.<br>&gt;&gt;<br>&gt;&gt;<br>&=
gt;&gt; Pls suggest me how to resevre mem regio for &quot;crash kernel&quot=
; in mips 64. NOTE-<br>
&gt;&gt; I have applied kernel as well as user spaces patches for running k=
exec on<br>&gt;&gt; mips64.<br>&gt;<br>&gt; Does Maxim Uvarov&#39;s recent =
patch help you at all?<br>&gt;<br>&gt; <a href=3D"http://lists.infradead.or=
g/pipermail/kexec/2010-February/003816.html" target=3D"_blank">http://lists=
.infradead.org/pipermail/kexec/2010-February/003816.html</a><br>
&gt;<br><br><br><br></div></div>--<br>Best regards,<br><font color=3D"#8888=
88">Maxim Uvarov<br></font></blockquote></div><br><br clear=3D"all"><br>-- =
<br>Best Regards,<br><br>Vishnu Yadav<br>

--0016e68dd5f248a8ef048050836d--


--===============1369262450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1369262450==--

