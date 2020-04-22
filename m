Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200326180730.4754-1-james.morse@arm.com>
 <87sgh4h4r7.fsf@x220.int.ebiederm.org>
 <59b74cc5-89aa-83fa-5532-8e64d6382fdd@arm.com>
Date: Wed, 22 Apr 2020 08:04:21 -0500
In-Reply-To: <59b74cc5-89aa-83fa-5532-8e64d6382fdd@arm.com> (James Morse's
 message of "Wed, 22 Apr 2020 13:14:10 +0100")
Message-ID: <87a7333c4q.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] kexec/memory_hotplug: Prevent removal and accidental
 use
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
To: James Morse <james.morse@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

James Morse <james.morse@arm.com> writes:

> Hi Eric,
>
> On 15/04/2020 21:29, Eric W. Biederman wrote:
>> James Morse <james.morse@arm.com> writes:
>> 
>>> Hello!
>>>
>>> arm64 recently queued support for memory hotremove, which led to some
>>> new corner cases for kexec.
>>>
>>> If the kexec segments are loaded for a removable region, that region may
>>> be removed before kexec actually occurs. This causes the first kernel to
>>> lockup when applying the relocations. (I've triggered this on x86 too).
>>>
>>> The first patch adds a memory notifier for kexec so that it can refuse
>>> to allow in-use regions to be taken offline.
>>>
>>>
>>> This doesn't solve the problem for arm64, where the new kernel must
>>> initially rely on the data structures from the first boot to describe
>>> memory. These don't describe hotpluggable memory.
>>> If kexec places the kernel in one of these regions, it must also provide
>>> a DT that describes the region in which the kernel was mapped as memory.
>>> (and somehow ensure its always present in the future...)
>>>
>>> To prevent this from happening accidentally with unaware user-space,
>>> patches two and three allow arm64 to give these regions a different
>>> name.
>>>
>>> This is a change in behaviour for arm64 as memory hotadd and hotremove
>>> were added separately.
>>>
>>>
>>> I haven't tried kdump.
>>> Unaware kdump from user-space probably won't describe the hotplug
>>> regions if the name is different, which saves us from problems if
>>> the memory is no longer present at kdump time, but means the vmcore
>>> is incomplete.
>>>
>>>
>>> These patches are based on arm64's for-next/core branch, but can all
>>> be merged independently.
>> 
>> So I just looked through these quickly and I think there are real
>> problems here we can fix, and that are worth fixing.
>> 
>> However I am not thrilled with the fixes you propose.
>
> Sure. Unfortunately /proc/iomem is the only trick arm64 has to keep the existing
> kexec-tools working.
> (We've had 'unthrilling' patches like this before to prevent user-space from loading the
> kernel over the top of the in-memory firmware tables.)
>
> arm64 expects the description of memory to come from firmware, be that UEFI for memory
> present at boot, or the ACPI AML methods for memory that was added
> later.
>
> On arm64 there is no standard location for memory. The kernel has to be handed a pointer
> to the firmware tables that describe it. The kernel expects to boot from memory that was
> present at boot.

What do you do when the firmware is wrong?  Does arm64 support the
mem=xxx@yyy kernel command line options?

If you want to handle the general case of memory hotplug having a
limitation that you have to boot from memory that was present at boot is
a bug, because the memory might not be there.

> Modifying the firmware tables at runtime doesn't solve the problem as we may need to move
> the firmware-reserved memory region that describes memory. User-space may still load and
> kexec either side of that update.
>
> Even if we could modify the structures at runtime, we can't update a loaded kexec image.
> We have no idea which blob from userspace is the DT. It may not even be linux that has
> been loaded.

What can be done and very reasonably so is on memory hotplug:
- Unloaded any loaded kexec image.
- Block loading any new image until the hotplug operation completes.

That is simple and generic, and can be done for all architectures.

This doesn't apply to kexec on panic kernel because it fundamentally
needs to figure out how to limp along (or reliably stop) when it has the
wrong memory map.

> We can't emulate parts of UEFI's handover because kexec's purgatory
> isn't an EFI program.

Plus much of EFI is unusable after ExitBootServices is called.

> I can't see a path through all this. If we have to modify existing user-space, I'd rather
> leave it broken. We can detect the problem in the arch code and print a warning at load time.

The weirdest thing to me in all of this is that you have been wanting to
handle memory hotplug.  But you don't want to change or deal with the
memory map changing when hotplug occurs.  The memory map changing is
fundamentally memory hotplug does.

So I think it is fundamental to figure out how to pass the updated
memory map.  Either through command line mem=xxx@yyy command line
options or through another option.

If you really want to keep the limitation that you have to have the
kernel in the initial memory map you can compare that map to the
efi tables when selecting the load address.

Expecting userspace to reload the loaded kernel after memory hotplug is
completely reasonable.

Unless I am mistaken memory hotplug is expected to be a rare event not
something that happens every day, certainly not something that happens
every minute.

Eric



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
