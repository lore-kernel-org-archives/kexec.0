Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eR7Ak-0003rf-9P
 for kexec@lists.infradead.org; Tue, 19 Dec 2017 01:58:24 +0000
Date: Tue, 19 Dec 2017 09:58:04 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171219015804.GC4035@x1>
References: <20171216001514.x5eg37ad4aa2fwqt@dwarf.suse.cz>
 <20171216010142.GK12442@x1>
 <20171217214735.nuxq5zo2eknqpbpi@pd.tnic>
 <20171218134736.GA4035@x1>
 <20171218143753.k7xyq6yiyjisnonh@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171218143753.k7xyq6yiyjisnonh@pd.tnic>
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

On 12/18/17 at 03:37pm, Borislav Petkov wrote:
> On Mon, Dec 18, 2017 at 09:47:36PM +0800, Baoquan He wrote:
> >                 pr_info("Your BIOS doesn't leave an aperture memory hole\n");
> >                 pr_info("Please enable the IOMMU option in the BIOS setup\n");
> >                 pr_info("This costs you %dMB of RAM\n",
> >                         32 << fallback_aper_order);
> > 	...
> > }
> 
> There are BIOSen where there's not even an IOMMU option to enable in the
> first place. So forget fixing the firmware.

Yes, while GART might not be this case. Because in code there isn't any
information telling that ram region stealing is for borken firmware. And
even the pr_info is telling people to enable GART in bios.

In fact we at least should change the pr_info to pr_warn since this kind
of operation is not encouraged if firmware is not broken.


diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index f5d92bc3b884..281ba2b595aa 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -451,9 +451,9 @@ int __init gart_iommu_hole_init(void)
 		   force_iommu ||
 		   valid_agp ||
 		   fallback_aper_force) {
-		pr_info("Your BIOS doesn't leave an aperture memory hole\n");
-		pr_info("Please enable the IOMMU option in the BIOS setup\n");
-		pr_info("This costs you %dMB of RAM\n",
+		pr_warn("Your BIOS doesn't leave an aperture memory hole\n");
+		pr_warn("Please enable the IOMMU option in the BIOS setup\n");
+		pr_warn("This costs you %dMB of RAM\n",
 			32 << fallback_aper_order);
 
 		aper_order = fallback_aper_order;

> 
> > Previously people added gart region to iomem to notice that even though
> > there's ram mapped, while it's occupied by gart, please don't dump it.
> > Later it's reverted commit 707d4eefbdb3 ("Revert [PATCH] Insert GART
> > region into resource map").
> 
> Yes, I read Jiri's commit message, TYVM.
> 
> > The other is not to tell kdump kernel that there's ram mapped into the
> > region. In the mail I replied to Jiri's v1 post, I meant the 2nd way.
> > Remove the ram region occupied by gart from iomem, then kdump kernel
> > won't see it and won't dump it.
> 
> That's the wrong approach. Because this way you're lying in iomem about
> the layout by hiding the gart range.
> 
> What needs to happen is to *exclude* the region from the dumping side
> only, so that it doesn't touch it. Because the second kernel still needs
> to show a *correct* iomem ranges list. Imagine someone looks at it
> during debugging...

With dmesg of 1st kernel, people should know the situation. In 1st
kernel, the region of ram memory is reserved in memblock, then no anyone
will touch it. It may not make sense to debug this region.

As the pr_info is saying, that region of ram is stolen by GART, just
GART won't use it. not sure if anyone will try to debug it on purpose.

> 
> So I think Jiri's approach is the right thing to do.

Hmm, as I have said in the first replying mail, the v2 will introduce
issues:

1) If 'iommu=off' is specified in 1st kernel but not in kdump kernel, it
will ignore the ram we need dump.

2) If 'iommu=off' is specified in kdump kernel, but not in 1st kernel,
it won't get the GART region, this patch does't work.

3) If people enable GART in bios, there's a ram memory hole for GART.
Nothing need to do while kdump kernel doesn't know GART is enabled or
not in bios, will try to avoid it anyway. It won't hurt anythig though,
in logic it's not suggested since confusion will be brought in.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
