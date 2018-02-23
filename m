Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 23 Feb 2018 16:36:19 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v8 01/13] resource: add walk_system_ram_res_rev()
Message-ID: <20180223083619.GA4433@dhcp-128-65.nay.redhat.com>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
 <20180222111732.23051-2-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180222111732.23051-2-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, julien.thierry@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net, vgoyal@redhat.com

Hi AKASHI,

On 02/22/18 at 08:17pm, AKASHI Takahiro wrote:
> This function, being a variant of walk_system_ram_res() introduced in
> commit 8c86e70acead ("resource: provide new functions to walk through
> resources"), walks through a list of all the resources of System RAM
> in reversed order, i.e., from higher to lower.
> 
> It will be used in kexec_file implementation on arm64.

I remember there was an old discussion about this, it should be added
in patch log why this is needed.

> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  include/linux/ioport.h |  3 +++
>  kernel/resource.c      | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..f12d95fe038b 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -277,6 +277,9 @@ extern int
>  walk_system_ram_res(u64 start, u64 end, void *arg,
>  		    int (*func)(struct resource *, void *));
>  extern int
> +walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +			int (*func)(struct resource *, void *));
> +extern int
>  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>  		    void *arg, int (*func)(struct resource *, void *));
>  
> diff --git a/kernel/resource.c b/kernel/resource.c
> index e270b5048988..bdaa93407f4c 100644
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
> @@ -486,6 +488,61 @@ int walk_mem_res(u64 start, u64 end, void *arg,
>  				     arg, func);
>  }
>  
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
> +
> +out:
> +	vfree(rams);
> +	return ret;
> +}
> +
>  #if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
>  
>  /*
> -- 
> 2.16.2
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
