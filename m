Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eQvlw-0005a5-6l
 for kexec@lists.infradead.org; Mon, 18 Dec 2017 13:48:09 +0000
Date: Mon, 18 Dec 2017 21:47:36 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171218134736.GA4035@x1>
References: <20171216001514.x5eg37ad4aa2fwqt@dwarf.suse.cz>
 <20171216010142.GK12442@x1>
 <20171217214735.nuxq5zo2eknqpbpi@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171217214735.nuxq5zo2eknqpbpi@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Jiri Bohac <jbohac@suse.cz>, Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, yinghai@kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 12/17/17 at 10:47pm, Borislav Petkov wrote:
> On Sat, Dec 16, 2017 at 09:01:42AM +0800, Baoquan He wrote:
> > 2) If firmware is broken, you can't enable gart in firmware, will
> > firmware engineer fix this since it's a firmware bug?
> 
> Slow down and get a reality check first please!
> 
> A firmware engineer will fix a 10yr old BIOS?!? Yeah right. And I'll get
> a pink pony for Christmas. Geez.

The code is too old. I tried to find out the original commit, many files
moving commits make it not easy to track. In the current code, can only
see the pr_info telling people to "enable the IOMMU option in the BIOS
setup". No even one word to mention that it's for borken firmware.

From Jiri's replying, he used 'guess', means the bug he is trying to fix
is not broken firmware case, but not enabling gart iommu support in bios.


gart_iommu_hole_init() {

	...

        } else if ((!no_iommu && max_pfn > MAX_DMA32_PFN) ||                                                                                     
                   force_iommu ||
                   valid_agp ||
                   fallback_aper_force) {
                pr_info("Your BIOS doesn't leave an aperture memory hole\n");
                pr_info("Please enable the IOMMU option in the BIOS setup\n");
                pr_info("This costs you %dMB of RAM\n",
                        32 << fallback_aper_order);
	...
}

> 
> We need a reliable way to tell the second kernel not to access the gart
> range. And frankly, the best thing to do would be to teach the *second*
> kernel to simply avoid the gart range. Regardless of what it gets told
> by the ELF header. Because there are some ranges which it shouldn't
> touch. Maybe we can reuse the gart detection code to do that in the
> second kernel too.

Previously people added gart region to iomem to notice that even though
there's ram mapped, while it's occupied by gart, please don't dump it.
Later it's reverted commit 707d4eefbdb3 ("Revert [PATCH] Insert GART
region into resource map"). 

In fact, there are two ways to fix this bug. One is to tell kdump kernel
not to dump the region of gart even though there are ram mapped to that
region and added to vmemmap and direct mapping. This was done before and
reverted later.

The other is not to tell kdump kernel that there's ram mapped into the
region. In the mail I replied to Jiri's v1 post, I meant the 2nd way.
Remove the ram region occupied by gart from iomem, then kdump kernel
won't see it and won't dump it.

And note that when we talk about this gart issue, we only mean the case
that gart support is not enabled in bios. In this case, gart will find a
region of ram and occupy it as gart aperture. And this is done during
gart iommu init, and after that ram region has been added to memory
subsystem.

> 
> But I haven't looked at it, might be hairy. Need to deal with this PTI
> madness first.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
