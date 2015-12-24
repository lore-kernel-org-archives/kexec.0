Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aBzdl-0007L3-I0
 for kexec@lists.infradead.org; Thu, 24 Dec 2015 06:44:46 +0000
Subject: Re: [PATCH 2/2] kexec: Provide
 arch_kexec_protect(unprotect)_crashkres()
References: <1450869146-6186-1-git-send-email-xlpang@redhat.com>
 <1450869146-6186-2-git-send-email-xlpang@redhat.com>
 <20151224055425.GC3480@dhcp-128-65.nay.redhat.com>
 <567B8B44.9070807@redhat.com>
 <20151224061616.GD3480@dhcp-128-65.nay.redhat.com>
From: Xunlei Pang <xlpang@redhat.com>
Message-ID: <567B9444.1050608@redhat.com>
Date: Thu, 24 Dec 2015 14:44:20 +0800
MIME-Version: 1.0
In-Reply-To: <20151224061616.GD3480@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, Eric Biederman <ebiederm@xmission.com>

On 12/24/2015 at 02:16 PM, Dave Young wrote:
> Hi, Xunlei
>
> On 12/24/15 at 02:05pm, Xunlei Pang wrote:
>> On 12/24/2015 at 01:54 PM, Dave Young wrote:
>>> Ccing Vivek
>>>
>>> On 12/23/15 at 07:12pm, Xunlei Pang wrote:
>>>> Implement the protection method for the crash kernel memory
>>>> reservation for the 64-bit x86 kdump.
>>>>
>>>> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
>>>> ---
>>>> Only provided x86_64 implementation, as I've only tested on x86_64 so far.
>>>>
>>>>  arch/x86/kernel/machine_kexec_64.c | 43 ++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 43 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>>>> index 819ab3f..a3d289c 100644
>>>> --- a/arch/x86/kernel/machine_kexec_64.c
>>>> +++ b/arch/x86/kernel/machine_kexec_64.c
>>>> @@ -536,3 +536,46 @@ overflow:
>>>>  	return -ENOEXEC;
>>>>  }
>>>>  #endif /* CONFIG_KEXEC_FILE */
>>>> +
>>>> +#ifdef CONFIG_KEXEC_CORE
>>> The file is only compiled when CONFIG_KEXEC_CORE=y so #ifdef is not necessary
>> Yes, indeed. I'll remove this macro and send v2 later.
>>
>>>> +static int
>>>> +kexec_mark_range(unsigned long start, unsigned long end, bool protect)
>>>> +{
>>>> +	struct page *page;
>>>> +	unsigned int nr_pages;
>>>> +
>>>> +	if (!start || !end || start >= end)
>>>> +		return 0;
>>>> +
>>>> +	page = pfn_to_page(start >> PAGE_SHIFT);
>>>> +	nr_pages = (end + 1 - start) >> PAGE_SHIFT;
>>>> +	if (protect)
>>>> +		return set_pages_ro(page, nr_pages);
>>>> +	else
>>>> +		return set_pages_rw(page, nr_pages);
>>> May use set_memory_ro/rw to avoid converting to *page?
>> on x86 it just a wrapper of set_memory_ro/rw, I think both are ok.
> Ok, I have no strong opinion on that..
>
>>>> +}
>>>> +
>>>> +static void kexec_mark_crashkres(bool protect)
>>>> +{
>>>> +	unsigned long control;
>>>> +
>>>> +	kexec_mark_range(crashk_low_res.start, crashk_low_res.end, protect);
>>>> +
>>>> +	/* Don't touch the control code page used in crash_kexec().*/
>>>> +	control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
>>>> +	/* Control code page is located in the 2nd page. */
>>>> +	control = control + PAGE_SIZE;
> Though it works because the control code is less than 1 page, but use the macro
> of KEXEC_CONTROL_PAGE_SIZE looks better..
>
>>>> +	kexec_mark_range(crashk_res.start, control - 1, protect);
>>>> +	kexec_mark_range(control + PAGE_SIZE, crashk_res.end, protect);
>>> X86 kexec will copy the page while kexecing, could you check if we can move
>>> that copying to earliyer while kexec loading, maybe machine_kexec_prepare so
>>> that we can make a arch-independent implementation.
>> For some arch, may use huge tlb directly to do the kernel mapping,
>> in such cases, we can't implement this function. So I think it should
>> be arch-dependent.
> Ok, that's fine.

At least moving the x86 control-copying code into arch-related
machine_kexec_prepare() should work, and this can omit the
special treatment of the control code page.

Regards,
Xunlei

>
>> Regards,
>> Xunlei
>>
>>>> +}
>>>> +
>>>> +void arch_kexec_protect_crashkres(void)
>>>> +{
>>>> +	kexec_mark_crashkres(true);
>>>> +}
>>>> +
>>>> +void arch_kexec_unprotect_crashkres(void)
>>>> +{
>>>> +	kexec_mark_crashkres(false);
>>>> +}
>>>> +#endif
>>>> -- 
>>>> 2.5.0
>>>>
>>>>
>>>> _______________________________________________
>>>> kexec mailing list
>>>> kexec@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> Thanks
> Dave
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
