Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jY71d-0005bM-Vm
 for kexec@lists.infradead.org; Mon, 11 May 2020 11:55:15 +0000
Subject: Re: [PATCH] kexec: Discard loaded image on memory hotplug
References: <20200501165701.24587-1-james.morse@arm.com>
 <40b07632-b044-d1cd-96a2-81eec3da93e7@redhat.com>
 <8736892l92.fsf@x220.int.ebiederm.org>
 <a1c162fe-74de-c5ca-dadf-d451e970fdea@redhat.com>
 <20200511112755.GB4922@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Message-ID: <04c8edd0-5c67-3ba7-5f87-c16a47b2af5c@redhat.com>
Date: Mon, 11 May 2020 13:55:02 +0200
MIME-Version: 1.0
In-Reply-To: <20200511112755.GB4922@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

On 11.05.20 13:27, Baoquan He wrote:
> On 05/11/20 at 10:19am, David Hildenbrand wrote:
>> On 09.05.20 17:14, Eric W. Biederman wrote:
>>>>> + * If the memory layout changes, any loaded kexec image should be evicted
>>>>> + * as it may contain a copy of the (now stale) memory map. This also means
>>>>> + * we don't need to check the memory is still present when re-assembling the
>>>>> + * new kernel at machine_kexec() time.
>>>>> + */
>>>>
>>>> Onlining/offlining is not a change of the memory map.
>>>
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
>>
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
> Hi David,
> 
> I may miss some details, do you know why we have to unload the kexec image
> when add/remove memory?
> 
> If this is applied, even kexec_file_load is also affected. As we
> discussed, kexec_file_load is not impacted by kinds of memory
> adding/removing at all.

kexec_load():

1. kexec-tools could have placed kexec images on memory that will be
removed.

2. the memory map of the guest is stale (esp., might still contain
hotunplugged memory). /sys/firmware/memmap and /proc/iomem will be
updated, so kexec-tools can fix this up.


kexec_file_load():

1. kexec could have placed kexec images on memory that will be removed,
especially when kexec_locate_mem_hole() is called to locate memory top-down.

IIRC, the memory map might also be stale and I agree that unloading
won't actually change something here (needs different fixes as I
explained regarding the kexec e820 map). Think about unplugging a DIMM
that was described in the e820 map during boot and was put into the
MOVABLE zone using cmdline parameters like "movablecore". After unplug,
it will still be described in the kexec e820 map.

I agree that we might might be able to make smarter decisions in the
kernel regarding kexec_file_load() - for example, try to find new
locations for kexec images. For now, this seems to be simple.

> 
> Besides, if unload image in casae memory added/removed, we will accept
> that the later 'kexec -e' is actually rebooting?

At least in the kernel, kernel_kexec() will bail out in case there is no
kexec_image loaded anymore. And we printed a message, so we can at least
figure out what happened.

Where is this rebooting you mention performed in case there is no image
loaded?

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
