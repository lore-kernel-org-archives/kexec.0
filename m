Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWlAi-0002nU-PJ
 for kexec@lists.infradead.org; Thu, 07 May 2020 18:23:01 +0000
Received: by mail-pj1-f68.google.com with SMTP id fu13so2988427pjb.5
 for <kexec@lists.infradead.org>; Thu, 07 May 2020 11:23:00 -0700 (PDT)
Date: Thu, 7 May 2020 18:22:57 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200507182257.GX11244@42.do-not-panic.com>
References: <20200507180631.308441-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200507180631.308441-1-aquini@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Rafael Aquini <aquini@redhat.com>
Cc: rdunlap@infradead.org, keescook@chromium.org, bhe@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, cai@lca.pw, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, dyoung@redhat.com

On Thu, May 07, 2020 at 02:06:31PM -0400, Rafael Aquini wrote:
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8727a3..b80ab660d727 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1217,6 +1217,13 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "panic_on_taint",
> +		.data		= &panic_on_taint,
> +		.maxlen		= sizeof(unsigned long),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax,
> +	},

You sent this out before I could reply to the other thread on v1.
My thoughts on the min / max values, or lack here:
                                                                                
Valid range doesn't mean "currently allowed defined" masks.                     

For example, if you expect to panic due to a taint, but a new taint type
you want was not added on an older kernel you would be under a very
*false* sense of security that your kernel may not have hit such a
taint, but the reality of the situation was that the kernel didn't
support that taint flag only added in future kernels.                           

You may need to define a new flag (MAX_TAINT) which should be the last
value + 1, the allowed max values would be                                      

(2^MAX_TAINT)-1                                                                 

or                                                                              

(1<<MAX_TAINT)-1  

Since this is to *PANIC* I think we do want to test ranges and ensure
only valid ones are allowed.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
