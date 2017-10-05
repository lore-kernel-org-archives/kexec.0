Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v4 02/10] resource: add walk_system_ram_res_rev()
References: <20171002061431.11117-1-takahiro.akashi@linaro.org>
 <20171002061431.11117-3-takahiro.akashi@linaro.org>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <f91538fe-986b-5815-b271-e4d7ee8aff4e@arm.com>
Date: Thu, 5 Oct 2017 10:36:47 +0100
MIME-Version: 1.0
In-Reply-To: <20171002061431.11117-3-takahiro.akashi@linaro.org>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Takahiro,

On 02/10/17 07:14, AKASHI Takahiro wrote:
> This function, being a variant of walk_system_ram_res() introduced in
> commit 8c86e70acead ("resource: provide new functions to walk through
> resources"), walks through a list of all the resources of System RAM
> in reversed order, i.e., from higher to lower.
> 
> It will be used in kexec_file implementation on arm64.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>   include/linux/ioport.h |  3 +++
>   kernel/resource.c      | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 62 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index f5cf32e80041..62eb62b98118 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -273,6 +273,9 @@ extern int
>   walk_system_ram_res(u64 start, u64 end, void *arg,
>   		    int (*func)(u64, u64, void *));
>   extern int
> +walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +			int (*func)(u64, u64, void *));
> +extern int
>   walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>   		    void *arg, int (*func)(u64, u64, void *));
>   
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 9b5f04404152..572f2f91ce9c 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -23,6 +23,8 @@
>   #include <linux/pfn.h>
>   #include <linux/mm.h>
>   #include <linux/resource_ext.h>
> +#include <linux/string.h>
> +#include <linux/vmalloc.h>
>   #include <asm/io.h>
>   
>   
> @@ -469,6 +471,63 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>   	return ret;
>   }
>   
> +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +				int (*func)(u64, u64, void *))
> +{
> +	struct resource res, *rams;
> +	u64 orig_end;

nit:
Why do you need orig_end? From what I can tell it is always equal to the 
"end" parameter of the function.
If you think having orig_end makes it clearer to distinguish "end" from 
"res.end" could we declare it as:

	const u64 orig_end = end;

Making it clear it is an alias?

> +	int count, i;
> +	int ret = -1;
> +
> +	count = 16; /* initial */

nit:
This doesn't represent the number of element we found but the size of 
the rams array.
Would it be better named something like "rams_size"?

> +
> +	/* create a list */
> +	rams = vmalloc(sizeof(struct resource) * count);
> +	if (!rams)
> +		return ret;
> +
> +	res.start = start;
> +	res.end = end;
> +	res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +	orig_end = res.end;
> +	i = 0;
> +	while ((res.start < res.end) &&
> +		(!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
> +		if (i >= count) {
> +			/* re-alloc */
> +			struct resource *rams_new;
> +			int count_new;
> +
> +			count_new = count + 16;
> +			rams_new = vmalloc(sizeof(struct resource) * count_new);
> +			if (!rams_new)
> +				goto out;

Should we return -ENOMEM?

> +
> +			memcpy(rams_new, rams, count);

We are likely to lose data here.

-> memcpy(rams_new, rams, count * sizeof(struct resourse));

Also, if vremalloc doesn't exist maybe the realloc part could still be 
put in a separate function?

> +			vfree(rams);
> +			rams = rams_new;
> +			count = count_new;
> +		}
> +
> +		rams[i].start = res.start;
> +		rams[i++].end = res.end;
> +
> +		res.start = res.end + 1;
> +		res.end = orig_end;
> +	}
> +
> +	/* go reverse */
> +	for (i--; i >= 0; i--) {
> +		ret = (*func)(rams[i].start, rams[i].end, arg);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	vfree(rams);
> +	return ret;
> +}
> +
>   #if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
>   
>   /*
> 

Cheers,

-- 
Julien Thierry

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
