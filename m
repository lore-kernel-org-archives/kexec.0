Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsYCf-0006oH-Fe
 for kexec@lists.infradead.org; Thu, 05 Jun 2014 13:59:38 +0000
Date: Thu, 5 Jun 2014 09:58:57 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 04/13] resource: Provide new functions to walk through
 resources
Message-ID: <20140605135857.GA17389@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-5-git-send-email-vgoyal@redhat.com>
 <20140604102420.GC4105@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140604102420.GC4105@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Wed, Jun 04, 2014 at 12:24:20PM +0200, Borislav Petkov wrote:
> On Tue, Jun 03, 2014 at 09:06:53AM -0400, Vivek Goyal wrote:
> > @@ -322,7 +327,71 @@ int release_resource(struct resource *old)
> >  
> >  EXPORT_SYMBOL(release_resource);
> >  
> > -#if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
> > +/*
> > + * Finds the lowest iomem reosurce exists with-in [res->start.res->end)
> > + * the caller must specify res->start, res->end, res->flags and "name".
> > + * If found, returns 0, res is overwritten, if not found, returns -1.
> > + * This walks through whole tree and not just first level children.
> > + */
> > +static int find_next_iomem_res(struct resource *res, char *name)
> > +{
> > +	resource_size_t start, end;
> > +	struct resource *p;
> > +
> > +	BUG_ON(!res);
> > +
> > +	start = res->start;
> > +	end = res->end;
> > +	BUG_ON(start >= end);
> > +
> > +	read_lock(&resource_lock);
> > +	p = &iomem_resource;
> > +	while ((p = next_resource(p))) {
> 
> Just a thought - this function differs from find_next_system_ram() only
> in the traversal mode through resources. I wonder if next_resource()
> could be given a flag, say TRAVERSE_SIBLINGS_ONLY or so and be called
> from both, once with the flag set and once without and thus save us the
> code duplication.

Yep, that makes sense. I will change it and start passing a flag.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
