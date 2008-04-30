Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from an-out-0708.google.com ([209.85.132.249])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jr1wp-0002Xi-IR
	for kexec@lists.infradead.org; Wed, 30 Apr 2008 02:21:32 +0000
Received: by an-out-0708.google.com with SMTP id c24so56036ana.99
	for <kexec@lists.infradead.org>; Tue, 29 Apr 2008 19:21:31 -0700 (PDT)
Message-ID: <c62583fb0804291914o6d245e64v168dc51be7a2fd80@mail.gmail.com>
Date: Tue, 29 Apr 2008 19:14:36 -0700
From: "Mrunal Gawade" <mrunal.gawade@gmail.com>
Subject: Re: kexec/ kdump setup problem
In-Reply-To: <20080430001738.GA28606@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
References: <c62583fb0804282045w757bba55v5515bdbb37d5f18c@mail.gmail.com>
	<481702DA.3000009@in.ibm.com>
	<c62583fb0804291540o25e4b865j35c4e9b87aa016ea@mail.gmail.com>
	<20080430001738.GA28606@hmsendeavour.rdu.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0941739654=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@redhat.com>
Cc: kexec@lists.infradead.org, "Sachin P. Sant" <sachinp@in.ibm.com>

--===============0941739654==
Content-Type: multipart/alternative; 
	boundary="----=_Part_156_17042478.1209521676527"

------=_Part_156_17042478.1209521676527
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I just checked /sys/kernel/kexec_crash_loaded file after giving the kexec -p
command for loading panic kernel. And the value was 1. So it was loaded
successfully. I then crashed kernel and it hanged. I rebooted manually and
checked the value in the file again and it was "0". So across reboot it got
reset. So if I assume that the kernel loading was successful, the question
remains if it got loaded successfully at the designated space 65M@16M. How
do I know that? I am running SUSE 2.6.25 on a VMWare workstation. Does
running on VM could change any thing such as memory layout or anything
related to panic handling?

You specified taking a look at the /sys/kernel/kexec_crash_loaded file. Is
there a central document which documents all these error resolving
guidelines? Also I checked in the /var/log/messages and there is no message
related to this printed over there.


Thank you,
Mrunal

On Tue, Apr 29, 2008 at 5:17 PM, Neil Horman <nhorman@redhat.com> wrote:

> On Tue, Apr 29, 2008 at 03:40:13PM -0700, Mrunal Gawade wrote:
> > Thanks Sachin.
> >
> > The value over there is a "0" which means I have a failure. How do I
> > diagnose what is the problem? I was able to load a normal kernel and
> then
> > use "e" option to reboot into it. But crash dump kernel seemed to be
> giving
> > problem always.
> >
> >
> > Thank you,
> > Mrunal
> >
>
> check /var/log/messages, to see if there is any message there.  It
> wouldn't hurt
> to enable debugging in the kexec binary either, although if the load is
> actually
> failing, I would think you would get something on stderr.  First guess
> would be
> that you don't have a crashkernel area specified on your command line (or
> you
> do, and its reservation failed, which also will show up in the logs most
> likely)
>
> Neil
>
> > On Tue, Apr 29, 2008 at 4:13 AM, Sachin P. Sant <sachinp@in.ibm.com>
> wrote:
> >
> > > Mrunal Gawade wrote:
> > >
> > > > After I execute this command. Should I expect any prompt that kernel
> > > > loaded successfully?
> > > >
> > > Check the /sys/kernel/kexec_crash_loaded file. Value "1" means
> success.
> > >
> > > Thanks
> > > -Sachin
> > >
> > >
>
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
>
>
> --
> /***************************************************
>  *Neil Horman
>  *Software Engineer
>  *Red Hat, Inc.
>  *nhorman@redhat.com
>  *gpg keyid: 1024D / 0x92A74FA1
>  *http://pgp.mit.edu
>  ***************************************************/
>

------=_Part_156_17042478.1209521676527
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I just checked /sys/kernel/kexec_crash_loaded file after giving the kexec -p command for loading panic kernel. And the value was 1. So it was loaded successfully. I then crashed kernel and it hanged. I rebooted manually and checked the value in the file again and it was &quot;0&quot;. So across reboot it got reset. So if I assume that the kernel loading was successful, the question remains if it got loaded successfully at the designated space 65M@16M. How do I know that? I am running SUSE 2.6.25 on a VMWare workstation. Does running on VM could change any thing such as memory layout or anything related to panic handling?<br>
<br>You specified taking a look at the /sys/kernel/kexec_crash_loaded file. Is there a central document which documents all these error resolving guidelines? Also I checked in the /var/log/messages and there is no message related to this printed over there. <br>
<br><br>Thank you,<br>Mrunal<br><br><div class="gmail_quote">On Tue, Apr 29, 2008 at 5:17 PM, Neil Horman &lt;<a href="mailto:nhorman@redhat.com">nhorman@redhat.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Tue, Apr 29, 2008 at 03:40:13PM -0700, Mrunal Gawade wrote:<br>
&gt; Thanks Sachin.<br>
&gt;<br>
&gt; The value over there is a &quot;0&quot; which means I have a failure. How do I<br>
&gt; diagnose what is the problem? I was able to load a normal kernel and then<br>
&gt; use &quot;e&quot; option to reboot into it. But crash dump kernel seemed to be giving<br>
&gt; problem always.<br>
&gt;<br>
&gt;<br>
&gt; Thank you,<br>
&gt; Mrunal<br>
&gt;<br>
<br>
</div>check /var/log/messages, to see if there is any message there. &nbsp;It wouldn&#39;t hurt<br>
to enable debugging in the kexec binary either, although if the load is actually<br>
failing, I would think you would get something on stderr. &nbsp;First guess would be<br>
that you don&#39;t have a crashkernel area specified on your command line (or you<br>
do, and its reservation failed, which also will show up in the logs most likely)<br>
<br>
Neil<br>
<div class="Ih2E3d"><br>
&gt; On Tue, Apr 29, 2008 at 4:13 AM, Sachin P. Sant &lt;<a href="mailto:sachinp@in.ibm.com">sachinp@in.ibm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Mrunal Gawade wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; After I execute this command. Should I expect any prompt that kernel<br>
&gt; &gt; &gt; loaded successfully?<br>
&gt; &gt; &gt;<br>
&gt; &gt; Check the /sys/kernel/kexec_crash_loaded file. Value &quot;1&quot; means success.<br>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
&gt; &gt; -Sachin<br>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
</div>&gt; _______________________________________________<br>
&gt; kexec mailing list<br>
&gt; <a href="mailto:kexec@lists.infradead.org">kexec@lists.infradead.org</a><br>
&gt; <a href="http://lists.infradead.org/mailman/listinfo/kexec" target="_blank">http://lists.infradead.org/mailman/listinfo/kexec</a><br>
<br>
<br>
--<br>
/***************************************************<br>
<font color="#888888">&nbsp;*Neil Horman<br>
&nbsp;*Software Engineer<br>
&nbsp;*Red Hat, Inc.<br>
&nbsp;*<a href="mailto:nhorman@redhat.com">nhorman@redhat.com</a><br>
&nbsp;*gpg keyid: 1024D / 0x92A74FA1<br>
&nbsp;*<a href="http://pgp.mit.edu" target="_blank">http://pgp.mit.edu</a><br>
&nbsp;***************************************************/<br>
</font></blockquote></div><br>

------=_Part_156_17042478.1209521676527--


--===============0941739654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0941739654==--

