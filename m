Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlSH4-009mUq-3v
 for kexec@lists.infradead.org; Fri, 12 Nov 2021 08:51:07 +0000
Date: Fri, 12 Nov 2021 16:50:42 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v1] proc/vmcore: don't fake reading zeroes on surprise
 vmcore_cb unregistration
Message-ID: <20211112085042.GB19016@MiWiFi-R3L-srv>
References: <20211111192243.22002-1-david@redhat.com>
 <20211112033028.GP27625@MiWiFi-R3L-srv>
 <d8cd422d-54aa-8695-6563-a98b8a61c280@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d8cd422d-54aa-8695-6563-a98b8a61c280@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org

On 11/12/21 at 09:28am, David Hildenbrand wrote:
> On 12.11.21 04:30, Baoquan He wrote:
> > On 11/11/21 at 08:22pm, David Hildenbrand wrote:
> >> In commit cc5f2704c934 ("proc/vmcore: convert oldmem_pfn_is_ram callback
> >> to more generic vmcore callbacks"), we added detection of surprise
> >> vmcore_cb unregistration after the vmcore was already opened. Once
> >> detected, we warn the user and simulate reading zeroes from that point on
> >> when accessing the vmcore.
> >>
> >> The basic reason was that unexpected unregistration, for example, by
> >> manually unbinding a driver from a device after opening the
> >> vmcore, is not supported and could result in reading oldmem the
> >> vmcore_cb would have actually prohibited while registered. However,
> >> something like that can similarly be trigger by a user that's really
> >> looking for trouble simply by unbinding the relevant driver before opening
> >> the vmcore -- or by disallowing loading the driver in the first place.
> >> So it's actually of limited help.
> > 
> > Yes, this is the change what I would like to see in the original patch
> > "proc/vmcore: convert oldmem_pfn_is_ram callback to more generic vmcore callbacks".
> > I am happy with this patch appended to commit cc5f2704c934.
> 
> Good, thanks!
> 
> > 
> >>
> >> Currently, unregistration can only be triggered via virtio-mem when
> >> manually unbinding the driver from the device inside the VM; there is no
> >> way to trigger it from the hypervisor, as hypervisors don't allow for
> >> unplugging virtio-mem devices -- ripping out system RAM from a VM without
> >> coordination with the guest is usually not a good idea.
> >>
> >> The important part is that unbinding the driver and unregistering the
> >> vmcore_cb while concurrently reading the vmcore won't crash the system,
> >> and that is handled by the rwsem.
> >>
> >> To make the mechanism more future proof, let's remove the "read zero"
> >> part, but leave the warning in place. For example, we could have a future
> >> driver (like virtio-balloon) that will contact the hypervisor to figure out
> >> if we already populated a page for a given PFN. Hotunplugging such a device
> >> and consequently unregistering the vmcore_cb could be triggered from the
> >> hypervisor without harming the system even while kdump is running. In that
> > 
> > I am a little confused, could you tell more about "contact the hypervisor to
> > figure out if we already populated a page for a given PFN."? I think
> > vmcore dumping relies on the eflcorehdr which is created beforehand, and
> > relies on vmcore_cb registered in advance too, virtio-balloon could take
> > another way to interact with kdump to make sure the dumpable ram?
> 
> This is essentially what the XEN callback does: check if a PFN is
> actually populated in the hypervisor; if not, avoid reading it so we
> won't be faulting+populating a fresh/zero page in the hypervisor just to
> be able to dump it in the guest. But in the XEN world we usually simply
> rely on straight hypercalls, not glued to actual devices that can get
> hot(un)plugged.
> 
> Once you have some device that performs such checks instead that could
> get hotunplugged and unregister the vmcore_cb (and virtio-balloon is
> just one example), you would be able to trigger this.
> 
> As we're dealing with a moving target (hypervisor will populate pages as
> necessary once the old kernel accesses them), there isn't really a way
> to adjust this in the old kernel -- where we build the eflcorehdr. We
> could try to adjust the elfcorehdr in the new kernel, but that certainly
> opens up another can of worms.

Sounds a little magic, but should be do-able if want to. Thanks a lot
for these details.

> 
> But again, this is just an example to back the "future proof" claim
> because Dave was explicitly concerned about this situation.
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
