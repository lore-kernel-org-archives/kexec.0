Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MISIo-0002ab-Mv
	for kexec@lists.infradead.org; Sun, 21 Jun 2009 19:02:13 +0000
Received: by pzk7 with SMTP id 7so2267676pzk.25
	for <kexec@lists.infradead.org>; Sun, 21 Jun 2009 12:02:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090621171709.GA3358@localhost.localdomain>
References: <48e37220906182330w6a6e83bctb3b3a27f7bfc6afb@mail.gmail.com>
	<20090621171709.GA3358@localhost.localdomain>
Date: Mon, 22 Jun 2009 00:24:05 +0530
Message-ID: <48e37220906211154s4f1c3812o8f3ba1307a7e06d@mail.gmail.com>
Subject: Re: Need for KEXEC_PRESERVE_CONTEXT flag ?
From: Indraneel Mukherjee <indro.ml@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0571022944=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@redhat.com>
Cc: kexec@lists.infradead.org

--===============0571022944==
Content-Type: multipart/alternative; boundary=001636e0b96d1efe5f046ce048bd

--001636e0b96d1efe5f046ce048bd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Sun, Jun 21, 2009 at 10:47 PM, Neil Horman <nhorman@redhat.com> wrote:

> On Fri, Jun 19, 2009 at 12:00:44PM +0530, Indraneel Mukherjee wrote:
> > Hi,
> >
> > The file kernel/kexec.c (~ line 1001 in linux-2.6.30) has this code
> >
> > ------snip----
> >
> >  if (flags & KEXEC_PRESERVE_CONTEXT)
> >             image->preserve_context = 1;
> >
> > ------snip----
> >
> > Will this ever be true? The flag KEXEC_PRESERVE_CONTEXT is not even
> defined
> > in kexec-tools-2.0.0.
> >
> > Consequently, all the code inside the condition
>  if(image->preserve_context)
> >   is also useless?
> >
> > Am i missing something here?
> >
> Yes, the code you're looking at in the first definition is part of the
> kernel,
> while you're looking for the definition of KEXEC_PRESERVE_CONTEXT in the
> kexec-tools userspace code.  You need to look for the definition of
> KEXEC_PRESERVE_CONTEXT in the kernel code (you'll find it in
> include/linux/kexec.h).


I've seen that bit.  I was only trying to understand that code & figure out
when does it ever gets executed. My guess is that kexec-tools is the only
user of all the code in kernel/kexec.c. So, i started wondering if
kexec-tools never sets the flag KEXEC_PRESERVE_CONTEXT, then why was that
code even written?
Ans that means we've got some untested code in the kernel :) ?

Regards,
Indro



 kexec-tools might use it one day, but not using it
> doesn't mean we should remove it from the kernel.
>

>
> Neil
>
> > Regards,
> > Indro
>
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
>
>

--001636e0b96d1efe5f046ce048bd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sun, Jun 21, 2009 at 10:47 PM, Neil H=
orman <span dir=3D"ltr">&lt;<a href=3D"mailto:nhorman@redhat.com">nhorman@r=
edhat.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<div><div></div><div class=3D"h5">On Fri, Jun 19, 2009 at 12:00:44PM +0530,=
 Indraneel Mukherjee wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; The file kernel/kexec.c (~ line 1001 in linux-2.6.30) has this code<br=
>
&gt;<br>
&gt; ------snip----<br>
&gt;<br>
&gt; =A0if (flags &amp; KEXEC_PRESERVE_CONTEXT)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 image-&gt;preserve_context =3D 1;<br>
&gt;<br>
&gt; ------snip----<br>
&gt;<br>
&gt; Will this ever be true? The flag KEXEC_PRESERVE_CONTEXT is not even de=
fined<br>
&gt; in kexec-tools-2.0.0.<br>
&gt;<br>
&gt; Consequently, all the code inside the condition =A0if(image-&gt;preser=
ve_context)<br>
&gt; =A0 is also useless?<br>
&gt;<br>
&gt; Am i missing something here?<br>
&gt;<br>
</div></div>Yes, the code you&#39;re looking at in the first definition is =
part of the kernel,<br>
while you&#39;re looking for the definition of KEXEC_PRESERVE_CONTEXT in th=
e<br>
kexec-tools userspace code. =A0You need to look for the definition of<br>
KEXEC_PRESERVE_CONTEXT in the kernel code (you&#39;ll find it in<br>
include/linux/kexec.h).</blockquote><div><br>I&#39;ve seen that bit.=A0 I w=
as only trying to understand that code &amp; figure out when does it ever g=
ets executed. My guess is that kexec-tools is the only user of all the  cod=
e in kernel/kexec.c. So, i started wondering if kexec-tools never sets the =
flag KEXEC_PRESERVE_CONTEXT, then why was that code even written?<br>
Ans that means we&#39;ve got some untested code in the kernel :) ?<br><br>R=
egards,<br>Indro<br><br><br><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
 =A0kexec-tools might use it one day, but not using it<br>
doesn&#39;t mean we should remove it from the kernel.=A0<br></blockquote><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Neil<br>
<br>
&gt; Regards,<br>
&gt; Indro<br>
<br>
&gt; _______________________________________________<br>
&gt; kexec mailing list<br>
&gt; <a href=3D"mailto:kexec@lists.infradead.org">kexec@lists.infradead.org=
</a><br>
&gt; <a href=3D"http://lists.infradead.org/mailman/listinfo/kexec" target=
=3D"_blank">http://lists.infradead.org/mailman/listinfo/kexec</a><br>
<br>
</blockquote></div><br>

--001636e0b96d1efe5f046ce048bd--


--===============0571022944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0571022944==--

