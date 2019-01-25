Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmrze-00050d-Cd
 for kexec@lists.infradead.org; Fri, 25 Jan 2019 03:17:24 +0000
Subject: Re: [PATCH 2/2] Remove the memory encryption mask to obtain the true
 physical address
References: <20190122080357.23381-1-lijiang@redhat.com>
 <20190122080357.23381-3-lijiang@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03566DC7@BPXM09GP.gisp.nec.co.jp>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03566F74@BPXM09GP.gisp.nec.co.jp>
From: lijiang <lijiang@redhat.com>
Message-ID: <26f5aa4b-cb5f-ba17-85d3-591cc4cc6e70@redhat.com>
Date: Fri, 25 Jan 2019 11:17:13 +0800
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03566F74@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "anderson@redhat.com" <anderson@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

在 2019年01月25日 03:33, Kazuhito Hagio 写道:
> On 1/23/2019 5:16 PM, Kazuhito Hagio wrote:
>> On 1/22/2019 3:03 AM, Lianbo Jiang wrote:
>>> For AMD machine with SME feature, if SME is enabled in the first
>>> kernel, the crashed kernel's page table(pgd/pud/pmd/pte) contains
>>> the memory encryption mask, so makedumpfile needs to remove the
>>> memory encryption mask to obtain the true physical address.
>>>
>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>> ---
>>>  arch/x86_64.c  | 3 +++
>>>  makedumpfile.c | 1 +
>>>  2 files changed, 4 insertions(+)
>>>
>>> diff --git a/arch/x86_64.c b/arch/x86_64.c
>>> index 537fb78..7651d36 100644
>>> --- a/arch/x86_64.c
>>> +++ b/arch/x86_64.c
>>> @@ -346,6 +346,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>>>  			return NOT_PADDR;
>>>  		}
>>>  		pud_paddr  = pgd & ENTRY_MASK;
>>> +		pud_paddr = pud_paddr & ~(NUMBER(sme_mask));
>>>  	}
>>>
>>>  	/*
>>> @@ -371,6 +372,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>>>  	 * Get PMD.
>>>  	 */
>>>  	pmd_paddr  = pud_pte & ENTRY_MASK;
>>> +	pmd_paddr = pmd_paddr & ~(NUMBER(sme_mask));
>>>  	pmd_paddr += pmd_index(vaddr) * sizeof(unsigned long);
>>>  	if (!readmem(PADDR, pmd_paddr, &pmd_pte, sizeof pmd_pte)) {
>>>  		ERRMSG("Can't get pmd_pte (pmd_paddr:%lx).\n", pmd_paddr);
>>> @@ -391,6 +393,7 @@ __vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>>>  	 * Get PTE.
>>>  	 */
>>>  	pte_paddr  = pmd_pte & ENTRY_MASK;
>>> +	pte_paddr = pte_paddr & ~(NUMBER(sme_mask));
>>>  	pte_paddr += pte_index(vaddr) * sizeof(unsigned long);
>>>  	if (!readmem(PADDR, pte_paddr, &pte, sizeof pte)) {
>>>  		ERRMSG("Can't get pte (pte_paddr:%lx).\n", pte_paddr);
>>> diff --git a/makedumpfile.c b/makedumpfile.c
>>> index a03aaa1..81c7bb4 100644
>>> --- a/makedumpfile.c
>>> +++ b/makedumpfile.c
>>> @@ -977,6 +977,7 @@ next_page:
>>>  	read_size = MIN(info->page_size - PAGEOFFSET(paddr), size);
>>>
>>>  	pgaddr = PAGEBASE(paddr);
>>> +	pgaddr = pgaddr & ~(NUMBER(sme_mask));
>>
>> Since NUMBER(sme_mask) is initialized with -1 (NOT_FOUND_NUMBER),
>> if the sme_mask is not in vmcoreinfo, ~(NUMBER(sme_mask)) will be 0.
>> So the four lines added above need
>>
>>   if (NUMBER(sme_mask) != NOT_FOUND_NUMBER)
>>     ...
> 
> Considering hugepage and the code, it might be better to add
> a local variable for the mask value to __vtop4_x86_64() function
> and mask it without condition, for example
> 
>   unsigned long sme_mask = ~0UL;
> 
>   if (NUMBER(sme_mask) != NOT_FOUND_NUMBER)
>       sme_mask = ~(NUMBER(sme_mask));
>   ...
>   pud_paddr = pgd & ENTRY_MASK & sme_mask;
> 
> to avoid adding lots of 'if' statements.
> 

Good idea. Thank you, Kazu.

> Thanks,
> Kazu
> 
>>
>> and, what I'm wondering is whether it doesn't need to take hugepages
>> into account such as this
>>
>> 392         if (pmd_pte & _PAGE_PSE)        /* 2MB pages */
>> 393                 return (pmd_pte & ENTRY_MASK & PMD_MASK) +
>> 394                         (vaddr & ~PMD_MASK);
>> "arch/x86_64.c"
>>
>> Thanks,
>> Kazu
>>
>>
>>>  	pgbuf = cache_search(pgaddr, read_size);
>>>  	if (!pgbuf) {
>>>  		++cache_miss;
>>> --
>>> 2.17.1
>>>
>>
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
