Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Sun, 30 Sep 2018 18:10:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v15 05/16] kexec_file: kexec_walk_memblock() only walks a
 dedicated region at kdump
Message-ID: <20180930101001.GE6950@dhcp-128-65.nay.redhat.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-6-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180928064841.14117-6-takahiro.akashi@linaro.org>
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
Cc: prudo@linux.ibm.com, herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, schwidefsky@de.ibm.com, james.morse@arm.com, davem@davemloft.net, vgoyal@redhat.com

On 09/28/18 at 03:48pm, AKASHI Takahiro wrote:
> In kdump case, there exists only one dedicated memblock region as usable
> memory (crashk_res). With this patch, kexec_walk_memblock() runs a given
> callback function on this region.
> 
> Cosmetic change: 0 to MEMBLOCK_NONE at for_each_free_mem_range*()
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>

Acked-by: Dave Young <dyoung@redhat.com>

> ---
>  kernel/kexec_file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 370d7eab49fe..2f615a7968dd 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -511,8 +511,11 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
>  	phys_addr_t mstart, mend;
>  	struct resource res = { };
>  
> +	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> +		return func(&crashk_res, kbuf);
> +
>  	if (kbuf->top_down) {
> -		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
> +		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, MEMBLOCK_NONE,
>  						&mstart, &mend, NULL) {
>  			/*
>  			 * In memblock, end points to the first byte after the
> @@ -526,8 +529,8 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
>  				break;
>  		}
>  	} else {
> -		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
> -					NULL) {
> +		for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
> +					&mstart, &mend, NULL) {
>  			/*
>  			 * In memblock, end points to the first byte after the
>  			 * range while in kexec, end points to the last byte
> -- 
> 2.19.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
