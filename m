Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gx0-f177.google.com ([209.85.161.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQuQY-0000Nw-8v
 for kexec@lists.infradead.org; Thu, 17 Nov 2011 05:22:23 +0000
Received: by ggnb1 with SMTP id b1so703467ggn.36
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 21:22:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EC491B3.705@redhat.com>
References: <1318376345.2050.20.camel@boudreau> <j9r5m5$b18$1@dough.gmane.org>
 <1321296650.2066.17.camel@boudreau> <4EC21F67.10905@redhat.com>
 <1321396371.4198.5.camel@boudreau> <4EC31E55.6040809@redhat.com>
 <1321467647.2137.4.camel@boudreau> <4EC47FCA.5090908@redhat.com>
 <CAOS58YMOuJrvGxE1VxsU=ZPTLgY60HDJoLFjTowx9ZApUQ3tTw@mail.gmail.com>
 <4EC491B3.705@redhat.com>
Date: Thu, 17 Nov 2011 00:22:20 -0500
Message-ID: <CAMMEr5k_ynqg5-7Looar2DxXTGZcMqi5Lo+jtETn9awO_bsaGg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0268169223108657199=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, WANG Cong <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

--===============0268169223108657199==
Content-Type: multipart/alternative; boundary=20cf302d496295488904b1e767bf

--20cf302d496295488904b1e767bf
Content-Type: text/plain; charset=ISO-8859-1

Tejun, Dave,

I will be happy to answer any questions about our environment or test debug
or other patches.  Just tell me what you need.

tim
On Nov 16, 2011 8:44 PM, "Dave Young" <dyoung@redhat.com> wrote:

> On 11/17/2011 12:34 PM, Tejun Heo wrote:
>
> > Hello,
> >
> > On Wed, Nov 16, 2011 at 7:30 PM, Dave Young <dyoung@redhat.com> wrote:
> >> This addr is converted to an invalid phys address,
> >
> > I'm a bit lost on the context here. Who's calling per_cpu_ptr_to_phys()?
>
>
> It's drivers/base/cpu.c : show_crash_notes()
>
> >
> >> looking the code below:
> >>       if (in_first_chunk) {
> >>                if (!is_vmalloc_addr(addr))
> >>                        return __pa(addr);
> >>                else
> >>                        return page_to_phys(vmalloc_to_page(addr));
> >>        } else
> >>                return page_to_phys(pcpu_addr_to_page(addr));
> >>
> >> I dont understand per cpu allocation well, if addr is not in first chunk
> >> then it should be in vmalloc area?
> >
> > Yes, it is. First chunk can be embedded in the kernel linear address
> > space but from the second one, it's always set up from the top of the
> > vmalloc area with the same offset layout as the first chunk.
>
>
> in this case ffff880667c19ad0 fall out of vmalloc area and it's not in
> first chunk also.
>
> >
> >> Tejun, do you have any idea about this?
> >
> > Can you please tell me how to reproduce the problem? I'll try to find
> > out what's going on.
>
>
> make sure kernel support CRASH DUMP, then cat
> /sys/devices/system/cpu/cpu[x]/crash_notes
>
> Tim Hartrick <tim@edgecast.com> reported the problem when test kdump.
> But I can not reproduce this. I think tim can help to test
>
> >
> > Thanks.
> >
>
>
>
> --
> Thanks
> Dave
>

--20cf302d496295488904b1e767bf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Tejun, Dave,</p>
<p>I will be happy to answer any questions about our environment or test de=
bug or other patches.=A0 Just tell me what you need.<br></p>
<p>tim</p>
<div class=3D"gmail_quote">On Nov 16, 2011 8:44 PM, &quot;Dave Young&quot; =
&lt;<a href=3D"mailto:dyoung@redhat.com">dyoung@redhat.com</a>&gt; wrote:<b=
r type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On 11/17/2011 12:34 PM, Tejun Heo wrote:<br>
<br>
&gt; Hello,<br>
&gt;<br>
&gt; On Wed, Nov 16, 2011 at 7:30 PM, Dave Young &lt;<a href=3D"mailto:dyou=
ng@redhat.com">dyoung@redhat.com</a>&gt; wrote:<br>
&gt;&gt; This addr is converted to an invalid phys address,<br>
&gt;<br>
&gt; I&#39;m a bit lost on the context here. Who&#39;s calling per_cpu_ptr_=
to_phys()?<br>
<br>
<br>
It&#39;s drivers/base/cpu.c : show_crash_notes()<br>
<br>
&gt;<br>
&gt;&gt; looking the code below:<br>
&gt;&gt; =A0 =A0 =A0 if (in_first_chunk) {<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!is_vmalloc_addr(addr))<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return __pa(addr);<=
br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return page_to_phys=
(vmalloc_to_page(addr));<br>
&gt;&gt; =A0 =A0 =A0 =A0} else<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return page_to_phys(pcpu_addr_to_pa=
ge(addr));<br>
&gt;&gt;<br>
&gt;&gt; I dont understand per cpu allocation well, if addr is not in first=
 chunk<br>
&gt;&gt; then it should be in vmalloc area?<br>
&gt;<br>
&gt; Yes, it is. First chunk can be embedded in the kernel linear address<b=
r>
&gt; space but from the second one, it&#39;s always set up from the top of =
the<br>
&gt; vmalloc area with the same offset layout as the first chunk.<br>
<br>
<br>
in this case ffff880667c19ad0 fall out of vmalloc area and it&#39;s not in<=
br>
first chunk also.<br>
<br>
&gt;<br>
&gt;&gt; Tejun, do you have any idea about this?<br>
&gt;<br>
&gt; Can you please tell me how to reproduce the problem? I&#39;ll try to f=
ind<br>
&gt; out what&#39;s going on.<br>
<br>
<br>
make sure kernel support CRASH DUMP, then cat<br>
/sys/devices/system/cpu/cpu[x]/crash_notes<br>
<br>
Tim Hartrick &lt;<a href=3D"mailto:tim@edgecast.com">tim@edgecast.com</a>&g=
t; reported the problem when test kdump.<br>
But I can not reproduce this. I think tim can help to test<br>
<br>
&gt;<br>
&gt; Thanks.<br>
&gt;<br>
<br>
<br>
<br>
--<br>
Thanks<br>
Dave<br>
</blockquote></div>

--20cf302d496295488904b1e767bf--


--===============0268169223108657199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0268169223108657199==--

