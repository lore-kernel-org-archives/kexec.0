Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wr-out-0506.google.com ([64.233.184.237])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JqybK-0003rt-4f
	for kexec@lists.infradead.org; Tue, 29 Apr 2008 22:47:07 +0000
Received: by wr-out-0506.google.com with SMTP id c46so362865wra.18
	for <kexec@lists.infradead.org>; Tue, 29 Apr 2008 15:47:05 -0700 (PDT)
Message-ID: <c62583fb0804291540o25e4b865j35c4e9b87aa016ea@mail.gmail.com>
Date: Tue, 29 Apr 2008 15:40:13 -0700
From: "Mrunal Gawade" <mrunal.gawade@gmail.com>
Subject: Re: kexec/ kdump setup problem
In-Reply-To: <481702DA.3000009@in.ibm.com>
MIME-Version: 1.0
References: <c62583fb0804282045w757bba55v5515bdbb37d5f18c@mail.gmail.com>
	<481702DA.3000009@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2121667730=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Cc: kexec@lists.infradead.org

--===============2121667730==
Content-Type: multipart/alternative; 
	boundary="----=_Part_906_20934845.1209508813511"

------=_Part_906_20934845.1209508813511
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Sachin.

The value over there is a "0" which means I have a failure. How do I
diagnose what is the problem? I was able to load a normal kernel and then
use "e" option to reboot into it. But crash dump kernel seemed to be giving
problem always.


Thank you,
Mrunal

On Tue, Apr 29, 2008 at 4:13 AM, Sachin P. Sant <sachinp@in.ibm.com> wrote:

> Mrunal Gawade wrote:
>
> > After I execute this command. Should I expect any prompt that kernel
> > loaded successfully?
> >
> Check the /sys/kernel/kexec_crash_loaded file. Value "1" means success.
>
> Thanks
> -Sachin
>
>

------=_Part_906_20934845.1209508813511
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Sachin. <br><br>The value over there is a &quot;0&quot; which means I have a failure. How do I diagnose what is the problem? I was able to load a normal kernel and then use &quot;e&quot; option to reboot into it. But crash dump kernel seemed to be giving problem always.<br>
<br><br>Thank you,<br>Mrunal<br><br><div class="gmail_quote">On Tue, Apr 29, 2008 at 4:13 AM, Sachin P. Sant &lt;<a href="mailto:sachinp@in.ibm.com">sachinp@in.ibm.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Mrunal Gawade wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
After I execute this command. Should I expect any prompt that kernel loaded successfully?<br>
</blockquote></div>
Check the /sys/kernel/kexec_crash_loaded file. Value &quot;1&quot; means success.<br>
<br>
Thanks<br><font color="#888888">
-Sachin<br>
<br>
</font></blockquote></div><br>

------=_Part_906_20934845.1209508813511--


--===============2121667730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2121667730==--

