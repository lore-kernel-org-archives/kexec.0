Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bl2nam02on061d.outbound.protection.outlook.com
 ([2a01:111:f400:fe46::61d]
 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dLWFq-00062M-MA
 for kexec@lists.infradead.org; Thu, 15 Jun 2017 15:00:16 +0000
Subject: Re: [PATCH v6 26/34] iommu/amd: Allow the AMD IOMMU to work with
 memory encryption
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191745.28645.81756.stgit@tlendack-t1.amdoffice.net>
 <20170614174208.p2yr5exs4b6pjxhf@pd.tnic>
 <0611d01a-19f8-d6ae-2682-932789855518@amd.com>
 <20170615094111.wga334kg2bhxqib3@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <921153f5-1528-31d8-b815-f0419e819aeb@amd.com>
Date: Thu, 15 Jun 2017 09:59:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170615094111.wga334kg2bhxqib3@pd.tnic>
Content-Language: en-US
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 6/15/2017 4:41 AM, Borislav Petkov wrote:
> On Wed, Jun 14, 2017 at 03:40:28PM -0500, Tom Lendacky wrote:
>> I was trying to keep all the logic for it here in the SME related files
>> rather than put it in the iommu code itself. But it is easy enough to
>> move if you think it's worth it.
> 
> Yes please - the less needlessly global symbols, the better.

Ok.

> 
>>> Also, you said in another mail on this subthread that c->microcode
>>> is not yet set. Are you saying, that the iommu init gunk runs before
>>> init_amd(), where we do set c->microcode?
>>>
>>> If so, we can move the setting to early_init_amd() or so.
>>
>> I'll look into that.
> 
> And I don't think c->microcode is not set by the time we init the iommu
> because, AFAICT, we do the latter in pci_iommu_init() and that's a
> rootfs_initcall() which happens later then the CPU init stuff.

Actually the detection routine, amd_iommu_detect(), is part of the
IOMMU_INIT_FINISH macro support which is called early through mm_init()
from start_kernel() and that routine is called before init_amd().

> 
>> I'll look into simplifying the checks.
> 
> Something like this maybe?
> 
> 	if (rev >= 0x1205)
> 		return true;
> 
> 	if (rev <= 0x11ff && rev >= 0x1126)
> 		return true;
> 
> 	return false;

Yup, something like that.

> 
>>> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
>>> #134: FILE: drivers/iommu/amd_iommu.c:866:
>>> +static void build_completion_wait(struct iommu_cmd *cmd, volatile u64 *sem)
>>>
>>
>> The semaphore area is written to by the device so the use of volatile is
>> appropriate in this case.
> 
> Do you mean this is like the last exception case in that document above:
> 
> "
>    - Pointers to data structures in coherent memory which might be modified
>      by I/O devices can, sometimes, legitimately be volatile.  A ring buffer
>      used by a network adapter, where that adapter changes pointers to
>      indicate which descriptors have been processed, is an example of this
>      type of situation."
> 
> ?
> 
> If so, it did work fine until now, without the volatile. Why is it
> needed now, all of a sudden?

If you run checkpatch against the whole amd_iommu.c file you'll see that
same warning for the wait_on_sem() function.  The checkpatch warning
shows up now because I modified the build_completion_wait() function as
part of the support to use iommu_virt_to_phys().

Since I'm casting the arg to iommu_virt_to_phys() no matter what I can
avoid the signature change to the build_completion_wait() function and
avoid this confusion in the future.

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
