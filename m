Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwQXZ-0006UW-3H
 for kexec@lists.infradead.org; Tue, 09 Jul 2013 05:32:44 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id ACEB13EE0C3
 for <kexec@lists.infradead.org>; Tue,  9 Jul 2013 14:32:12 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9C9C145DE59
 for <kexec@lists.infradead.org>; Tue,  9 Jul 2013 14:32:12 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 76DB345DE54
 for <kexec@lists.infradead.org>; Tue,  9 Jul 2013 14:32:12 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6A100E08002
 for <kexec@lists.infradead.org>; Tue,  9 Jul 2013 14:32:12 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 113181DB803E
 for <kexec@lists.infradead.org>; Tue,  9 Jul 2013 14:32:12 +0900 (JST)
Message-ID: <51DBA029.3060009@jp.fujitsu.com>
Date: Tue, 09 Jul 2013 14:31:21 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <51DA4ED9.60903@jp.fujitsu.com> <20130708112839.498ccfc6@holzheu>
In-Reply-To: <20130708112839.498ccfc6@holzheu>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

(2013/07/08 18:28), Michael Holzheu wrote:
> On Mon, 08 Jul 2013 14:32:09 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>
>> (2013/07/02 4:32), Michael Holzheu wrote:
>>> For zfcpdump we can't map the HSA storage because it is only available
>>> via a read interface. Therefore, for the new vmcore mmap feature we have
>>> introduce a new mechanism to create mappings on demand.
>>>
>>> This patch introduces a new architecture function remap_oldmem_pfn_range()
>>> that should be used to create mappings with remap_pfn_range() for oldmem
>>> areas that can be directly mapped. For zfcpdump this is everything besides
>>> of the HSA memory. For the areas that are not mapped by remap_oldmem_pfn_range()
>>> a generic vmcore a new generic vmcore fault handler mmap_vmcore_fault()
>>> is called.
>>>
>>
>> This fault handler is only for s390 specific issue. Other architectures don't need
>> this for the time being.
>>
>> Also, from the same reason, I'm doing this review based on source code only.
>> I cannot run the fault handler on meaningful system, which is currently s390 only.
>
> You can test the code on other architectures if you do not map anything in advance.
> For example you could just "return 0" in remap_oldmem_pfn_range():
>
> /*
>   * Architectures may override this function to map oldmem
>   */
> int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
>                                    unsigned long from, unsigned long pfn,
>                                    unsigned long size, pgprot_t prot)
> {
>          return 0;
> }
>
> In that case for all pages the new mechanism would be used.
>

I meant without modifying source code at all. You say I need to define some function.

<cut>
>>
>>> +static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
>>> +{
>>> +	struct address_space *mapping = vma->vm_file->f_mapping;
>>> +	pgoff_t index = vmf->pgoff;
>>> +	struct page *page;
>>> +	loff_t src;
>>> +	char *buf;
>>> +	int rc;
>>> +
>>
>> You should check where faulting address points to valid range.
>> If the fault happens on invalid range, return VM_FAULT_SIGBUS.
>>
>> On s390 case, I think the range except for HSA should be thought of as invalid.
>>
>
> Hmmm, this would require another architecture backend interface. If we get a fault
> for a page outside of the HSA this would be a programming error in our code. Not
> sure if we should introduce new architecture interfaces just for sanity checks.
>

I think you need to introduce the backend interface since it's bug if it happens.
The current implementation hides such erroneous path due to generic implementation.

I also don't think it's big change from this version since you have already been
about to introduce several backend interfaces.

>>> +	page = find_or_create_page(mapping, index, GFP_KERNEL);
>>> +	if (!page)
>>> +		return VM_FAULT_OOM;
>>> +	if (!PageUptodate(page)) {
>>> +		src = index << PAGE_CACHE_SHIFT;
>>
>> src = (loff_t)index << PAGE_CACHE_SHIFT;
>>
>> loff_t has long long while index has unsigned long.
>
> Ok.
>
>> On s390 both might have the same byte length.
>
> On s390x both are 64 bit. On our 32 bit s390 archtecture long long is 64 bit
> and unsigned long 32 bit.
>
>> Also I prefer offset to src, but this is minor suggestion.
>
> Yes, I agree.
>
>>
>>> +		buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);
>>
>> I found page_to_virt() macro.
>
> Looks like page_to_virt() is not usable on most architectures and probably
> pfn_to_kaddr(pfn) would be the correct thing here. Unfortunately is also not
> defined on s390.
>
> But when I discussed your comment with Martin, we found out that the current
>
> buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);
>
> is not correct on x86. It should be:
>
> buf = __va((page_to_pfn(page) << PAGE_SHIFT));
>

It seems OK for this.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
