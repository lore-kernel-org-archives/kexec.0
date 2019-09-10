Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v4 04/17] arm64: hibernate: use get_safe_page directly
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
 <20190909181221.309510-5-pasha.tatashin@soleen.com>
From: Matthias Brugger <mbrugger@suse.com>
Message-ID: <e2ceb43a-d7bf-e0c6-c3ea-b83c95ba880d@suse.com>
Date: Tue, 10 Sep 2019 10:03:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190909181221.309510-5-pasha.tatashin@soleen.com>
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
> create_safe_exec_page() uses hibernate's allocator to create a set of page
> table to map a single page that will contain the relocation code.
> 
> Remove the allocator related arguments, and use get_safe_page directly, as
> it is done in other local functions in this file to simplify function
> prototype.
> 
> Removing this function pointer makes it easier to refactor the code later.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>  arch/arm64/kernel/hibernate.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 227cc26720f7..47a861e0cb0c 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -196,9 +196,7 @@ EXPORT_SYMBOL(arch_hibernation_header_restore);
>   */
>  static int create_safe_exec_page(void *src_start, size_t length,
>  				 unsigned long dst_addr,
> -				 phys_addr_t *phys_dst_addr,
> -				 void *(*allocator)(gfp_t mask),
> -				 gfp_t mask)
> +				 phys_addr_t *phys_dst_addr)
>  {
>  	int rc = 0;
>  	pgd_t *trans_pgd;
> @@ -206,7 +204,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  	pud_t *pudp;
>  	pmd_t *pmdp;
>  	pte_t *ptep;
> -	unsigned long dst = (unsigned long)allocator(mask);
> +	unsigned long dst = get_safe_page(GFP_ATOMIC);
>  
>  	if (!dst) {
>  		rc = -ENOMEM;
> @@ -216,7 +214,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  	memcpy((void *)dst, src_start, length);
>  	__flush_icache_range(dst, dst + length);
>  
> -	trans_pgd = allocator(mask);
> +	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
>  	if (!trans_pgd) {
>  		rc = -ENOMEM;
>  		goto out;
> @@ -224,7 +222,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  
>  	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
>  	if (pgd_none(READ_ONCE(*pgdp))) {
> -		pudp = allocator(mask);
> +		pudp = (void *)get_safe_page(GFP_ATOMIC);
>  		if (!pudp) {
>  			rc = -ENOMEM;
>  			goto out;
> @@ -234,7 +232,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  
>  	pudp = pud_offset(pgdp, dst_addr);
>  	if (pud_none(READ_ONCE(*pudp))) {
> -		pmdp = allocator(mask);
> +		pmdp = (void *)get_safe_page(GFP_ATOMIC);
>  		if (!pmdp) {
>  			rc = -ENOMEM;
>  			goto out;
> @@ -244,7 +242,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  
>  	pmdp = pmd_offset(pudp, dst_addr);
>  	if (pmd_none(READ_ONCE(*pmdp))) {
> -		ptep = allocator(mask);
> +		ptep = (void *)get_safe_page(GFP_ATOMIC);
>  		if (!ptep) {
>  			rc = -ENOMEM;
>  			goto out;
> @@ -530,8 +528,7 @@ int swsusp_arch_resume(void)
>  	 */
>  	rc = create_safe_exec_page(__hibernate_exit_text_start, exit_size,
>  				   (unsigned long)hibernate_exit,
> -				   &phys_hibernate_exit,
> -				   (void *)get_safe_page, GFP_ATOMIC);
> +				   &phys_hibernate_exit);
>  	if (rc) {
>  		pr_err("Failed to create safe executable page for hibernate_exit code.\n");
>  		goto out;
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
