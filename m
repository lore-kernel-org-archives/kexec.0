Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v10 03/14] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-4-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <8a59db79-6379-550b-b20e-01036626904e@arm.com>
Date: Tue, 3 Jul 2018 17:36:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180623022058.10935-4-takahiro.akashi@linaro.org>
Content-Language: en-US
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>

Hi Akashi,

On 23/06/18 03:20, AKASHI Takahiro wrote:
> Memblock list is another source for usable system memory layout.
> A merged new arch_kexec_walk_mem() will walk through either io resource
> list or memblock list depending on CONFIG_ARCH_DISCARD_MEMBLOCK so that
> arm64, in addition to powerpc, will be able to utilize this generic
> function for kexec_file.

> diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
> index 0bd23dc789a4..3d4be91786ce 100644
> --- a/arch/powerpc/kernel/machine_kexec_file_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_file_64.c

Does this file still need its memblock.h include?


> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 63c7ce1c0c3e..563acd1c9a61 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -16,6 +16,7 @@
>  #include <linux/file.h>
>  #include <linux/slab.h>
>  #include <linux/kexec.h>
> +#include <linux/memblock.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/fs.h>
> @@ -501,6 +502,53 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
>  	return locate_mem_hole_bottom_up(start, end, kbuf);
>  }
>  
> +#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)

The only caller is also guarded by these same ifdefs. Can't we remove this and
rely on the compilers dead-code elimination to remove this function when its not
needed?


> +static int kexec_walk_memblock(struct kexec_buf *kbuf,
> +			       int (*func)(struct resource *, void *))
> +{
> +	u64 i;
> +	phys_addr_t mstart, mend;
> +	struct resource res = { };
> +	int ret = 0;


Keeping this patch as 'just' moving code would avoid having to play
spot-the-difference:

> +	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> +		return func(&crashk_res, kbuf);

This will be new for powerpc, but any attempt to use it should be caught by
arch_kexec_kernel_image_probe(), which has:
|	/* We don't support crash kernels yet. */
|	if (image->type == KEXEC_TYPE_CRASH)
|		return -EOPNOTSUPP;


Looks good to me! For what its worth:
Acked-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
