Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ws8NZ-0008Fd-Gy
 for kexec@lists.infradead.org; Wed, 04 Jun 2014 10:25:10 +0000
Date: Wed, 4 Jun 2014 12:24:20 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 04/13] resource: Provide new functions to walk through
 resources
Message-ID: <20140604102420.GC4105@pd.tnic>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-5-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401800822-27425-5-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Tue, Jun 03, 2014 at 09:06:53AM -0400, Vivek Goyal wrote:
> @@ -322,7 +327,71 @@ int release_resource(struct resource *old)
>  
>  EXPORT_SYMBOL(release_resource);
>  
> -#if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
> +/*
> + * Finds the lowest iomem reosurce exists with-in [res->start.res->end)
> + * the caller must specify res->start, res->end, res->flags and "name".
> + * If found, returns 0, res is overwritten, if not found, returns -1.
> + * This walks through whole tree and not just first level children.
> + */
> +static int find_next_iomem_res(struct resource *res, char *name)
> +{
> +	resource_size_t start, end;
> +	struct resource *p;
> +
> +	BUG_ON(!res);
> +
> +	start = res->start;
> +	end = res->end;
> +	BUG_ON(start >= end);
> +
> +	read_lock(&resource_lock);
> +	p = &iomem_resource;
> +	while ((p = next_resource(p))) {

Just a thought - this function differs from find_next_system_ram() only
in the traversal mode through resources. I wonder if next_resource()
could be given a flag, say TRAVERSE_SIBLINGS_ONLY or so and be called
from both, once with the flag set and once without and thus save us the
code duplication.

> +		if (p->flags != res->flags)
> +			continue;
> +		if (name && strcmp(p->name, name))
> +			continue;
> +		if (p->start > end) {
> +			p = NULL;
> +			break;
> +		}
> +		if ((p->end >= start) && (p->start < end))
> +			break;
> +	}
> +
> +	read_unlock(&resource_lock);
> +	if (!p)
> +		return -1;
> +	/* copy data */
> +	if (res->start < p->start)
> +		res->start = p->start;
> +	if (res->end > p->end)
> +		res->end = p->end;
> +	return 0;
> +}

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
