Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-fx0-f49.google.com ([209.85.161.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQfnG-0002bB-Ne
 for kexec@lists.infradead.org; Wed, 16 Nov 2011 13:44:51 +0000
Received: by faar25 with SMTP id r25so1882549faa.36
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 05:44:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAM_iQpX+8xwDYjz=fySg9d-DF-9ezgpcvqUeQsSieVVzTG-16w@mail.gmail.com>
References: <1318376345.2050.20.camel@boudreau> <j9r5m5$b18$1@dough.gmane.org>
 <1321296650.2066.17.camel@boudreau>
 <CAM_iQpVJnGK6UkqS3R7xJiuHfVaeYF=j9wTBh7xOvFF3R0RYXA@mail.gmail.com>
 <1321397853.4198.21.camel@boudreau>
 <CAM_iQpUQ_3B1x+1DTuZ47DBcPbQ89cVWAqjPcR13zaNnimfQ8g@mail.gmail.com>
 <CAMMEr5m9yn7s-DoCvuRtHeJL9JEuhWWjpUS-r=cuyV4pYyOZAg@mail.gmail.com>
 <CAM_iQpX+8xwDYjz=fySg9d-DF-9ezgpcvqUeQsSieVVzTG-16w@mail.gmail.com>
Date: Wed, 16 Nov 2011 08:44:48 -0500
Message-ID: <CAMMEr5nHiNgZon=0qsPVEf-OCh_yAAvvrhox+=r9xhuUaFK9iw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0700090340334833554=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

--===============0700090340334833554==
Content-Type: multipart/alternative; boundary=f46d0444e945ba91d504b1da4e9f

--f46d0444e945ba91d504b1da4e9f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am=E9rico,

Ok, when I get to work, I will post the maps for 2.6.32 and 2.6.38 for
comparison.

tim
On Nov 16, 2011 5:31 AM, "Am=E9rico Wang" <xiyou.wangcong@gmail.com> wrote:

> On Wed, Nov 16, 2011 at 9:19 PM, Tim Hartrick <tim@edgecast.com> wrote:
> > America,
> >
> > To clarify, crashkernel=3D480@2G or @1G doesn"t work either.  Further, =
for
> > older kernels (2.6.32) it was possible to create crashkernel areas larg=
er
> > than 480M (crashkernel=3D512M).  Starting somewhere around 2.6.36, this
> > stopped working.  Are you saying this was an intentional change?
> >
>
> No, I am not saying this.
>
> Depends on your machine, different versions of kernel may detect
> different memory ranges, so, you need to compare the output
> of /proc/iomem, or BIOS provided RAM map (in dmesg), on different
> version kernels, to know why that happened.
>

--f46d0444e945ba91d504b1da4e9f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Am=E9rico,</p>
<p>Ok, when I get to work, I will post the maps for 2.6.32 and 2.6.38 for c=
omparison.<br></p>
<p>tim</p>
<div class=3D"gmail_quote">On Nov 16, 2011 5:31 AM, &quot;Am=E9rico Wang&qu=
ot; &lt;<a href=3D"mailto:xiyou.wangcong@gmail.com">xiyou.wangcong@gmail.co=
m</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On Wed, Nov 16, 2011 at 9:19 PM, Tim Hartrick &lt;<a href=3D"mailto:tim@edg=
ecast.com">tim@edgecast.com</a>&gt; wrote:<br>
&gt; America,<br>
&gt;<br>
&gt; To clarify, crashkernel=3D480@2G or @1G doesn&quot;t work either.=A0 F=
urther, for<br>
&gt; older kernels (2.6.32) it was possible to create crashkernel areas lar=
ger<br>
&gt; than 480M (crashkernel=3D512M).=A0 Starting somewhere around 2.6.36, t=
his<br>
&gt; stopped working.=A0 Are you saying this was an intentional change?<br>
&gt;<br>
<br>
No, I am not saying this.<br>
<br>
Depends on your machine, different versions of kernel may detect<br>
different memory ranges, so, you need to compare the output<br>
of /proc/iomem, or BIOS provided RAM map (in dmesg), on different<br>
version kernels, to know why that happened.<br>
</blockquote></div>

--f46d0444e945ba91d504b1da4e9f--


--===============0700090340334833554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0700090340334833554==--

