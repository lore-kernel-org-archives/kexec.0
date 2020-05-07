Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWlYI-0003n7-3U
 for kexec@lists.infradead.org; Thu, 07 May 2020 18:47:23 +0000
Date: Thu, 7 May 2020 14:47:05 -0400
From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200507184705.GG205881@optiplex-lnx>
References: <20200507180631.308441-1-aquini@redhat.com>
 <20200507182257.GX11244@42.do-not-panic.com>
 <20200507184307.GF205881@optiplex-lnx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200507184307.GF205881@optiplex-lnx>
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: rdunlap@infradead.org, keescook@chromium.org, bhe@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, cai@lca.pw, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, dyoung@redhat.com

On Thu, May 07, 2020 at 02:43:16PM -0400, Rafael Aquini wrote:
> On Thu, May 07, 2020 at 06:22:57PM +0000, Luis Chamberlain wrote:
> > On Thu, May 07, 2020 at 02:06:31PM -0400, Rafael Aquini wrote:
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index 8a176d8727a3..b80ab660d727 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -1217,6 +1217,13 @@ static struct ctl_table kern_table[] = {
> > >  		.extra1		= SYSCTL_ZERO,
> > >  		.extra2		= SYSCTL_ONE,
> > >  	},
> > > +	{
> > > +		.procname	= "panic_on_taint",
> > > +		.data		= &panic_on_taint,
> > > +		.maxlen		= sizeof(unsigned long),
> > > +		.mode		= 0644,
> > > +		.proc_handler	= proc_doulongvec_minmax,
> > > +	},
> > 
> > You sent this out before I could reply to the other thread on v1.
> > My thoughts on the min / max values, or lack here:
> >                                                                                 
> > Valid range doesn't mean "currently allowed defined" masks.                     
> > 
> > For example, if you expect to panic due to a taint, but a new taint type
> > you want was not added on an older kernel you would be under a very
> > *false* sense of security that your kernel may not have hit such a
> > taint, but the reality of the situation was that the kernel didn't
> > support that taint flag only added in future kernels.                           
> > 
> > You may need to define a new flag (MAX_TAINT) which should be the last
> > value + 1, the allowed max values would be                                      
> > 
> > (2^MAX_TAINT)-1                                                                 
> > 
> > or                                                                              
> > 
> > (1<<MAX_TAINT)-1  
> > 
> > Since this is to *PANIC* I think we do want to test ranges and ensure
> > only valid ones are allowed.
> >
> 
> Ok. I'm thinking in:
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8727a3..ee492431e7b0 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1217,6 +1217,15 @@ static struct ctl_table kern_table[] = {
>                 .extra1         = SYSCTL_ZERO,
>                 .extra2         = SYSCTL_ONE,
>         },
> +       {
> +               .procname       = "panic_on_taint",
> +               .data           = &panic_on_taint,
> +               .maxlen         = sizeof(unsigned long),
> +               .mode           = 0644,
> +               .proc_handler   = proc_doulongvec_minmax,
> +               .extra1         = SYSCTL_ZERO,
> +               .extra2         = (1 << TAINT_FLAGS_COUNT << 1) - 1,
							^^^^^^^^
Without that crap, obviously. Sorry. That was a screw up on my side,
when copyin' and pasting.

-- Rafael
	
> +       },
> 
> 
> Would that address your concerns wrt this one?
> 
> Cheers!
> -- Rafael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
