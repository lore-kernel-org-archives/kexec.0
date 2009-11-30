Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iw0-f202.google.com ([209.85.223.202])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NF8rt-0007HM-DF
	for kexec@lists.infradead.org; Mon, 30 Nov 2009 16:12:58 +0000
Received: by iwn40 with SMTP id 40so2295018iwn.28
	for <kexec@lists.infradead.org>; Mon, 30 Nov 2009 08:12:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20091130145010.GA25242@nlxdcldnl2.cl.intel.com>
References: <20091130085740.210870a0vkwm8t0c@webmail.df.eu> 
	<20091130145010.GA25242@nlxdcldnl2.cl.intel.com>
From: Mayank Kaushik <mayank.utexas@gmail.com>
Date: Mon, 30 Nov 2009 10:12:32 -0600
Message-ID: <8e626b2a0911300812v619e0fdo7b286c3fb1b9cd94@mail.gmail.com>
Subject: Re: Kexec not working as expected from inside X
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0688450870=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bernhard@bwalle.de>, Mayank Kaushik <mayank.utexas@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

--===============0688450870==
Content-Type: multipart/alternative; boundary=00151773da30d9810b047998e9c1

--00151773da30d9810b047998e9c1
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Nov 30, 2009 at 8:50 AM, David N. Lombard <dnlombar@ichips.intel.com
> wrote:

> On Mon, Nov 30, 2009 at 12:57:40AM -0700, Bernhard Walle wrote:
> >
> > Mayank Kaushik schrieb:
> > >
> > > Is it something in the nvidia driver that's causing this to not work?
> > > Any clues on what's going wrong, or how I can debug this further?
> >
> > You should attach a serial console to debug that. Is that possible on
> > your system. It's also possible to use a USB-to-RS232 converter on the
> > machine that should be debugged. However, that only works after the USB
> > drivers have been loaded, so much later than a real serial console.
>
> A normal serial console will do for this particular task, but when you need
> very early debugging, there's also a "USB debug" cable.  AFAICT, this is a
> sole-source item from Ajays Technology and only sold at
> <http://www.semiconductorstore.com/cart/pc/viewprd.asp?idProduct=12083>
>
> See Documentation/x86/earlyprintk.txt on using the device...
>
> It's on my XMAS wish list ;)
>

Thanks, there should be one of those lying around at work, I'll give it a
try.

thanks,
Mayank

--00151773da30d9810b047998e9c1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Nov 30, 2009 at 8:50 AM, David N. Lombar=
d <span dir=3D"ltr">&lt;<a href=3D"mailto:dnlombar@ichips.intel.com">dnlomb=
ar@ichips.intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">

<div class=3D"im">On Mon, Nov 30, 2009 at 12:57:40AM -0700, Bernhard Walle =
wrote:<br>
&gt;<br>
&gt; Mayank Kaushik schrieb:<br>
&gt; &gt;<br>
&gt; &gt; Is it something in the nvidia driver that&#39;s causing this to n=
ot work?<br>
&gt; &gt; Any clues on what&#39;s going wrong, or how I can debug this furt=
her?<br>
&gt;<br>
&gt; You should attach a serial console to debug that. Is that possible on<=
br>
&gt; your system. It&#39;s also possible to use a USB-to-RS232 converter on=
 the<br>
&gt; machine that should be debugged. However, that only works after the US=
B<br>
&gt; drivers have been loaded, so much later than a real serial console.<br=
>
<br>
</div>A normal serial console will do for this particular task, but when yo=
u need<br>
very early debugging, there&#39;s also a &quot;USB debug&quot; cable. =A0AF=
AICT, this is a<br>
sole-source item from Ajays Technology and only sold at<br>
&lt;<a href=3D"http://www.semiconductorstore.com/cart/pc/viewprd.asp?idProd=
uct=3D12083" target=3D"_blank">http://www.semiconductorstore.com/cart/pc/vi=
ewprd.asp?idProduct=3D12083</a>&gt;<br>
<br>
See Documentation/x86/earlyprintk.txt on using the device...<br>
<br>
It&#39;s on my XMAS wish list ;)<br>
</blockquote></div><br>Thanks, there should be one of those lying around at=
 work, I&#39;ll give it a try.<br clear=3D"all"><br>thanks,<br>Mayank<br>

--00151773da30d9810b047998e9c1--


--===============0688450870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0688450870==--

