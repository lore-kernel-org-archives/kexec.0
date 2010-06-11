Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iw0-f177.google.com ([209.85.214.177])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OMxmL-0003Ff-Hf
	for kexec@lists.infradead.org; Fri, 11 Jun 2010 06:31:46 +0000
Received: by iwn34 with SMTP id 34so981962iwn.36
	for <kexec@lists.infradead.org>; Thu, 10 Jun 2010 23:31:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100610002703.GR6426@verge.net.au>
References: <AANLkTilNsIvlsoALcESOoA0q2K8Ao5dMW3GjkHvKpSCX@mail.gmail.com>
	<20100610002703.GR6426@verge.net.au>
Date: Fri, 11 Jun 2010 14:31:42 +0800
Message-ID: <AANLkTikkTft1lS5oZ4b-8vz7aqVy6As_HHNC4V8nVZj5@mail.gmail.com>
Subject: Re: kexec fail on ia64 platform
From: =?GB2312?B?1tzQ2w==?= <jencce2002@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1714682181=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

--===============1714682181==
Content-Type: multipart/alternative; boundary=001485eba7acd7a88c0488bb4a7d

--001485eba7acd7a88c0488bb4a7d
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Hi,
      kexec-tools version 2.0.1 works well on my machine. thanks very much.
kernel version still 2.6.28.10.  :)
      but under in the file kexec-tools-2.0.1/News,  i dont see any changes=
.
I'm interested in it , where can i find this info ? thanks

jencce

2010/6/10 Simon Horman <horms@verge.net.au>

> On Wed, Jun 09, 2010 at 02:33:14PM +0800, =D6=DC=D0=DB wrote:
> > hello everyone,
> >            sorry to bother you. I have a problem with kexec tools. when=
 i
> > use it on a ia64 machine, it does't work.
> >            situation 1 : after executing "kexec -l ***" and "kexec -e" =
,
> > many "cpu # is now offline" printed out, then the system lose response.
> >            situation 2 (mostly): after many "cpu # is now offline"
> printed
> > out, some warn info printed out , and then a call trace..  system lose
> > response...    warn info is : Unexpected irq vector 0x44 on cpu 11! .. =
..
> > call trace has info like : fixup_irqs , take_cpu_down, etc..
> >            Is there something wrong with my current kernel ? but it is =
an
> > usual 2.6.28.10. Does kexec support IA64 fully?
> >            Thanks alot. bow. :)
>
> Hi,
>
> 2.6.28 should be new enough, but is it possible to check
> using a more recent kernel (e.g. 2.6.34) and the latest kexec-tools
> (2.0.1)?
>
> If the problem persists, then a copy of the stack trace would be useful.
> I usually collect these by using a serial console.
>
> Thanks.
>

--001485eba7acd7a88c0488bb4a7d
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Hi,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kexec-tools version 2.0.1 works well =
on my machine. thanks very much.<br>kernel version still 2.6.28.10.&nbsp; :=
)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but under in the file kexec-tools-2.0.1=
/News,&nbsp; i dont see any changes. I&#39;m interested in it , where can i=
 find this info ? thanks<br>
<br>jencce<br>&nbsp;<br><div class=3D"gmail_quote">2010/6/10 Simon Horman <=
span dir=3D"ltr">&lt;<a href=3D"mailto:horms@verge.net.au">horms@verge.net.=
au</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left=
: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1e=
x;">
<div><div></div><div class=3D"h5">On Wed, Jun 09, 2010 at 02:33:14PM +0800,=
 =D6=DC=D0=DB wrote:<br>
&gt; hello everyone,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;sorry to bother you. I have a=
 problem with kexec tools. when i<br>
&gt; use it on a ia64 machine, it does&#39;t work.<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;situation 1 : after executing=
 &quot;kexec -l ***&quot; and &quot;kexec -e&quot; ,<br>
&gt; many &quot;cpu # is now offline&quot; printed out, then the system los=
e response.<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;situation 2 (mostly): after m=
any &quot;cpu # is now offline&quot; printed<br>
&gt; out, some warn info printed out , and then a call trace.. &nbsp;system=
 lose<br>
&gt; response... &nbsp; &nbsp;warn info is : Unexpected irq vector 0x44 on =
cpu 11! .. ..<br>
&gt; call trace has info like : fixup_irqs , take_cpu_down, etc..<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Is there something wrong with=
 my current kernel ? but it is an<br>
&gt; usual 2.6.28.10. Does kexec support IA64 fully?<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Thanks alot. bow. :)<br>
<br>
</div></div>Hi,<br>
<br>
2.6.28 should be new enough, but is it possible to check<br>
using a more recent kernel (e.g. 2.6.34) and the latest kexec-tools<br>
(2.0.1)?<br>
<br>
If the problem persists, then a copy of the stack trace would be useful.<br=
>
I usually collect these by using a serial console.<br>
<br>
Thanks.<br>
</blockquote></div><br>

--001485eba7acd7a88c0488bb4a7d--


--===============1714682181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1714682181==--

