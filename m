Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wy0-f177.google.com ([74.125.82.177])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OCAnO-0003v0-7i
	for kexec@lists.infradead.org; Wed, 12 May 2010 12:12:14 +0000
Received: by wyj26 with SMTP id 26so2315002wyj.36
	for <kexec@lists.infradead.org>; Wed, 12 May 2010 05:12:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BEA5726.50806@nerdbynature.de>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA5726.50806@nerdbynature.de>
Date: Wed, 12 May 2010 16:12:12 +0400
Message-ID: <AANLkTil699YohqNmq1UeAZU7jyrl78d3yfvOD3T_Sx57@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
From: Maxim Uvarov <muvarov@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1443074078=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Christian Kujau <lists@nerdbynature.de>
Cc: kexec@lists.infradead.org, uvarov@dev.rtsoft.ru, linuxppc-dev@lists.ozlabs.org, horms@verge.net.au, cbouatmailru@gmail.com

--===============1443074078==
Content-Type: multipart/alternative; boundary=0016e649864a55b9940486648d2c

--0016e649864a55b9940486648d2c
Content-Type: text/plain; charset=ISO-8859-1

2010/5/12 Christian Kujau <lists@nerdbynature.de>

> On Tue, 11 May 2010 at 21:47, Maxim Uvarov wrote:
> > This patch is required in case if you are using new toolchains.
>
> After kexec-tools compiled, I actually tried it:
>
> # kexec -l /boot/2.6/zImage --command-line="root=/dev/hda6 ro"
> # echo $?
> 0
> # kexec -e
> Starting new kernel
> Bye!
>
> ....but then the system just hung there, no more messages, I had to
> powercycle it.
>
> The --debug options is listed for "dol-ppc" systems (I have a PowerBook
> G4, not sure if this falls into this category), when I use it the help
> screen of kexec is displayed again and at the bottom:
>
>   Cannot load /boot/2.6/zImage
>
>
> This is with 2.6.34-rc7 (today's git):
>
> # file /boot/2.6/zImage
> /boot/2.6/zImage: ELF 32-bit MSB executable, PowerPC or cisco 4500,
> version 1 (SYSV), statically linked, with unknown capability 0x41000000
> = 0x11676e75, with unknown capability 0x10000 = 0x90402, not stripped
>
>
> .config and dmesg: http://nerdbynature.de/bits/2.6.34-rc7/kexec/
>
> Christian.
> --
> make bzImage, not war
>


Can you try vmlinux? I tested only with vmlinux.

-- 
Best regards,
Maxim Uvarov

--0016e649864a55b9940486648d2c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/5/12 Christian Kujau <span dir=3D"l=
tr">&lt;<a href=3D"mailto:lists@nerdbynature.de">lists@nerdbynature.de</a>&=
gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px s=
olid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Tue, 11 May 2010 at 21:47, Maxim Uvarov wrote:<br>
</div><div class=3D"im">&gt; This patch is required in case if you are usin=
g new toolchains.<br>
<br>
</div>After kexec-tools compiled, I actually tried it:<br>
<br>
# kexec -l /boot/2.6/zImage --command-line=3D&quot;root=3D/dev/hda6 ro&quot=
;<br>
# echo $?<br>
0<br>
# kexec -e<br>
Starting new kernel<br>
Bye!<br>
<br>
....but then the system just hung there, no more messages, I had to<br>
powercycle it.<br>
<br>
The --debug options is listed for &quot;dol-ppc&quot; systems (I have a Pow=
erBook<br>
G4, not sure if this falls into this category), when I use it the help<br>
screen of kexec is displayed again and at the bottom:<br>
<br>
 =A0 Cannot load /boot/2.6/zImage<br>
<br>
<br>
This is with 2.6.34-rc7 (today&#39;s git):<br>
<br>
# file /boot/2.6/zImage<br>
/boot/2.6/zImage: ELF 32-bit MSB executable, PowerPC or cisco 4500,<br>
version 1 (SYSV), statically linked, with unknown capability 0x41000000<br>
=3D 0x11676e75, with unknown capability 0x10000 =3D 0x90402, not stripped<b=
r>
<br>
<br>
.config and dmesg: <a href=3D"http://nerdbynature.de/bits/2.6.34-rc7/kexec/=
" target=3D"_blank">http://nerdbynature.de/bits/2.6.34-rc7/kexec/</a><br>
<div><div></div><div class=3D"h5"><br>
Christian.<br>
--<br>
make bzImage, not war<br>
</div></div></blockquote></div><br><br>Can you try vmlinux? I tested only w=
ith vmlinux.<br clear=3D"all"><br>-- <br>Best regards,<br>Maxim Uvarov<br>

--0016e649864a55b9940486648d2c--


--===============1443074078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1443074078==--

