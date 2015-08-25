Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZU20E-0005lY-HX
 for kexec@lists.infradead.org; Tue, 25 Aug 2015 00:22:15 +0000
Message-ID: <797166011523512cf7099f14770922b4.squirrel@www.codeaurora.org>
In-Reply-To: <5053347ed9f8e4e245d8438b3a8c981d.squirrel@www.codeaurora.org>
References: <20150627082256.GE21646@localhost.localdomain>
 <ddc87d025100347122b078b5104ec88c.squirrel@www.codeaurora.org>
 <20150703043241.GC21990@dhcppc13.redhat.com>
 <2c41ac3516494a1cc5d05462494b333b.squirrel@www.codeaurora.org>
 <c0ce0a0ea4482e9fca97b5c811f4693b.squirrel@www.codeaurora.org>
 <d0d13b96c02d5b54afcda30723667dab.squirrel@www.codeaurora.org>
 <20150820112150.GA26132@dhcppc13.redhat.com>
 <cd279166af08eba11be211481f319ab8.squirrel@www.codeaurora.org>
 <20150821034433.GB26132@dhcppc13.redhat.com>
 <006bee38a745c1ca9199870ca8cc600b.squirrel@www.codeaurora.org>
 <20150822035445.GC3013@dhcppc13.redhat.com>
 <5053347ed9f8e4e245d8438b3a8c981d.squirrel@www.codeaurora.org>
Date: Tue, 25 Aug 2015 00:21:53 -0000
Subject: Re: [PATCH] makedumpfile: Support ARM64
From: sgoel@codeaurora.org
MIME-Version: 1.0
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
To: Pratyush Anand <panand@redhat.com>
Cc: Timur Tabi <timur@codeaurora.org>, Azriel Samson <asamson@codeaurora.org>, kexec@lists.infradead.org, sgoel@codeaurora.org, virajm@codeaurora.org, ats-kumagai@wm.jp.nec.com

I also looked at the definitions for PMD_OFFSET in the code and this is
evaluating to no PMD. This should not be the case. So, I am wondering if
these defines should change?

I tried changing these but still the virtual address to physical address
translation is failing.

Please comment.
Thanks,
Sameer



>> * You did following changes on top of
>> https://github.com/pratyushanand/makedumpfile.git:arm64_support (last
>> commit
>> 597ea74d40b7 arm64: Fix KVBASE) and it worked for you, right?
>
> Yes. Making the change to kernel struct page size fixed the memory map
> values. We are using a 4.0.0 kernel. I checked the struct page and there
> are some changes to it between the kernel versions. There is no platform
> specific change that we have made.
>
> The code still cannot find the free pages as it is exiting due to a
> virtual to physical translation.
> readmem: Can't convert a virtual address(ffffffbee0023000) to physical
> address.
> readmem: type_addr: 0, addr:ffffffbee0023000, size:28672
> __exclude_unnecessary_pages: Can't read the buffer of struct page.
> create_2nd_bitmap: Can't exclude unnecessary pages.
>
> The above is a valid virtual address and maps to a correct physical
> address when I check this using kmem -p using the crash tool. Any help
> will be appreciated.
>
> Thanks,
> Sameer
>
>
>
>> On 21/08/2015:08:37:57 PM, sgoel@codeaurora.org wrote:
>>> > Can you compare "Virtual kernel memory layout:" print of Linux kernel
>>> boot
>>> > with
>>> > makedumpfile print for page_offset, vmalloc_start, vmemmap_start etc,
>>> and
>>> > see if
>>> > they match?
>>> >
>>> > They should match.
>>>
>>>
>>> Yes this was a problem. The assumed Kernel struct page size in the tool
>>> is
>>> 64. For our platform this evaluates to 56. After changing this value
>>> all
>>> the memory mapping values match.
>>
>> Great !!!
>>
>> To be on the same page:
>> * You did following changes on top of
>> https://github.com/pratyushanand/makedumpfile.git:arm64_support (last
>> commit
>> 597ea74d40b7 arm64: Fix KVBASE) and it worked for you, right? If yes,
>> then
>> is
>> there out of mainline change in struct page for you? If it is mainline,
>> then can
>> you please let me know the kernel version, so that on the basic of
>> kernel
>> version I can fix it.
>>
>> diff --git a/arch/arm64.c b/arch/arm64.c
>> index a94a4ba16dd5..4154ed6fe4a5 100644
>> --- a/arch/arm64.c
>> +++ b/arch/arm64.c
>> @@ -86,7 +86,7 @@ typedef struct {
>>  /* kernel struct page size can be kernel version dependent, currently
>>   * keep it constant.
>>   */
>> -#define KERN_STRUCT_PAGE_SIZE		64
>> +#define KERN_STRUCT_PAGE_SIZE		56
>>  #define ALIGN(x, a) 			(((x) + (a) - 1) & ~((a) - 1))
>>  #define PFN_DOWN(x)			((x) >> PAGE_SHIFT)
>>  #define VMEMMAP_SIZE			ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) *
>> KERN_STRUCT_PAGE_SIZE, PUD_SIZE)
>>
>>>
>>> I wanted to ask if the page table translation function would be any
>>> different if the page size is 4k instead of 64k?
>>
>> I believe, if we have programmed pgtable_level, va_bits and page_shift
>> correctly, then vtop_arm64 should be able to calculate it for both 4K
>> and
>> 64K.
>>
>> ~Pratyush
>>
>
>
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
