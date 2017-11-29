Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eJsLW-0007X9-0d
 for kexec@lists.infradead.org; Wed, 29 Nov 2017 02:43:36 +0000
Date: Wed, 29 Nov 2017 10:43:07 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171129024307.GE15074@x1>
References: <20171103172822.4ty6yjhewroe4z4j@dwarf.suse.cz>
 <20171106024143.GA3669@x1>
 <20171106090155.p7jhe2m57whfxma3@dwarf.suse.cz>
 <20171106092729.GB3669@x1>
 <20171106095638.7iwlyjmlom3tqelt@dwarf.suse.cz>
 <20171107113956.GC3669@x1>
 <20171107134212.tmjdt7rdailtbosa@dwarf.suse.cz>
 <20171107153428.ex27nwkvelhm2nm7@dwarf.suse.cz>
 <20171112080426.GB6429@x1>
 <20171128215833.hhcjvn5qjfc3bdrk@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171128215833.hhcjvn5qjfc3bdrk@dwarf.suse.cz>
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
To: Jiri Bohac <jbohac@suse.cz>
Cc: Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, yinghai@kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 11/28/17 at 10:58pm, Jiri Bohac wrote:
> Hi Baoquan,
> 
> On Sun, Nov 12, 2017 at 04:04:26PM +0800, Baoquan He wrote:
> > Solution:
> > 1) Remove the code which support GART IOMMU when it's not enabled in
> > BIOS. This has been done in the new generation of hardware IOMMU like
> > intel vt-d IOMMU and amd-Vi IOMMU. We should not make GART IOMMU be
> > exceptional.
> 
> Wouldn't this break old machines with actual AGP and
> misconfigured/bugg BIOSes? Wasn't that the reason why we have the
> workaround of mapping the hole over real memory?

Hmm, a quick question, does it work when GART support is enabled in
bios? In intel vt-d and amd-vi iommu, if user doesn't enable it in bios,
the functionality will be disabled in kernel, why would we not do that
for GART IOMMU? and why is GART so special?

GART could be the only feature in kernel I saw which bios option is not
enabled but still get supported. Doesn't it look very weird?

>  
> > 2) Remove those pages from mm subsystem since they are not seen any more
> > though they have been added into mm subsystem, because CPU can't see
> > them.
> 
> not exactly sure I understand this... they are reserved by the
> memblock allocater, thus preventing any further use by any mm
> code.

Many kernel pages are reverved from memblock, why can you still read
their content?

> 
> > 3) Remove the apreture region from /proc/iomem so that pages in that
> > region can't be seen by kdump kernel. This is easier, but just a work
> > around.
> 
> I like this idea, but won't this cause pci_claim_resource() fail
> after the call to pci_find_parent_resource() ? See my previous
> mail.

Not very sure, now have not time to investigate why it cause failure.

I tried to find a system with GART in our lab, but failed. Those
machines are too old, at least in redhat I never heard complain about
it. If have a easy fix, worth to have a try. otherwise, may just better
to leave it as is. That's why I suggested the 1st choice, and also the
work around code is too quirky if GART bios is not enabled.

> 
> 
> Bad thing is, we don't want to break random old AGP hardware, but
> at the same time, it's now too rare to properly test this.
> 
> So wouldn't it be better to fix the problem at least for the
> kexec_file case using my original patch?
> 
> A possible hack for the old kexec syscall might be to
> make /proc/iomem list the "GART" region without it being present in
> the iomem resource database. kexec-tools has working code to deal with
> the GART region, but the kernel no longer includes it in
> /proc/iomem.
> 
> Or maybe a cleaner solution than special-casing the "GART" region
> into /proc/iomem would be to introduce a new type of iomem
> resource that would be visible in /proc/iomem but would allow
> other resources to be requested even when overlapping the region of this
> special resource? This way, we could insert the "GART" resource
> when allocating the hole but later, when an actual AGP driver
> requests the range during PCI enumeration, the "GART" resource
> would be overwrtiten by the actual PCI resource.
> 
> -- 
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
