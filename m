Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRBVd-0001x0-Me
 for kexec@lists.infradead.org; Wed, 22 Apr 2020 09:17:35 +0000
Date: Wed, 22 Apr 2020 17:17:18 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
Message-ID: <20200422091718.GT4247@MiWiFi-R3L-srv>
References: <ad060c8a-8afe-3858-0a4f-27ff54ef4c68@redhat.com>
 <20200414143912.GE4247@MiWiFi-R3L-srv>
 <0085f460-b0c7-b25f-36a7-fa3bafaab6fe@redhat.com>
 <20200415023524.GG4247@MiWiFi-R3L-srv>
 <18cf6afd-c651-25c7-aca3-3ca3c0e07547@redhat.com>
 <20200416140247.GA12723@MiWiFi-R3L-srv>
 <4e1546eb-4416-dc6d-d549-62d1cecccbc8@redhat.com>
 <20200416143634.GH4247@MiWiFi-R3L-srv>
 <2525cc9c-3566-6275-105b-7f4af8f980bc@redhat.com>
 <9a4eb1d7-33bf-8707-9c0c-1ca657c3e502@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9a4eb1d7-33bf-8707-9c0c-1ca657c3e502@redhat.com>
Content-Disposition: inline
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
Cc: piliu@redhat.com, Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>, linux-mm@kvack.org, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On 04/21/20 at 03:29pm, David Hildenbrand wrote:
> >> ACPI SRAT is embeded into efi, need read out the rsdp pointer. If we don't
> >> pass the efi, it won't get the SRAT table correctly, if I remember
> >> correctly. Yeah, I remeber kvm guest can get memory hotplugged with
> >> ACPI only, this won't happen on bare metal though. Need check carefully. 
> >> I have been using kvm guest with uefi firmwire recently.
> > 
> > Yeah, I can imagine that bare metal is different. kvm only uses ACPI.
> > 
> > I'm also asking because of virtio-mem. Memory added via virtio-mem is
> > not part of any efi tables or whatsoever. So I assume the kexec kernel
> > will not detect it automatically (good!), instead load the virtio-mem
> > driver and let it add memory back to the system.
> > 
> > I should probably play with kexec and virtio-mem once I have some spare
> > cycles ... to find out what's broken and needs to be addressed :)
> 
> FWIW, I just gave virtio-mem and kexec/kdump a try.
> 
> a) kdump seems to work. Memory added by virtio-mem is getting dumped.
> The kexec kernel only uses memory in the crash region. The virtio-mem
> driver properly bails out due to is_kdump_kernel().

Right, kdump is not impacted later added memory.

> 
> b) "kexec -s -l" seems to work fine. For now, the kernel does not seem
> to get placed on virtio-mem memory (pure luck due to the left-to-right
> search). Memory added by virtio-mem is not getting added to the e820
> map. Once the virtio-mem driver comes back up in the kexec kernel, the
> right memory is readded.

kexec_file_load just behaves as you tested. It doesn't collect later
added memory to e820 because it uses e820_table_kexec directly to pass
e820 to kexec-ed kernel. However, this e820_table_kexec is only updated
during boot stage. I tried hot adding DIMM after boot, kexec-ed kernel
doesn't have it in e820 during bootup, but it's recoginized and added
when ACPI scanning. I think we should update e820_table_kexec when hot
add/remove memory, at least for DIMM. Not sure if DLPAR, virtio-mem,
balloon will need be added into e820_table_kexec too, and if this is
expected behaviour.

But whatever we do, it won't impact the kexec file_loading, because of
the searching strategy bottom up. Just adding them into e820_table_kexec
will make it consistent with cold reboot which get recognizes and get
them into e820 during bootup.
> 
> c) "kexec -c -l" does not work properly. All memory added by virtio-mem
> is added to the e820 map, which is wrong. Memory that should not be
> touched will be touched by the kexec kernel. I assume kexec-tools just
> goes ahead and adds anything it can find in /proc/iomem (or
> /sys/firmware/memmap/) to the e820 map of the new kernel.
> 
> Due to c), I assume all hotplugged memory (e.g., ACPI DIMMs) is
> similarly added to the e820 map and, therefore, won't be able to be
> onlined MOVABLE easily.

Yes, kexec_load will read memory regions from /sys/firmware/memmap/ or
/proc/iomem. Making it right seems a little harder, we can export them
to /proc/iomem or /sys/firmware/memmap/ with mark them with 'hotplug',
but the attribute that which zone they belongs to is not easy to tell.

We are proactive on widely testing kexec_file_load on x86_64, s390,
arm64 by adding test cases into CKI.

> 
> 
> At least for virtio-mem, I would either have to
> a) Not support "kexec -c -l". A viable option if we would be planning on
> not supporting it either way in the long term. I could block this
> in-kernel somehow eventually.
> 
> b) Teach kexec-tools to leave virtio-mem added memory alone. E.g., by
> indicating it in /proc/iomem in a special way ("System RAM
> (hotplugged)"/"System RAM (virtio-mem)").
> 
> Baoquan, any opinion on that?
> 
> -- 
> Thanks,
> 
> David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
