Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQtvH-0005nr-5P
 for kexec@lists.infradead.org; Tue, 21 Apr 2020 14:30:53 +0000
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
References: <20200414064031.GB4247@MiWiFi-R3L-srv>
 <86e96214-7053-340b-5c1a-ff97fb94d8e0@redhat.com>
 <20200414092201.GD4247@MiWiFi-R3L-srv>
 <ad060c8a-8afe-3858-0a4f-27ff54ef4c68@redhat.com>
 <20200414143912.GE4247@MiWiFi-R3L-srv>
 <0085f460-b0c7-b25f-36a7-fa3bafaab6fe@redhat.com>
 <20200415023524.GG4247@MiWiFi-R3L-srv>
 <18cf6afd-c651-25c7-aca3-3ca3c0e07547@redhat.com>
 <20200416140247.GA12723@MiWiFi-R3L-srv>
 <4e1546eb-4416-dc6d-d549-62d1cecccbc8@redhat.com>
 <20200416143634.GH4247@MiWiFi-R3L-srv>
 <2525cc9c-3566-6275-105b-7f4af8f980bc@redhat.com>
 <9a4eb1d7-33bf-8707-9c0c-1ca657c3e502@redhat.com>
 <87a735548w.fsf@x220.int.ebiederm.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <967575b4-01bc-b073-5b75-daa4d449a98d@redhat.com>
Date: Tue, 21 Apr 2020 16:30:18 +0200
MIME-Version: 1.0
In-Reply-To: <87a735548w.fsf@x220.int.ebiederm.org>
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
Cc: piliu@redhat.com, Baoquan He <bhe@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org


>> b) "kexec -s -l" seems to work fine. For now, the kernel does not seem
>> to get placed on virtio-mem memory (pure luck due to the left-to-right
>> search). Memory added by virtio-mem is not getting added to the e820
>> map. Once the virtio-mem driver comes back up in the kexec kernel, the
>> right memory is readded.
> 
> This sounds like a bug.

This is how virtio-mem wants its memory to get handled.

> 
>> c) "kexec -c -l" does not work properly. All memory added by virtio-mem
>> is added to the e820 map, which is wrong. Memory that should not be
>> touched will be touched by the kexec kernel. I assume kexec-tools just
>> goes ahead and adds anything it can find in /proc/iomem (or
>> /sys/firmware/memmap/) to the e820 map of the new kernel.
>>
>> Due to c), I assume all hotplugged memory (e.g., ACPI DIMMs) is
>> similarly added to the e820 map and, therefore, won't be able to be
>> onlined MOVABLE easily.
> 
> This sounds like correct behavior to me.  If you add memory to the
> system it is treated as memory to the system.

Yeah, I would agree if we are talking about DIMMs, but this memory is
special. It's added via a paravirtualized interface and will contain
holes, especially after unplug. While memory in these holes can usually
be read, it should not be written. More on that below.

> 
> If we need to make it a special kind of memory with special rules we can
> have some kind of special marking for the memory.  But hotplugged is not
> in itself a sufficient criteria to say don't use this as normal memory.

Agreed. It is special, though.

> 
> If take a huge server and I plug in an extra dimm it is just memory.

Agreed.

[...]

> 
> Now perhaps virtualization needs a special tier of memory that should
> only be used for cases where the memory is easily movable.
> 
> I am not familiar with virtio-mem but my skim of the initial design
> is that virtio-mem was not designed to be such a special tier of memory.
> Perhaps something has changed?
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03870.html

Yes, a lot changed. See
https://lkml.kernel.org/r/20200311171422.10484-1-david@redhat.com for
the latest-greatest design overview.


> 
>> b) Teach kexec-tools to leave virtio-mem added memory alone. E.g., by
>> indicating it in /proc/iomem in a special way ("System RAM
>> (hotplugged)"/"System RAM (virtio-mem)").
> 
> How does the kernel memory allocator treat this memory?

So what virtio-mem does is add memory sections on demand and populate
within these sections the requested amount of memory. E.g., if 64MB are
requested, it will add a 128MB section/resource but only make the first
64MB accessible (via the hypervisor) and only give the first 64MB to the
buddy. This way of adding memory is similar to what XEN and hypver-v
balloon drivers do when hotplugging memory.

When requested to plug more memory, it might go ahead and make (parts
of) the remaining 64MB accessible and give them to the buddy. In case it
cannot "fill any holes", it will add a new section.

When requested to unplug memory, it will try to remove memory from the
added (here 64MB) memory from the buddy and tell the hypervisor about it.

So, it has some similarity to ballooning in virtual environment,
however, it manages its own device memory only and can therefore give
better guarantees and detect malicious guests.

Right now, I think the right approach would be to not create
/sys/firmware/memmap entries from memory virtio-mem added.

[...]

> 
> p.s.  Please excuse me for jumping in I may be missing some important
> context, but what I read when I saw this message in my inbox just seemed
> very wrong.

Yeah, still, thanks for having a look. Please let me know if you need
more information.

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
