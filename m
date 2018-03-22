Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ez8iL-00081Y-Hd
 for kexec@lists.infradead.org; Thu, 22 Mar 2018 22:29:43 +0000
Date: Thu, 22 Mar 2018 15:29:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Message-Id: <20180322152929.9b421af2f66cc819ad691207@linux-foundation.org>
In-Reply-To: <20180322033722.9279-2-bhe@redhat.com>
References: <20180322033722.9279-1-bhe@redhat.com>
 <20180322033722.9279-2-bhe@redhat.com>
Mime-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>
Cc: prudo@linux.vnet.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com

On Thu, 22 Mar 2018 11:37:21 +0800 Baoquan He <bhe@redhat.com> wrote:

> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> This function, being a variant of walk_system_ram_res() introduced in
> commit 8c86e70acead ("resource: provide new functions to walk through
> resources"), walks through a list of all the resources of System RAM
> in reversed order, i.e., from higher to lower.
> 
> It will be used in kexec_file code.
> 
> ...
>
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -23,6 +23,8 @@
>  #include <linux/pfn.h>
>  #include <linux/mm.h>
>  #include <linux/resource_ext.h>
> +#include <linux/string.h>
> +#include <linux/vmalloc.h>
>  #include <asm/io.h>
>  
>  
> @@ -470,6 +472,67 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>  }
>  
>  /*
> + * This function, being a variant of walk_system_ram_res(), calls the @func
> + * callback against all memory ranges of type System RAM which are marked as
> + * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
> + * higher to lower.
> + */

This should document the return value, as should walk_system_ram_res().
Why does it return -1 on error rather than an errno (ENOMEM)?

> +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +				int (*func)(struct resource *, void *))
> +{
> +	struct resource res, *rams;
> +	int rams_size = 16, i;
> +	int ret = -1;
> +
> +	/* create a list */
> +	rams = vmalloc(sizeof(struct resource) * rams_size);
> +	if (!rams)
> +		return ret;
> +
> +	res.start = start;
> +	res.end = end;
> +	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +	i = 0;
> +	while ((res.start < res.end) &&
> +		(!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
> +		if (i >= rams_size) {
> +			/* re-alloc */
> +			struct resource *rams_new;
> +			int rams_new_size;
> +
> +			rams_new_size = rams_size + 16;
> +			rams_new = vmalloc(sizeof(struct resource)
> +							* rams_new_size);
> +			if (!rams_new)
> +				goto out;
> +
> +			memcpy(rams_new, rams,
> +					sizeof(struct resource) * rams_size);
> +			vfree(rams);
> +			rams = rams_new;
> +			rams_size = rams_new_size;
> +		}
> +
> +		rams[i].start = res.start;
> +		rams[i++].end = res.end;
> +
> +		res.start = res.end + 1;
> +		res.end = end;
> +	}
> +
> +	/* go reverse */
> +	for (i--; i >= 0; i--) {
> +		ret = (*func)(&rams[i], arg);
> +		if (ret)
> +			break;
> +	}

erk, this is pretty nasty.  Isn't there a better way :(

> +out:
> +	vfree(rams);
> +	return ret;
> +}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
