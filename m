Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jY3fN-0006Q6-9O
 for kexec@lists.infradead.org; Mon, 11 May 2020 08:20:04 +0000
Subject: Re: [PATCH] kexec: Discard loaded image on memory hotplug
References: <20200501165701.24587-1-james.morse@arm.com>
 <40b07632-b044-d1cd-96a2-81eec3da93e7@redhat.com>
 <8736892l92.fsf@x220.int.ebiederm.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a1c162fe-74de-c5ca-dadf-d451e970fdea@redhat.com>
Date: Mon, 11 May 2020 10:19:46 +0200
MIME-Version: 1.0
In-Reply-To: <8736892l92.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

On 09.05.20 17:14, Eric W. Biederman wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 01.05.20 18:57, James Morse wrote:
>>> On x86, the kexec payload contains a copy of the current memory map.
>>> If memory is added or removed, this copy of the memory map becomes
>>> stale. Getting this wrong may prevent the next kernel from booting.
>>> The first kernel may die if it tries to re-assemble the next kernel
>>> in memory that has been removed.
>>>
>>> Discard the loaded kexec image when the memory map changes, user-space
>>> should reload it.
>>>
>>> Kdump is unaffected, as it is placed within the crashkernel reserved
>>> memory area and only uses this memory. The stale memory map may affect
>>> generation of the vmcore, but the kdump kernel should be in a position
>>> to validate it.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> ---
>>> This patch obsoletes:
>>>  * kexec/memory_hotplug: Prevent removal and accidental use
>>> https://lore.kernel.org/linux-arm-kernel/20200326180730.4754-1-james.morse@arm.com/
>>>
>>>  kernel/kexec_core.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 40 insertions(+)
>>>
>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>> index c19c0dad1ebe..e1901e5bd4b5 100644
>>> --- a/kernel/kexec_core.c
>>> +++ b/kernel/kexec_core.c
>>> @@ -12,6 +12,7 @@
>>>  #include <linux/slab.h>
>>>  #include <linux/fs.h>
>>>  #include <linux/kexec.h>
>>> +#include <linux/memory.h>
>>>  #include <linux/mutex.h>
>>>  #include <linux/list.h>
>>>  #include <linux/highmem.h>
>>> @@ -22,10 +23,12 @@
>>>  #include <linux/elf.h>
>>>  #include <linux/elfcore.h>
>>>  #include <linux/utsname.h>
>>> +#include <linux/notifier.h>
>>>  #include <linux/numa.h>
>>>  #include <linux/suspend.h>
>>>  #include <linux/device.h>
>>>  #include <linux/freezer.h>
>>> +#include <linux/pfn.h>
>>>  #include <linux/pm.h>
>>>  #include <linux/cpu.h>
>>>  #include <linux/uaccess.h>
>>> @@ -1219,3 +1222,40 @@ void __weak arch_kexec_protect_crashkres(void)
>>>  
>>>  void __weak arch_kexec_unprotect_crashkres(void)
>>>  {}
>>> +
>>> +/*
>>> + * If the memory layout changes, any loaded kexec image should be evicted
>>> + * as it may contain a copy of the (now stale) memory map. This also means
>>> + * we don't need to check the memory is still present when re-assembling the
>>> + * new kernel at machine_kexec() time.
>>> + */
>>
>> Onlining/offlining is not a change of the memory map.
> 
> Phrasing it that way is non-sense.  What is important is memory
> available in the system.  A memory map is just a reflection upon that,
> a memory map is not the definition of truth.
> 
> So if this notifier reflects when memory is coming and going on the
> system this is a reasonable approach.  
> 
> Do these notifiers might fire for special kinds of memory that should
> only be used for very special purposes?
> 
> This change with the addition of some filters say to limit taking action
> to MEM_ONLINE and MEM_OFFLINE looks reasonable to me.  Probably also
> filtering out special kinds of memory that is not gernally useful.

There are cases, where this notifier will not get called (e.g., hotplug
a DIMM and don't online it) or will get called, although nothing changed
(offline+re-online to a different zone triggered by user space). AFAIK,
nothing in kexec (*besides kdump) cares about online vs. offline memory.
This is why this feels wrong.

add_memory()/try_remove_memory() is the place where:
- Memblocks are created/deleted (if the memblock allocator is still
  alive)
- Memory resources are created/deleted (e.g., reflected in /proc/iomem)
- Firmware memmap entries are created/deleted (/sys/firmware/memmap)

My idea would be to add something like
kexec_map_add()/kexec_map_remove() where we have
firmware_map_add_hotplug()/firmware_map_remove(). From there, we can
unload the kexec image like done in this patch.

And these callbacks might come in handy for fixing up the kexec initial
memmap in case of kexec_file_load(). AFAIKS on x86_64:
- Hotplugging a DIMM will not add that memory to
  e820_table_kexec
- Hotunplugging a DIMM will not remove that memory from e820_table_kexec

Maybe we have similar things to handle on other architectures.

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
