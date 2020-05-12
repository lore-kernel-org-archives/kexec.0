Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYPbV-0000qe-87
 for kexec@lists.infradead.org; Tue, 12 May 2020 07:45:31 +0000
Subject: Re: [PATCH] kexec: Discard loaded image on memory hotplug
References: <20200501165701.24587-1-james.morse@arm.com>
 <40b07632-b044-d1cd-96a2-81eec3da93e7@redhat.com>
 <8736892l92.fsf@x220.int.ebiederm.org>
 <a1c162fe-74de-c5ca-dadf-d451e970fdea@redhat.com>
 <87h7wmtna1.fsf@x220.int.ebiederm.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4d5f69b6-fdfd-a461-0ac9-6d05636508f1@redhat.com>
Date: Tue, 12 May 2020 09:45:16 +0200
MIME-Version: 1.0
In-Reply-To: <87h7wmtna1.fsf@x220.int.ebiederm.org>
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

>>> Phrasing it that way is non-sense.  What is important is memory
>>> available in the system.  A memory map is just a reflection upon that,
>>> a memory map is not the definition of truth.
>>>
>>> So if this notifier reflects when memory is coming and going on the
>>> system this is a reasonable approach.  
>>>
>>> Do these notifiers might fire for special kinds of memory that should
>>> only be used for very special purposes?
>>>
>>> This change with the addition of some filters say to limit taking action
>>> to MEM_ONLINE and MEM_OFFLINE looks reasonable to me.  Probably also
>>> filtering out special kinds of memory that is not gernally useful.
>>
>> There are cases, where this notifier will not get called (e.g., hotplug
>> a DIMM and don't online it) or will get called, although nothing changed
>> (offline+re-online to a different zone triggered by user space). AFAIK,
>> nothing in kexec (*besides kdump) cares about online vs. offline memory.
>> This is why this feels wrong.
> 
> So what precisely does offline and online of memory mean in this context?
> Is it turning the memory on and off?  (which is the obvious meaning)
> Or is offline and online letting the ordinary kernel use a chunk
> of memory and not use a chunk of memory and the memory remains running
> the entire time?
> 

A DIMM is partitioned into fixed-size memory blocks. Each memory block
is represented in /sys/device/system/memory/memoryX/.

There, it can be onlined of offlined. onlining/offlining a memory block
simply defines
- if the memory will be used by the buddy
- how the memory will be used by the buddy (e.g., ZONE_NORMAL vs.
  ZONE_MOVABLE)
nothing else (esp. no hardware is switched on/off).

e.g.,

echo "online_movable" > /sys/devices/system/memory/memory9/state
echo "offline" > /sys/devices/system/memory/memory9/state
echo "online_kernel" > /sys/devices/system/memory/memory9/state

When hotplugging memory, all memory blocks are either onlined directly
from the kernel, or userspace has to do it manually via e.g., udev
rules. The latter is common is distributions.

Before hotunplugging memory, all memory blocks have to be offline. This
means
- memory was never onlined
- memory was offlined by user space manually
- memory will be offlined automatically when unplugging the dimm

Of course, offlining of some memory blocks might fail (esp. in case of
ZONE_NORMAL when they contain unmovable allocations). Then, the memory
cannot get hotunplugged.

The representation in /proc/iomem and /sys/firmware/memmap is
independent of the state (online/offline) of a memory block.

> 
>> add_memory()/try_remove_memory() is the place where:
>> - Memblocks are created/deleted (if the memblock allocator is still
>>   alive)
>> - Memory resources are created/deleted (e.g., reflected in /proc/iomem)
>> - Firmware memmap entries are created/deleted (/sys/firmware/memmap)
>>
>> My idea would be to add something like
>> kexec_map_add()/kexec_map_remove() where we have
>> firmware_map_add_hotplug()/firmware_map_remove(). From there, we can
>> unload the kexec image like done in this patch.
> 
> I don't see the connection with a firmware_map.  Maybe that is how it is
> thought about in the code but in principle the firmware can not exist
> or completely ignore memory hotplug.

The firmware_map callbacks simply update /sys/firmware/memmap in case
that interface is configured into the kernel (mostly x86 only), nothing
else. We just want similar callbacks to update kexec' representation.

> 
>> And these callbacks might come in handy for fixing up the kexec initial
>> memmap in case of kexec_file_load(). AFAIKS on x86_64:
> 
> Maybe we have enough information to fixup the loaded kexec image
> in the kexec_file_load case, we certainly don't in the ordinary
> kexec_load case.

Yes, that's also what I mentioned in my reply to Baoquan.

> 
> For now I want to stick to the simplest thing we can do which is either
> blocking the memory hotplug operation (if that is possible) or
> dropping the loaded kexec image.

Yes, the latter is the best for now. It's simple.

I am suggesting to add explicit callbacks to
add_memory()/remove_memory(), and calling the invalidation from there -
because I see various issues with the memory notifier approach (racy,
false positives, never called if memory is not onlined).

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
