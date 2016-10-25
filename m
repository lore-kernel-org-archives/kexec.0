Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bz3Ou-0004Cr-Ja
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 15:12:32 +0000
Received: by mail-qt0-f180.google.com with SMTP id g49so10861252qtc.6
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 08:12:08 -0700 (PDT)
Subject: Re: [PATCH Makedumpfile 2/4] x86_64: translate all VA to PA using
 page table values
References: <cover.1477327674.git.panand@redhat.com>
 <b54b1e73bc4302fa7222c44a9cf46d57aa93b8ba.1477327674.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E7A30E@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <f29a272d-8b82-d0d7-a2f2-c4af6474fff6@redhat.com>
Date: Tue, 25 Oct 2016 20:42:02 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E7A30E@BPXM01GP.gisp.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "dyoung@redhat.com" <dyoung@redhat.com>

Hi Atsushi,

Thanks for the review.

On Tuesday 25 October 2016 02:50 PM, Atsushi Kumagai wrote:
> Hello Pratysh,
>
>> Currently we translate some of the VA areas using linear mapping while some
>> other(which can not be linearly mapped) using page table.
>>
>> However, we will have entry of a page in the page table irrespective of its
>> virtual region. So, we can always look into page table for any VA to PA
>> translation. This approach will solve lot of complexity in makedumpfile. It
>> will in turn remove dependency over variables like VMALLOC_START,
>> MODULES_VADDR etc whose definition keeps changing in newer kernel version.
>>
>> Moreover, I do not see any side effect of this approach in terms of
>> execution timing. I tested with IBM x3950 X6 machine having 4136359 MB of
>> memory. These are the results of makedumpfile execution time:
>>
>> Without this patch:
>> ===================
>> With -d 31:
>> Trial 1: 237.59526248 S
>> Trial 2: 235.236914962 S
>> Trail 3: 237.678712045 S
>>
>> With -d 1:
>> Trial 1: 2548.905296877 S
>> Trial 2: 2549.759881756 S
>>
>> With this patch:
>> ===================
>> With -d 31:
>> Trial 1: 232.713841516 S
>> Trial 2: 228.45697177 S
>> Trail 3: 232.942262441 S
>>
>> With -d 1:
>> Trial 1: 2768.424565806 S
>> Trial 2: 2749.622115455 S
>> Trail 3: 2537.770359073 S
>
> Could you increase the number of trials ?

OK, I can do that. Might take some time, as I will have to arrange that  
high memory machine again.

> If the average time is close to the results of Trial 1 (2768s) and 2 (2749s),
> the regression rate is 8% and it sounds neither large nor small.
> If the average is a level of 2500s like Trial 3, it's ideal.
>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>> arch/x86_64.c  | 42 ++++++++----------------------------------
>> makedumpfile.h |  4 ++--
>> 2 files changed, 10 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/x86_64.c b/arch/x86_64.c
>> index a96fd8ae00a1..fe2764a8bec2 100644
>> --- a/arch/x86_64.c
>> +++ b/arch/x86_64.c
>> @@ -203,6 +203,12 @@ vtop4_x86_64(unsigned long vaddr)
>> {
>> 	unsigned long page_dir, pml4, pgd_paddr, pgd_pte, pmd_paddr, pmd_pte;
>> 	unsigned long pte_paddr, pte;
>> +	unsigned long phys_base;
>> +
>> +	if (SYMBOL(phys_base) != NOT_FOUND_SYMBOL)
>> +		phys_base = info->phys_base;
>> +	else
>> +		phys_base = 0;
>>
>> 	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL) {
>> 		ERRMSG("Can't get the symbol of init_level4_pgt.\n");
>> @@ -212,9 +218,9 @@ vtop4_x86_64(unsigned long vaddr)
>> 	/*
>> 	 * Get PGD.
>> 	 */
>> -	page_dir  = SYMBOL(init_level4_pgt);
>> +	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + phys_base;
>
> I want to confirm that this VA to PA translation is always safe,
> otherwise we should do the condition check which was done in
> vaddr_to_paddr_x86_64(), isn't it ?
>

I think this should be safe, however x86 expert can comment better.  
Baoquan any comment here?

~Pratyush
>
> Thanks,
> Atsushi Kumagai
>
>> 	page_dir += pml4_index(vaddr) * sizeof(unsigned long);
>> -	if (!readmem(VADDR, page_dir, &pml4, sizeof pml4)) {
>> +	if (!readmem(PADDR, page_dir, &pml4, sizeof pml4)) {
>> 		ERRMSG("Can't get pml4 (page_dir:%lx).\n", page_dir);
>> 		return NOT_PADDR;
>> 	}
>> @@ -285,38 +291,6 @@ vtop4_x86_64(unsigned long vaddr)
>> 	return (pte & ENTRY_MASK) + PAGEOFFSET(vaddr);
>> }
>>
>> -unsigned long long
>> -vaddr_to_paddr_x86_64(unsigned long vaddr)
>> -{
>> -	unsigned long phys_base;
>> -	unsigned long long paddr;
>> -
>> -	/*
>> -	 * Check the relocatable kernel.
>> -	 */
>> -	if (SYMBOL(phys_base) != NOT_FOUND_SYMBOL)
>> -		phys_base = info->phys_base;
>> -	else
>> -		phys_base = 0;
>> -
>> -	if (is_vmalloc_addr_x86_64(vaddr)) {
>> -		if ((paddr = vtop4_x86_64(vaddr)) == NOT_PADDR) {
>> -			ERRMSG("Can't convert a virtual address(%lx) to " \
>> -			    "physical address.\n", vaddr);
>> -			return NOT_PADDR;
>> -		}
>> -	} else if (vaddr >= __START_KERNEL_map) {
>> -		paddr = vaddr - __START_KERNEL_map + phys_base;
>> -
>> -	} else {
>> -		if (is_xen_memory())
>> -			paddr = vaddr - PAGE_OFFSET_XEN_DOM0;
>> -		else
>> -			paddr = vaddr - PAGE_OFFSET;
>> -	}
>> -	return paddr;
>> -}
>> -
>> /*
>>  * for Xen extraction
>>  */
>> diff --git a/makedumpfile.h b/makedumpfile.h
>> index a5955ff750e5..13559651feb6 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -863,12 +863,12 @@ int is_vmalloc_addr_x86_64(ulong vaddr);
>> int get_phys_base_x86_64(void);
>> int get_machdep_info_x86_64(void);
>> int get_versiondep_info_x86_64(void);
>> -unsigned long long vaddr_to_paddr_x86_64(unsigned long vaddr);
>> +unsigned long long vtop4_x86_64(unsigned long vaddr);
>> #define find_vmemmap()		find_vmemmap_x86_64()
>> #define get_phys_base()		get_phys_base_x86_64()
>> #define get_machdep_info()	get_machdep_info_x86_64()
>> #define get_versiondep_info()	get_versiondep_info_x86_64()
>> -#define vaddr_to_paddr(X)	vaddr_to_paddr_x86_64(X)
>> +#define vaddr_to_paddr(X)	vtop4_x86_64(X)
>> #define is_phys_addr(X)		(!is_vmalloc_addr_x86_64(X))
>> #endif /* x86_64 */
>>
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
