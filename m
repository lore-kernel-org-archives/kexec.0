Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNEFL-0001N5-Ai
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 07:06:16 +0000
Message-ID: <5785E764.8050304@huawei.com>
Date: Wed, 13 Jul 2016 15:01:56 +0800
From: zhong jiang <zhongjiang@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] kexec: add a pmd huge entry condition during the
 page table
References: <1468299403-27954-1-git-send-email-zhongjiang@huawei.com>
 <1468299403-27954-2-git-send-email-zhongjiang@huawei.com>
 <87a8hm3lme.fsf@x220.int.ebiederm.org>
In-Reply-To: <87a8hm3lme.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: dyoung@redhat.com, kexec@lists.infradead.org, linux-mm@kvack.org, horms@verge.net.au, akpm@linux-foundation.org, yinghai@kernel.org, vgoyal@redhat.com

On 2016/7/12 23:46, Eric W. Biederman wrote:
> zhongjiang <zhongjiang@huawei.com> writes:
>
>> From: zhong jiang <zhongjiang@huawei.com>
>>
>> when image is loaded into kernel, we need set up page table for it. and 
>> all valid pfn also set up new mapping. it will tend to establish a pmd 
>> page table in the form of a large page if pud_present is true. relocate_kernel 
>> points to code segment can locate in the pmd huge entry in init_transtion_pgtable. 
>> therefore, we need to take the situation into account.
> I can see how in theory this might be necessary but when is a kernel virtual
> address on x86_64 that is above 0x8000000000000000 in conflict with an
> identity mapped physicall address that are all below 0x8000000000000000?
>
> If anything the code could be simplified to always assume those mappings
> are unoccupied.
>
> Did you run into an actual failure somewhere?
>
> Eric
>
   I  do not understand what you trying to say,  Maybe I miss your point.
  
  The key is how to ensure that relocate_kernel points to the pmd entry is not huge page.
 
  Thanks
  zhongjiang
 
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  arch/x86/kernel/machine_kexec_64.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index 5a294e4..c33e344 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/gfp.h>
>>  #include <linux/reboot.h>
>>  #include <linux/numa.h>
>> +#include <linux/hugetlb.h>
>>  #include <linux/ftrace.h>
>>  #include <linux/io.h>
>>  #include <linux/suspend.h>
>> @@ -34,6 +35,17 @@ static struct kexec_file_ops *kexec_file_loaders[] = {
>>  };
>>  #endif
>>  
>> +static void split_pmd(pmd_t *pmd, pte_t *pte)
>> +{
>> +	unsigned long pfn = pmd_pfn(*pmd);
>> +	int i = 0;
>> +
>> +	do {
>> +		set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
>> +		pfn++;
>> +	} while (pte++, i++, i < PTRS_PER_PTE);
>> +}
>> +
>>  static void free_transition_pgtable(struct kimage *image)
>>  {
>>  	free_page((unsigned long)image->arch.pud);
>> @@ -68,15 +80,19 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>>  		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
>>  	}
>>  	pmd = pmd_offset(pud, vaddr);
>> -	if (!pmd_present(*pmd)) {
>> +	if (!pmd_present(*pmd) || pmd_huge(*pmd)) {
>>  		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
>>  		if (!pte)
>>  			goto err;
>>  		image->arch.pte = pte;
>> -		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
>> +		if (pmd_huge(*pmd))
>> +			split_pmd(pmd, pte);
>> +		else
>> +			set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
>>  	}
>>  	pte = pte_offset_kernel(pmd, vaddr);
>>  	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC));
>> +
>>  	return 0;
>>  err:
>>  	free_transition_pgtable(image);
> .
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
