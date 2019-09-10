Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v4 05/17] arm64: hibernate: remove gotos in
 create_safe_exec_page
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
 <20190909181221.309510-6-pasha.tatashin@soleen.com>
From: Matthias Brugger <mbrugger@suse.com>
Message-ID: <9135be3e-cf7e-821d-928d-db98aa3ec9c8@suse.com>
Date: Tue, 10 Sep 2019 10:21:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190909181221.309510-6-pasha.tatashin@soleen.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com



On 09/09/2019 20:12, Pavel Tatashin wrote:
> Usually, gotos are used to handle cleanup after exception, but
> in case of create_safe_exec_page there are no clean-ups. So,
> simply return the errors directly.
> 

While at it, how about also cleaning up swsusp_arch_resume() which has the same
issue.

Regards,
Matthias

> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/kernel/hibernate.c | 34 +++++++++++-----------------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 47a861e0cb0c..7bbeb33c700d 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -198,7 +198,6 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  				 unsigned long dst_addr,
>  				 phys_addr_t *phys_dst_addr)
>  {
> -	int rc = 0;
>  	pgd_t *trans_pgd;
>  	pgd_t *pgdp;
>  	pud_t *pudp;
> @@ -206,47 +205,37 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  	pte_t *ptep;
>  	unsigned long dst = get_safe_page(GFP_ATOMIC);
>  
> -	if (!dst) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	if (!dst)
> +		return -ENOMEM;
>  
>  	memcpy((void *)dst, src_start, length);
>  	__flush_icache_range(dst, dst + length);
>  
>  	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
> -	if (!trans_pgd) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	if (!trans_pgd)
> +		return -ENOMEM;
>  
>  	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
>  	if (pgd_none(READ_ONCE(*pgdp))) {
>  		pudp = (void *)get_safe_page(GFP_ATOMIC);
> -		if (!pudp) {
> -			rc = -ENOMEM;
> -			goto out;
> -		}
> +		if (!pudp)
> +			return -ENOMEM;
>  		pgd_populate(&init_mm, pgdp, pudp);
>  	}
>  
>  	pudp = pud_offset(pgdp, dst_addr);
>  	if (pud_none(READ_ONCE(*pudp))) {
>  		pmdp = (void *)get_safe_page(GFP_ATOMIC);
> -		if (!pmdp) {
> -			rc = -ENOMEM;
> -			goto out;
> -		}
> +		if (!pmdp)
> +			return -ENOMEM;
>  		pud_populate(&init_mm, pudp, pmdp);
>  	}
>  
>  	pmdp = pmd_offset(pudp, dst_addr);
>  	if (pmd_none(READ_ONCE(*pmdp))) {
>  		ptep = (void *)get_safe_page(GFP_ATOMIC);
> -		if (!ptep) {
> -			rc = -ENOMEM;
> -			goto out;
> -		}
> +		if (!ptep)
> +			return -ENOMEM;
>  		pmd_populate_kernel(&init_mm, pmdp, ptep);
>  	}
>  
> @@ -272,8 +261,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  
>  	*phys_dst_addr = virt_to_phys((void *)dst);
>  
> -out:
> -	return rc;
> +	return 0;
>  }
>  
>  #define dcache_clean_range(start, end)	__flush_dcache_area(start, (end - start))
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
