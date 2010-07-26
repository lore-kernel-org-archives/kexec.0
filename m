Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f177.google.com ([209.85.216.177])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OdFRQ-0002S3-6k
	for kexec@lists.infradead.org; Mon, 26 Jul 2010 04:37:33 +0000
Received: by qyk34 with SMTP id 34so1784481qyk.15
	for <kexec@lists.infradead.org>; Sun, 25 Jul 2010 21:37:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100724042435.GJ6446@verge.net.au>
References: <AANLkTin0h-QftwCqLl0Yn7pi_JWlewC_VWSl01IPPwp-@mail.gmail.com>
	<1278948593.9525.3.camel@localhost>
	<20100713025819.GA23313@verge.net.au>
	<AANLkTimEjIx1lh7YJHg7-WeKZYNFYve73vl8k_C5KvAR@mail.gmail.com>
	<1279292915.4556.0.camel@localhost>
	<AANLkTikGM3wFFUYDLOvrG65FtsJseYwnbGRh62e95j6E@mail.gmail.com>
	<1279913113.22023.11.camel@localhost>
	<20100724042435.GJ6446@verge.net.au>
Date: Mon, 26 Jul 2010 10:07:26 +0530
Message-ID: <AANLkTim+xsTyu+4pqBH9=kHeuAE3BvV2k8w28zcmY7++@mail.gmail.com>
Subject: Re: kexec for powerpc mpc83xx processors
From: krish <radhakrishna.p@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2037581790=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: radhakrishnap@tejasnetworks.com, Matthew McClintock <msm@freescale.com>, kexec@lists.infradead.org

--===============2037581790==
Content-Type: multipart/alternative; boundary=0015175cf80a0db59c048c42f163

--0015175cf80a0db59c048c42f163
Content-Type: text/plain; charset=ISO-8859-1

Matthew,

I will start exploring kumar's powerpc tree.
Please bare with me, because i am going to post more doubts regarding
this...

On Sat, Jul 24, 2010 at 9:54 AM, Simon Horman <horms@verge.net.au> wrote:

> On Fri, Jul 23, 2010 at 02:25:13PM -0500, Matthew McClintock wrote:
> > On Fri, 2010-07-23 at 15:34 +0530, krish wrote:
> > > Hello Matthew,
> > >
> > > Now, i am able to execute kexec successfully on mpc83xx platforms.
> > > Thanks for your support.
> > >
> > > But, My requirement is as follows:
> > > The kexec always loads kernel and dtb images in to memory and starts
> > > the new kernel loaded. But, I want to start the same kernel every
> > > time.
> >
> > You mean you don't want to load a new kernel you just want to reboot the
> > current kernel in place? I don't think that is possible nor an small
> > task.
> Yes..., I would like explore more on this topic.
>


> That would be a new feature for kexec, not just a fix for powerpc.
> And I also suspect it would be difficult to achieve. Certainly more
> difficult than having the image lying around and giving that to kexec.
>
>  Currently, i am working only for powerpc processors.

> > > I am not sure whether i can post this message to kexec-mailing list,
> > > If required i will add kexec-mailing list in CC.
> >
> > Generally, it's always best to post to the list as it will get you the
> > most responses.
>
> Yes :-)
>
>

--0015175cf80a0db59c048c42f163
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Matthew,<br><br>I will start exploring kumar&#39;s powerpc tree.<br>Please =
bare with me, because i am going to post more doubts regarding this...<br><=
br><div class=3D"gmail_quote">On Sat, Jul 24, 2010 at 9:54 AM, Simon Horman=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:horms@verge.net.au">horms@verge.ne=
t.au</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Fri, Jul 23, 2010 at 02:25:13PM -0500, Matthew McClintock wrote:<br>
&gt; On Fri, 2010-07-23 at 15:34 +0530, krish wrote:<br>
&gt; &gt; Hello Matthew,<br>
&gt; &gt;<br>
&gt; &gt; Now, i am able to execute kexec successfully on mpc83xx platforms=
.<br>
&gt; &gt; Thanks for your support.<br>
&gt; &gt;<br>
&gt; &gt; But, My requirement is as follows:<br>
&gt; &gt; The kexec always loads kernel and dtb images in to memory and sta=
rts<br>
&gt; &gt; the new kernel loaded. But, I want to start the same kernel every=
<br>
&gt; &gt; time.<br>
&gt;<br>
&gt; You mean you don&#39;t want to load a new kernel you just want to rebo=
ot the<br>
&gt; current kernel in place? I don&#39;t think that is possible nor an sma=
ll<br>
&gt; task.<br>
Yes..., I would like explore more on this topic.<br></div></blockquote><div=
>=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div cl=
ass=3D"im">

</div>That would be a new feature for kexec, not just a fix for powerpc.<br=
>
And I also suspect it would be difficult to achieve. Certainly more<br>
difficult than having the image lying around and giving that to kexec.<br>
<div class=3D"im"><br></div></blockquote><div>=A0Currently, i am working on=
ly for powerpc processors.<br></div><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<div class=3D"im">
&gt; &gt; I am not sure whether i can post this message to kexec-mailing li=
st,<br>
&gt; &gt; If required i will add kexec-mailing list in CC.<br>
&gt;<br>
&gt; Generally, it&#39;s always best to post to the list as it will get you=
 the<br>
&gt; most responses.<br>
<br>
</div>Yes :-)<br>
<br>
</blockquote></div><br>

--0015175cf80a0db59c048c42f163--


--===============2037581790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2037581790==--

