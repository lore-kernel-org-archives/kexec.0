Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYSEs-0004vH-GN
 for kexec@lists.infradead.org; Tue, 12 May 2020 10:34:20 +0000
Date: Tue, 12 May 2020 18:34:02 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Discard loaded image on memory hotplug
Message-ID: <20200512103402.GK5029@MiWiFi-R3L-srv>
References: <20200501165701.24587-1-james.morse@arm.com>
 <40b07632-b044-d1cd-96a2-81eec3da93e7@redhat.com>
 <8736892l92.fsf@x220.int.ebiederm.org>
 <a1c162fe-74de-c5ca-dadf-d451e970fdea@redhat.com>
 <20200511112755.GB4922@MiWiFi-R3L-srv>
 <04c8edd0-5c67-3ba7-5f87-c16a47b2af5c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <04c8edd0-5c67-3ba7-5f87-c16a47b2af5c@redhat.com>
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
To: David Hildenbrand <david@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org

On 05/11/20 at 01:55pm, David Hildenbrand wrote:
> On 11.05.20 13:27, Baoquan He wrote:
> > On 05/11/20 at 10:19am, David Hildenbrand wrote:
> >> On 09.05.20 17:14, Eric W. Biederman wrote:
> >>>>> + * If the memory layout changes, any loaded kexec image should be evicted
> >>>>> + * as it may contain a copy of the (now stale) memory map. This also means
> >>>>> + * we don't need to check the memory is still present when re-assembling the
> >>>>> + * new kernel at machine_kexec() time.
> >>>>> + */
> >>>>
> >>>> Onlining/offlining is not a change of the memory map.
> >>>
> >>> Phrasing it that way is non-sense.  What is important is memory
> >>> available in the system.  A memory map is just a reflection upon that,
> >>> a memory map is not the definition of truth.
> >>>
> >>> So if this notifier reflects when memory is coming and going on the
> >>> system this is a reasonable approach.  
> >>>
> >>> Do these notifiers might fire for special kinds of memory that should
> >>> only be used for very special purposes?
> >>>
> >>> This change with the addition of some filters say to limit taking action
> >>> to MEM_ONLINE and MEM_OFFLINE looks reasonable to me.  Probably also
> >>> filtering out special kinds of memory that is not gernally useful.
> >>
> >> There are cases, where this notifier will not get called (e.g., hotplug
> >> a DIMM and don't online it) or will get called, although nothing changed
> >> (offline+re-online to a different zone triggered by user space). AFAIK,
> >> nothing in kexec (*besides kdump) cares about online vs. offline memory.
> >> This is why this feels wrong.
> >>
> >> add_memory()/try_remove_memory() is the place where:
> >> - Memblocks are created/deleted (if the memblock allocator is still
> >>   alive)
> >> - Memory resources are created/deleted (e.g., reflected in /proc/iomem)
> >> - Firmware memmap entries are created/deleted (/sys/firmware/memmap)
> >>
> >> My idea would be to add something like
> >> kexec_map_add()/kexec_map_remove() where we have
> >> firmware_map_add_hotplug()/firmware_map_remove(). From there, we can
> >> unload the kexec image like done in this patch.
> > 
> > Hi David,
> > 
> > I may miss some details, do you know why we have to unload the kexec image
> > when add/remove memory?
> > 
> > If this is applied, even kexec_file_load is also affected. As we
> > discussed, kexec_file_load is not impacted by kinds of memory
> > adding/removing at all.
> 
> kexec_load():
> 
> 1. kexec-tools could have placed kexec images on memory that will be
> removed.
> 
> 2. the memory map of the guest is stale (esp., might still contain
> hotunplugged memory). /sys/firmware/memmap and /proc/iomem will be
> updated, so kexec-tools can fix this up.

With my understanding, this is a corner case. Before James's last
patchset, I even hadn't realized this is a problem. Because we usually
load kexec image, next trigger a kexec rebooting. Wondering if James
just found out a potential issue, or he really met this problem. Surely,
we should fix it when have identified it, even though it's a corner
case.

And we suggested adding service of loading kexec to fix this. We
suggest this because kdump also need to recollect the memory regions
so that it can pass them into 2nd kernel and dump the newly added
memory region, or not dump the already removed memory region. 
Kdump kernel won't get problem during boot or running caused by the
hot added/removed memory as kexec kernel does, however, on failing to
achieve expected result, kdump and kexec have the same problem. I don't
see why kdump can be reloaded by memory adding/removing uevent triggering,
but kexec can't. If have to unload kexec image, does kdump image need
be unloaded?

Here my main concern is if it will complicate kexec code. While
reloading it via systemd service won't. No matther if it's making kexec
disable memory hotplug, or making memory hotplug disabling kexec, it
seems to couple kexec with other feature/subcomponent. Anyway, we have
added a kexec loading service, any memory adding/removing uevent will
trigger the reloading. This patch won't impact anything, even though
it doesn't make sense to us, so have no objection to this.

Another thing is below patch. Another case of complicating kexec because
of specific use case, please feel free to help review and add comment.
I am wondering if we can make it in user space too. E.g for oracle DB,
we limit the memory allocation within the movable nodes for memory
hotplugging, we can also add memmap= or mem= to kexec-ed kernel to protect
those memory regions inside the nodes, then restore the data from the nodes.
Not sure if VM data can be put in MOVABLE zone only.

[RFC 00/43] PKRAM: Preserved-over-Kexec RAM

> kexec_file_load():
> 
> 1. kexec could have placed kexec images on memory that will be removed,
> especially when kexec_locate_mem_hole() is called to locate memory top-down.
> 
> IIRC, the memory map might also be stale and I agree that unloading
> won't actually change something here (needs different fixes as I
> explained regarding the kexec e820 map). Think about unplugging a DIMM
> that was described in the e820 map during boot and was put into the
> MOVABLE zone using cmdline parameters like "movablecore". After unplug,
> it will still be described in the kexec e820 map.

Yes, this is a good catch. I thought to leave the e820_table_kexec
as is. As for the boot memory hotplug as you mentioned, it's a problem.
We can't tell kexec-ed kernel an unavailable region via e820. Once
updating e820_table_kexec, kexec_file_load will not be immune to
hotplugged memory any more. Otherwise the stale e820 map will pass to
kexec kernel, I haven't checked if it will impact system booting, will
check.

> 
> I agree that we might might be able to make smarter decisions in the
> kernel regarding kexec_file_load() - for example, try to find new
> locations for kexec images. For now, this seems to be simple.
> 
> > 
> > Besides, if unload image in casae memory added/removed, we will accept
> > that the later 'kexec -e' is actually rebooting?
> 
> At least in the kernel, kernel_kexec() will bail out in case there is no
> kexec_image loaded anymore. And we printed a message, so we can at least
> figure out what happened.
> 
> Where is this rebooting you mention performed in case there is no image
> loaded?

OK, I forgot it returned from reboot invocation w/o image loaded.

> 
> -- 
> Thanks,
> 
> David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
