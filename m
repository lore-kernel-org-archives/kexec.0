Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YrhSY-0008Na-UK
 for kexec@lists.infradead.org; Mon, 11 May 2015 06:45:04 +0000
Received: by pacwv17 with SMTP id wv17so102520646pac.0
 for <kexec@lists.infradead.org>; Sun, 10 May 2015 23:44:40 -0700 (PDT)
Message-ID: <55504FCB.6000306@linaro.org>
Date: Mon, 11 May 2015 15:44:27 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [v2 1/5] arm64: kdump: reserve memory for crash dump kernel
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <1429861989-8417-2-git-send-email-takahiro.akashi@linaro.org>
 <20150424101136.GE29183@leverpostej>
In-Reply-To: <20150424101136.GE29183@leverpostej>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "hbabus@us.ibm.com" <hbabus@us.ibm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "geoff@infradead.org" <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 04/24/2015 07:11 PM, Mark Rutland wrote:
> On Fri, Apr 24, 2015 at 08:53:04AM +0100, AKASHI Takahiro wrote:
>> On system kernel, the memory region used by crash dump kernel must be
>> specified by "crashkernel=X@Y" boot parameter. reserve_crashkernel()
>> will allocate the region in "System RAM" and reserve it for later use.
>>
>> On crash dump kernel, memory region information in system kernel is
>> described in a specific region specified by "elfcorehdr=X@Y" boot parameter.
>> reserve_elfcorehdr() will set aside the region to avoid data destruction
>> by the kernel.
>>
>> Crash dump kernel will access memory regions in system kernel via
>> copy_oldmem_page(), which reads a page by ioremap'ing it assuming that
>> such pages are not part of main memory of crash dump kernel.
>> This is true under non-UEFI environment because kexec-tools modifies
>> a device tree adding "usablemem" attributes to memory sections.
>
> I'm not sure what you mean by "usablemem" here.

I think I explained it in my previous reply.

> Do you just mean that the memory nodes are altered such that they only
> cover memory usable by the crash kernel?
>
> Why not _always_ require a command line argument for the crash kernel
> that restricts its memory usage to a particular range? That way it
> doesn't matter whether we're using UEFI or not.

This is one option, but why does uefi ignore all the memory properties?

>> Under UEFI, however, this is not true because UEFI remove memory sections
>> in a device tree and export all the memory regions, even though they belong
>> to system kernel.
>>
>> So we should add "mem=X[MG]" boot parameter to limit the memory size and
>> avoid hitting the following assertion in ioremap():
>>          if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
>>                  return NULL;
>
> That looks suspicious. What is being ioremapped at that point?

As explained so far, all the memory regions are exposed to crash dump kernel,
and it recognizes any pages which should belong to the old kernel also as
part of crash kernel's memory. So pfn_valid() returns true.


> [...]
>
>> @@ -393,6 +398,7 @@ void __init setup_arch(char **cmdline_p)
>>          local_async_enable();
>>
>>          efi_init();
>> +
>>          arm64_memblock_init();
>>
>>          paging_init();
>
> Nit: unrelated whitespace change.

Ok. Will fix it.

>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index ae85da6..ea70d41 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -34,6 +34,8 @@
>>   #include <linux/dma-contiguous.h>
>>   #include <linux/efi.h>
>>   #include <linux/swiotlb.h>
>> +#include <linux/kexec.h>
>> +#include <linux/crash_dump.h>
>
> Nit: please keep these ordered.

Yeah, but others "linux/*.h" in this file are already in a random order.


> [...]
>
>> +               if (memblock_reserve(crash_base, crash_size)) {
>> +                       pr_warn("crashkernel reservation failed - out of memory\n");
>> +                       return;
>> +               }
>
> If we can remove this memory rather than reserving it, we can limit the
> first kernel's ability to accidentally clobber the crash kernel, at the
> expense of having to explicitly map/unmap around loading it.

Do you mean that we should remove mmu mapping of crash kernel memory?
Might be a good idea, but it requires modifying kernel/kexec.c.

-Takahiro AKASHI

> Mark.
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
