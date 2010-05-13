Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ww0-f49.google.com ([74.125.82.49])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OCWvg-0005he-0z
	for kexec@lists.infradead.org; Thu, 13 May 2010 11:50:16 +0000
Received: by wwa36 with SMTP id 36so750473wwa.36
	for <kexec@lists.infradead.org>; Thu, 13 May 2010 04:50:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.01.1005130417590.3356@bogon.housecafe.de>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA5726.50806@nerdbynature.de>
	<alpine.DEB.2.01.1005130417590.3356@bogon.housecafe.de>
Date: Thu, 13 May 2010 15:50:13 +0400
Message-ID: <AANLkTik1aRVvqj871qOmGctuP_WjvSFwhU1w4gpJoqp1@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0526579743=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Christian Kujau <lists@nerdbynature.de>
Cc: kexec@lists.infradead.org, uvarov@dev.rtsoft.ru, linuxppc-dev@lists.ozlabs.org, horms@verge.net.au, cbouatmailru@gmail.com

--===============0526579743==
Content-Type: multipart/alternative; boundary=0016e6d99b7883ef570486785cc1

--0016e6d99b7883ef570486785cc1
Content-Type: text/plain; charset=ISO-8859-1

2010/5/13 Christian Kujau <lists@nerdbynature.de>

> On Wed, 12 May 2010 at 00:22, Christian Kujau wrote:
> > # kexec -e
> > Starting new kernel
> > Bye!
> >
> > ....but then the system just hung there, no more messages, I had to
> > powercycle it.
>
> Are there any debug flags (or kernel options?) I can set, to find out why
> it hangs here? Or does kexec not understand zImages?
>
>
zImage should not work with kexec. Only vmlinux.


> Thanks,
> Christian.
> --
> BOFH excuse #373:
>
> Suspicious pointer corrupted virtual machine
>



-- 
Best regards,
Maxim Uvarov

--0016e6d99b7883ef570486785cc1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/5/13 Christian Kujau <span dir=3D"l=
tr">&lt;<a href=3D"mailto:lists@nerdbynature.de">lists@nerdbynature.de</a>&=
gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px s=
olid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Wed, 12 May 2010 at 00:22, Christian Kujau wrote:<br>
&gt; # kexec -e<br>
&gt; Starting new kernel<br>
&gt; Bye!<br>
&gt;<br>
&gt; ....but then the system just hung there, no more messages, I had to<br=
>
&gt; powercycle it.<br>
<br>
</div>Are there any debug flags (or kernel options?) I can set, to find out=
 why<br>
it hangs here? Or does kexec not understand zImages?<br>
<br></blockquote><div><br>zImage should not work with kexec. Only vmlinux.<=
br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Thanks,<br>
Christian.<br>
<font color=3D"#888888">--<br>
BOFH excuse #373:<br>
<br>
Suspicious pointer corrupted virtual machine<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Best regards,<br=
>Maxim Uvarov<br>

--0016e6d99b7883ef570486785cc1--


--===============0526579743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0526579743==--

