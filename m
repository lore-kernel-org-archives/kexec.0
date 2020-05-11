Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jY6bR-0008SQ-Lz
 for kexec@lists.infradead.org; Mon, 11 May 2020 11:28:11 +0000
Date: Mon, 11 May 2020 19:27:55 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Discard loaded image on memory hotplug
Message-ID: <20200511112755.GB4922@MiWiFi-R3L-srv>
References: <20200501165701.24587-1-james.morse@arm.com>
 <40b07632-b044-d1cd-96a2-81eec3da93e7@redhat.com>
 <8736892l92.fsf@x220.int.ebiederm.org>
 <a1c162fe-74de-c5ca-dadf-d451e970fdea@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a1c162fe-74de-c5ca-dadf-d451e970fdea@redhat.com>
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
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

On 05/11/20 at 10:19am, David Hildenbrand wrote:
> On 09.05.20 17:14, Eric W. Biederman wrote:
> >>> + * If the memory layout changes, any loaded kexec image should be evicted
> >>> + * as it may contain a copy of the (now stale) memory map. This also means
> >>> + * we don't need to check the memory is still present when re-assembling the
> >>> + * new kernel at machine_kexec() time.
> >>> + */
> >>
> >> Onlining/offlining is not a change of the memory map.
> > 
> > Phrasing it that way is non-sense.  What is important is memory
> > available in the system.  A memory map is just a reflection upon that,
> > a memory map is not the definition of truth.
> > 
> > So if this notifier reflects when memory is coming and going on the
> > system this is a reasonable approach.  
> > 
> > Do these notifiers might fire for special kinds of memory that should
> > only be used for very special purposes?
> > 
> > This change with the addition of some filters say to limit taking action
> > to MEM_ONLINE and MEM_OFFLINE looks reasonable to me.  Probably also
> > filtering out special kinds of memory that is not gernally useful.
> 
> There are cases, where this notifier will not get called (e.g., hotplug
> a DIMM and don't online it) or will get called, although nothing changed
> (offline+re-online to a different zone triggered by user space). AFAIK,
> nothing in kexec (*besides kdump) cares about online vs. offline memory.
> This is why this feels wrong.
> 
> add_memory()/try_remove_memory() is the place where:
> - Memblocks are created/deleted (if the memblock allocator is still
>   alive)
> - Memory resources are created/deleted (e.g., reflected in /proc/iomem)
> - Firmware memmap entries are created/deleted (/sys/firmware/memmap)
> 
> My idea would be to add something like
> kexec_map_add()/kexec_map_remove() where we have
> firmware_map_add_hotplug()/firmware_map_remove(). From there, we can
> unload the kexec image like done in this patch.

Hi David,

I may miss some details, do you know why we have to unload the kexec image
when add/remove memory?

If this is applied, even kexec_file_load is also affected. As we
discussed, kexec_file_load is not impacted by kinds of memory
adding/removing at all.

Besides, if unload image in casae memory added/removed, we will accept
that the later 'kexec -e' is actually rebooting?

Thanks
Baoquan

> 
> And these callbacks might come in handy for fixing up the kexec initial
> memmap in case of kexec_file_load(). AFAIKS on x86_64:
> - Hotplugging a DIMM will not add that memory to
>   e820_table_kexec
> - Hotunplugging a DIMM will not remove that memory from e820_table_kexec
> 
> Maybe we have similar things to handle on other architectures.
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
