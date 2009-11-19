Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NBA0e-0002jJ-9E
	for kexec@lists.infradead.org; Thu, 19 Nov 2009 16:37:33 +0000
Date: Thu, 19 Nov 2009 11:36:49 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kdump issue with percpu_alloc=lpage
Message-ID: <20091119163649.GB2923@redhat.com>
References: <4AE8B612.9080103@ccur.com> <4B03BD7A.9040500@kernel.org>
	<20091119143343.GB8741@redhat.com> <4B055A05.2010205@kernel.org>
	<20091119162329.GA2923@redhat.com> <4B0572DA.3030508@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B0572DA.3030508@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: John Blackwood <john.blackwood@ccur.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Fri, Nov 20, 2009 at 01:31:22AM +0900, Tejun Heo wrote:
> Hello,
> 
> 11/20/2009 01:23 AM, Vivek Goyal wrote:
> > I implemented your suggested function. This patch seems to be fixing the
> > issue. Does it look good to you?
> > 
> > Please let me know if you want me to post it to lkml or you will pull it
> > in your tree and push it to Linus.
> 
> Please post it to lkml and cc me.  I'll push it to Linus afterwards.
> 
> > Index: linux9/mm/percpu.c
> > ===================================================================
> > --- linux9.orig/mm/percpu.c	2009-11-12 19:46:07.000000000 -0500
> > +++ linux9/mm/percpu.c	2009-11-19 10:55:35.000000000 -0500
> > @@ -2069,3 +2069,12 @@ void __init setup_per_cpu_areas(void)
> >  		__per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
> >  }
> >  #endif /* CONFIG_HAVE_SETUP_PER_CPU_AREA */
> > +
> > +unsigned long long per_cpu_ptr_to_phys(void *addr)
> 
> Maybe phys_addr_t?
> 

Sounds good. Will change it and post to lkml.

Thanks
Vivek

> Thanks.
> 
> -- 
> tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
