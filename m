Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOXtq-0004XF-VL
 for kexec@lists.infradead.org; Wed, 15 Apr 2020 02:35:40 +0000
Date: Wed, 15 Apr 2020 10:35:24 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
Message-ID: <20200415023524.GG4247@MiWiFi-R3L-srv>
References: <20200412080836.GM25745@shell.armlinux.org.uk>
 <87wo6klbw0.fsf@x220.int.ebiederm.org>
 <20200413023701.GA20265@MiWiFi-R3L-srv>
 <871rorjzmc.fsf@x220.int.ebiederm.org>
 <20200414064031.GB4247@MiWiFi-R3L-srv>
 <86e96214-7053-340b-5c1a-ff97fb94d8e0@redhat.com>
 <20200414092201.GD4247@MiWiFi-R3L-srv>
 <ad060c8a-8afe-3858-0a4f-27ff54ef4c68@redhat.com>
 <20200414143912.GE4247@MiWiFi-R3L-srv>
 <0085f460-b0c7-b25f-36a7-fa3bafaab6fe@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0085f460-b0c7-b25f-36a7-fa3bafaab6fe@redhat.com>
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

On 04/14/20 at 04:49pm, David Hildenbrand wrote:
> >>>>> The root cause is kexec-ed kernel is targeted at hotpluggable memory
> >>>>> region. Just avoiding the movable area can fix it. In kexec_file_load(),
> >>>>> just checking or picking those unmovable region to put kernel/initrd in
> >>>>> function locate_mem_hole_callback() can fix it. The page or pageblock's
> >>>>> zone is movable or not, it's easy to know. This fix doesn't need to
> >>>>> bother other component.
> >>>>
> >>>> I don't fully agree. E.g., just because memory is onlined to ZONE_NORMAL
> >>>> does not imply that it cannot get offlined and removed e.g., this is
> >>>> heavily used on ppc64, with 16MB sections.
> >>>
> >>> Really? I just know there are two kinds of mem hoplug in ppc, but don't
> >>> know the details. So in this case, is there any flag or a way to know
> >>> those memory block are hotpluggable? I am curious how those kernel data
> >>> is avoided to be put in this area. Or ppc just freely uses it for kernel
> >>> data or user space data, then try to migrate when hot remove?
> >>
> >> See
> >> arch/powerpc/platforms/pseries/hotplug-memory.c:dlpar_memory_remove_by_count()
> >>
> >> Under DLAPR, it can remove memory in LMB granularity, which is usually
> >> 16MB (== single section on ppc64). DLPAR will directly online all
> >> hotplugged memory (LMBs) from the kernel using device_online(), which
> >> will go to ZONE_NORMAL.
> >>
> >> When trying to remove memory, it simply scans for offlineable 16MB
> >> memory blocks (==section == LMB), offlines and removes them. No need for
> >> the movable zone and all the involved issues.
> > 
> > Yes, this is a different one, thanks for pointing it out. It sounds like
> > balloon driver in virt platform, doesn't it?
> 
> With DLPAR there is a hypervisor involved (which manages the actual HW
> DIMMs), so yes.
> 
> > 
> > Avoiding to put kexec kernel into movable zone can't solve this DLPAR
> > case as you said.
> > 
> >>
> >> Now, the interesting question is, can we have LMBs added during boot
> >> (not via add_memory()), that will later be removed via remove_memory().
> >> IIRC, we had BUGs related to that, so I think yes. If a section contains
> >> no unmovable allocations (after boot), it can get removed.
> > 
> > I do want to ask this question. If we can add LMB into system RAM, then
> > reload kexec can solve it. 
> > 
> > Another better way is adding a common function to filter out the
> > movable zone when search position for kexec kernel, use a arch specific
> > funciton to filter out DLPAR memory blocks for ppc only. Over there,
> > we can simply use for_each_drmem_lmb() to do that.
> 
> I was thinking about something similar. Maybe something like a notifier
> that can be used to test if selected memory can be used for kexec

Not sure if I get the notifier idea clearly. If you mean 

1) Add a common function to pick memory in unmovable zone;
2) Let DLPAR, balloon register with notifier;
3) In the common function, ask notified part to check if the picked
   unmovable memory is available for locating kexec kernel;

Sounds doable to me, and not complicated.

> images. It would apply to
> 
> - arm64 and filter out all hotadded memory (IIRC, only boot memory can
>   be used).

Do you mean hot added memory after boot can't be recognized and added
into system RAM on arm64?


> - powerpc to filter out all LMBs that can be removed (assuming not all
>   memory corresponds to LMBs that can be removed, otherwise we're in
>   trouble ... :) )
> - virtio-mem to filter out all memory it added.
> - hyper-v to filter out partially backed memory blocks (esp. the last
>   memory block it added and only partially backed it by memory).
> 
> This would make it work for kexec_file_load(), however, I do wonder how
> we would want to approach that from userspace kexec-tools when handling
> it from kexec_load().

Let's make kexec_file_load work firstly. Since this work is only first
step to make kexec-ed kernel not break memory hotplug. After kexec
rebooting, the KASLR may locate kernel into hotpluggable area too.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
