Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYVdb-0007AC-RH
 for kexec@lists.infradead.org; Tue, 12 May 2020 14:12:05 +0000
Date: Tue, 12 May 2020 22:11:48 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Discard loaded image on memory hotplug
Message-ID: <20200512141148.GL5029@MiWiFi-R3L-srv>
References: <20200501165701.24587-1-james.morse@arm.com>
 <40b07632-b044-d1cd-96a2-81eec3da93e7@redhat.com>
 <8736892l92.fsf@x220.int.ebiederm.org>
 <a1c162fe-74de-c5ca-dadf-d451e970fdea@redhat.com>
 <20200511112755.GB4922@MiWiFi-R3L-srv>
 <04c8edd0-5c67-3ba7-5f87-c16a47b2af5c@redhat.com>
 <20200512103402.GK5029@MiWiFi-R3L-srv>
 <265d463c-1b2f-ca97-391d-8d1f9d60f16a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <265d463c-1b2f-ca97-391d-8d1f9d60f16a@redhat.com>
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

On 05/12/20 at 12:54pm, David Hildenbrand wrote:
> >> kexec_load():
> >>
> >> 1. kexec-tools could have placed kexec images on memory that will be
> >> removed.
> >>
> >> 2. the memory map of the guest is stale (esp., might still contain
> >> hotunplugged memory). /sys/firmware/memmap and /proc/iomem will be
> >> updated, so kexec-tools can fix this up.
> > 
> > With my understanding, this is a corner case. Before James's last
> > patchset, I even hadn't realized this is a problem. Because we usually
> > load kexec image, next trigger a kexec rebooting. Wondering if James
> > just found out a potential issue, or he really met this problem. Surely,
> 
> Should be as easy as hotplugging a dimm, loading "kexec -c", unplugging
> the dimm, triggering "kexec -e" if I am not wrong.

Hmm, kexec rebooting is also one kind of rebooting, we may not want to
hot plug memory during that time. But, yes, just in case.

> 
> > we should fix it when have identified it, even though it's a corner
> > case.
> > 
> > And we suggested adding service of loading kexec to fix this. We
> > suggest this because kdump also need to recollect the memory regions
> > so that it can pass them into 2nd kernel and dump the newly added
> > memory region, or not dump the already removed memory region. 
> > Kdump kernel won't get problem during boot or running caused by the
> > hot added/removed memory as kexec kernel does, however, on failing to
> > achieve expected result, kdump and kexec have the same problem. I don't
> > see why kdump can be reloaded by memory adding/removing uevent triggering,
> > but kexec can't. If have to unload kexec image, does kdump image need
> > be unloaded?
> 
> I think that approach is racy and might easily trigger a crash when
> "kexec -e" is called at the wrong time during memory unplug. See below
> why kdump is different. Triggering unloading in the kernel does not
> conflict with that approach and even seems to fit into the picture, no?
> 
> 1. Memory gets hot(un)plugged
> 2. The kernel unloads the kexec image while processing the hot(un)plug
>    to make sure nothing will go wrong.
> 3. User space gets notified and triggers reloading of kexec.
> 
> That sounds like a sane approach to me, no? If there is no 3., nothing
> will break. If there is a "kexec -e" before 3 finished, nothing will
> break. As we discussed, we might be able to special-case
> kexec_file_load() and not unload, but simply fixup.
> 
> Note that kdump is slightly different. In case memory gets hotplugged
> and kdump is not reloaded, that memory will simply not get dumped. In
> case memory gets hotunplugged and kdump is not reloaded, that memory
> will be skipped by makedumpfile (realizes memory is gone when parsing
> the sparse sections, trying to find the memmap). In contrast to kexec,
> there is no kernel crash.
> 
> > 
> > Here my main concern is if it will complicate kexec code. While
> > reloading it via systemd service won't. No matther if it's making kexec
> > disable memory hotplug, or making memory hotplug disabling kexec, it
> > seems to couple kexec with other feature/subcomponent. Anyway, we have
> > added a kexec loading service, any memory adding/removing uevent will
> > trigger the reloading. This patch won't impact anything, even though
> > it doesn't make sense to us, so have no objection to this.
> 
> I don't consider unloading in the kernel a lot of complexity. And it
> seems to be the right thing to do to avoid crashes, especially if user
> space will not reload itself.
> 
> > 
> > Another thing is below patch. Another case of complicating kexec because
> > of specific use case, please feel free to help review and add comment.
> > I am wondering if we can make it in user space too. E.g for oracle DB,
> > we limit the memory allocation within the movable nodes for memory
> > hotplugging, we can also add memmap= or mem= to kexec-ed kernel to protect
> > those memory regions inside the nodes, then restore the data from the nodes.
> > Not sure if VM data can be put in MOVABLE zone only.
> > 
> > [RFC 00/43] PKRAM: Preserved-over-Kexec RAM
> 
> I've seen that patch set and it is on my todo list, not sure when I'll
> have time to look into it. From a quick glimpse, I had the feeling that
> it was not dealing with memory hot(un)plug, most probably because
> concurrent memory hot(un)plug is not the target use case.

Not, it's not about hot plug. Hope you can help check if restoring VM data in
kexec-ed kernel have to be done like that from virt dev's point of view.
Please feel free to add other virt expert you know who is familiar with that
to the list to help review.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
