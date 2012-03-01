Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f177.google.com ([209.85.216.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S2uk9-0006qM-Pj
 for kexec@lists.infradead.org; Thu, 01 Mar 2012 01:23:42 +0000
Received: by qcsu28 with SMTP id u28so25692qcs.36
 for <kexec@lists.infradead.org>; Wed, 29 Feb 2012 17:23:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120301011811.GC16483@verge.net.au>
References: <1330536083-13098-1-git-send-email-surovegin@google.com>
 <20120301011811.GC16483@verge.net.au>
From: Eugene Surovegin <surovegin@google.com>
Date: Wed, 29 Feb 2012 17:23:10 -0800
Message-ID: <CANrfoUXd4L2bjBO+L8ZBCkc1dfnZahn39sB25zsrUMqGA5zY5A@mail.gmail.com>
Subject: Re: [PATCH] kdump: force page alignment for per-CPU crash notes.
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0821083228340563531=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec-list <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>

--===============0821083228340563531==
Content-Type: multipart/alternative; boundary=20cf3074afd6627ed004ba244f5f

--20cf3074afd6627ed004ba244f5f
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Feb 29, 2012 at 5:18 PM, Simon Horman <horms@verge.net.au> wrote:

> On Wed, Feb 29, 2012 at 09:21:23AM -0800, Eugene Surovegin wrote:
> > Per-CPU allocations are not guaranteed to be physically contiguous.
> > However, kdump kernel and user-space code assumes that per-CPU
> > memory, used for saving CPU registers on crash, is.
> > This can cause corrupted /proc/vmcore in some cases - the main
> > symptom being huge ELF note section.
> >
> > Force page alignment for note_buf_t to ensure that this assumption holds.
>
> Ouch. I'm surprised there is an allocation on crash, perhaps
> it could at least be done earlier? And am I right in thinking
> that this change increases the likely hood that the allocation
> could fail?
>

I'm not following. This allocation is done on start-up, not on crash.
If you cannot allocate this much memory on system boot, I'm not sure what
else you can do on this system....

-- 
Eugene

--20cf3074afd6627ed004ba244f5f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Feb 29, 2012 at 5:18 PM, Simon Horman <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:horms@verge.net.au">horms@verge.net.a=
u</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"im">On Wed, Feb 29, 2012 at 09:21:23AM -0800, Eugene Surovegi=
n wrote:<br>
&gt; Per-CPU allocations are not guaranteed to be physically contiguous.<br=
>
&gt; However, kdump kernel and user-space code assumes that per-CPU<br>
&gt; memory, used for saving CPU registers on crash, is.<br>
&gt; This can cause corrupted /proc/vmcore in some cases - the main<br>
&gt; symptom being huge ELF note section.<br>
&gt;<br>
&gt; Force page alignment for note_buf_t to ensure that this assumption hol=
ds.<br>
<br>
</div>Ouch. I&#39;m surprised there is an allocation on crash, perhaps<br>
it could at least be done earlier? And am I right in thinking<br>
that this change increases the likely hood that the allocation<br>
could fail?<br>
<div><div></div><div class=3D"h5"></div></div></blockquote></div><br><div>I=
&#39;m not following. This allocation is done on start-up, not on crash.</d=
iv><div>If you cannot allocate this much memory on system boot, I&#39;m not=
 sure what else you can do on this system....</div>

<div><br></div><div>--=A0</div><div>Eugene</div><div><br></div>

--20cf3074afd6627ed004ba244f5f--


--===============0821083228340563531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0821083228340563531==--

