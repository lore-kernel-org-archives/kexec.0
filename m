Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wf-out-1314.google.com ([209.85.200.172])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JamKS-0000b3-BO
	for kexec@lists.infradead.org; Sun, 16 Mar 2008 06:26:45 +0000
Received: by wf-out-1314.google.com with SMTP id 29so4656807wff.24
	for <kexec@lists.infradead.org>; Sat, 15 Mar 2008 23:26:42 -0700 (PDT)
Message-ID: <4574cb3d0803152319g9c0666bhad29852ee3a46e25@mail.gmail.com>
Date: Sun, 16 Mar 2008 11:49:42 +0530
From: "Rajasekaran P" <rajasekaran83@gmail.com>
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
In-Reply-To: <20080314112241.GC9643@in.ibm.com>
MIME-Version: 1.0
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>
	<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>
	<47D19114.1090700@am.sony.com>
	<4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>
	<47D6B92D.2020205@am.sony.com> <47D6D406.8050209@am.sony.com>
	<4574cb3d0803140336g59236cf2w7e14405b2dc795a5@mail.gmail.com>
	<20080314110212.GA9643@in.ibm.com>
	<4574cb3d0803140418t41a84b93g9e25694b4c919e74@mail.gmail.com>
	<20080314112241.GC9643@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1180148754=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: mohan@in.ibm.com
Cc: kexec@lists.infradead.org, Geoff Levand <geoffrey.levand@am.sony.com>

--===============1180148754==
Content-Type: multipart/alternative; 
	boundary="----=_Part_5971_19423334.1205648382915"

------=_Part_5971_19423334.1205648382915
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, Mar 14, 2008 at 4:52 PM, Mohan Kumar M <mohan@in.ibm.com> wrote:

> On Fri, Mar 14, 2008 at 04:18:52AM -0700, Rajasekaran P wrote:
> > Yes,I built this kernel with CRASH_DUMP and VMCORE file system  enabled.
> > Moreover, I disabled SMP as well.
> > My system kernel is (First kernel) is SMP enabled, does it matter?
>
> It should not matter.
>
> >
> > I dont get any message from dump capture kernel.
> >
> > I trigger crash dump using :
> >
> > echo c > /proc/sysrq-trigger
>
> While triggering the dump, don't you get any message, like sending IPI
> to cpu?
>

No, I dont  get anything  on terminal.

>
> > Initially capture kernel was loaded into 32MB only, but still it was not
> > booting. So I tweaked the KDUMP_KERNELBASE macro to load capture kernel
> to
> > 64MB ( My idea is, first 64MB for system kernel and second 64MB for
> capture
> > kernel). Should it be 32MB only?
>
> You can't do that. It should be at 32MB only.

Ok, I will try this and update.

------=_Part_5971_19423334.1205648382915
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Fri, Mar 14, 2008 at 4:52 PM, Mohan Kumar M &lt;<a href="mailto:mohan@in.ibm.com">mohan@in.ibm.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Fri, Mar 14, 2008 at 04:18:52AM -0700, Rajasekaran P wrote:<br>
&gt; Yes,I built this kernel with CRASH_DUMP and VMCORE file system &nbsp;enabled.<br>
&gt; Moreover, I disabled SMP as well.<br>
&gt; My system kernel is (First kernel) is SMP enabled, does it matter?<br>
<br>
</div>It should not matter.<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt; I dont get any message from dump capture kernel.<br>
&gt;<br>
&gt; I trigger crash dump using :<br>
&gt;<br>
&gt; echo c &gt; /proc/sysrq-trigger<br>
<br>
</div>While triggering the dump, don&#39;t you get any message, like sending IPI<br>
to cpu?<br>
<div class="Ih2E3d"></div></blockquote><div><br>No, I dont&nbsp; get anything&nbsp; on terminal.<br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d"><br>
&gt; Initially capture kernel was loaded into 32MB only, but still it was not<br>
&gt; booting. So I tweaked the KDUMP_KERNELBASE macro to load capture kernel to<br>
&gt; 64MB ( My idea is, first 64MB for system kernel and second 64MB for capture<br>
&gt; kernel). Should it be 32MB only?<br>
<br>
</div>You can&#39;t do that. It should be at 32MB only.</blockquote><div>Ok, I will try this and update.&nbsp; <br></div></div><br>

------=_Part_5971_19423334.1205648382915--


--===============1180148754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1180148754==--

