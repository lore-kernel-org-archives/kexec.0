Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
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
Date: Tue, 21 Apr 2020 08:59:27 -0500
In-Reply-To: <9a4eb1d7-33bf-8707-9c0c-1ca657c3e502@redhat.com> (David
 Hildenbrand's message of "Tue, 21 Apr 2020 15:29:37 +0200")
Message-ID: <87a735548w.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
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
To: David Hildenbrand <david@redhat.com>
Cc: piliu@redhat.com, Baoquan He <bhe@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

David Hildenbrand <david@redhat.com> writes:

>>> ACPI SRAT is embeded into efi, need read out the rsdp pointer. If we don't
>>> pass the efi, it won't get the SRAT table correctly, if I remember
>>> correctly. Yeah, I remeber kvm guest can get memory hotplugged with
>>> ACPI only, this won't happen on bare metal though. Need check carefully. 
>>> I have been using kvm guest with uefi firmwire recently.
>> 
>> Yeah, I can imagine that bare metal is different. kvm only uses ACPI.
>> 
>> I'm also asking because of virtio-mem. Memory added via virtio-mem is
>> not part of any efi tables or whatsoever. So I assume the kexec kernel
>> will not detect it automatically (good!), instead load the virtio-mem
>> driver and let it add memory back to the system.
>> 
>> I should probably play with kexec and virtio-mem once I have some spare
>> cycles ... to find out what's broken and needs to be addressed :)
>
> FWIW, I just gave virtio-mem and kexec/kdump a try.
>
> a) kdump seems to work. Memory added by virtio-mem is getting dumped.
> The kexec kernel only uses memory in the crash region. The virtio-mem
> driver properly bails out due to is_kdump_kernel().
>
> b) "kexec -s -l" seems to work fine. For now, the kernel does not seem
> to get placed on virtio-mem memory (pure luck due to the left-to-right
> search). Memory added by virtio-mem is not getting added to the e820
> map. Once the virtio-mem driver comes back up in the kexec kernel, the
> right memory is readded.

This sounds like a bug.

> c) "kexec -c -l" does not work properly. All memory added by virtio-mem
> is added to the e820 map, which is wrong. Memory that should not be
> touched will be touched by the kexec kernel. I assume kexec-tools just
> goes ahead and adds anything it can find in /proc/iomem (or
> /sys/firmware/memmap/) to the e820 map of the new kernel.
>
> Due to c), I assume all hotplugged memory (e.g., ACPI DIMMs) is
> similarly added to the e820 map and, therefore, won't be able to be
> onlined MOVABLE easily.

This sounds like correct behavior to me.  If you add memory to the
system it is treated as memory to the system.

If we need to make it a special kind of memory with special rules we can
have some kind of special marking for the memory.  But hotplugged is not
in itself a sufficient criteria to say don't use this as normal memory.

If take a huge server and I plug in an extra dimm it is just memory.

For a similarly huge server I might want to have memory that the system
booted with unpluggable, in case hardware error reporting notices
a dimm generating a lot of memory errors.

Now perhaps virtualization needs a special tier of memory that should
only be used for cases where the memory is easily movable.

I am not familiar with virtio-mem but my skim of the initial design
is that virtio-mem was not designed to be such a special tier of memory.
Perhaps something has changed?
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03870.html


> At least for virtio-mem, I would either have to
> a) Not support "kexec -c -l". A viable option if we would be planning on
> not supporting it either way in the long term. I could block this
> in-kernel somehow eventually.

No.

> b) Teach kexec-tools to leave virtio-mem added memory alone. E.g., by
> indicating it in /proc/iomem in a special way ("System RAM
> (hotplugged)"/"System RAM (virtio-mem)").

How does the kernel memory allocator treat this memory?

The logic is simple.  If the kernel memory allocator treats that memory
as ordinary memory available for all uses it should be presented as
ordinary memory available for all uses.

If the kernel memory allocator treats that memory as special memory
only available for uses that we can easily free later and give back to
the system.  AKA it is special and not oridinary memory we should mark
it as such.

Eric

p.s.  Please excuse me for jumping in I may be missing some important
context, but what I read when I saw this message in my inbox just seemed
very wrong.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
