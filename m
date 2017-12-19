Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eRMA6-0006Bf-Uu
 for kexec@lists.infradead.org; Tue, 19 Dec 2017 17:58:44 +0000
Date: Tue, 19 Dec 2017 18:58:27 +0100
From: Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH v2] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171219175827.oqfskuax6zzm2ljq@dwarf.suse.cz>
References: <20171216001514.x5eg37ad4aa2fwqt@dwarf.suse.cz>
 <20171216010142.GK12442@x1>
 <20171217214735.nuxq5zo2eknqpbpi@pd.tnic>
 <20171218134736.GA4035@x1>
 <20171218143753.k7xyq6yiyjisnonh@pd.tnic>
 <20171219015804.GC4035@x1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171219015804.GC4035@x1>
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
To: Baoquan He <bhe@redhat.com>
Cc: Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, yinghai@kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>


On Tue, Dec 19, 2017 at 09:58:04AM +0800, Baoquan He wrote:
> Hmm, as I have said in the first replying mail, the v2 will introduce
> issues:
> 
> 1) If 'iommu=off' is specified in 1st kernel but not in kdump kernel, it
> will ignore the ram we need dump.

yes, instead of crashing the machine (because GART may be initialized in the
2nd kernel, overlapping the 1st kernel memory, which the 2nd kernel with its
fake e820 map sees as unused).

I'd say this is an improvement.

> 2) If 'iommu=off' is specified in kdump kernel, but not in 1st kernel,
> it won't get the GART region, this patch does't work.

No. It will work:

First kernel initializes the GART (either in a hole properly provided by the
BIOS or overlapping e820 RAM).

Second kernel will start with the GART initialized.  In gart_iommu_hole_init()
the setting is read from the northbridge registers and verified as valid. It
does not overlap e820 memory, because the second kernel has a fake e820 map
only spanning the crashkernel= reserved range. "fix" is never set to 1, so it
will exclude GART from vmcore in this path:

out:
        if (!fix && !fallback_aper_force) {
                if (last_aper_base) {
                        exclude_from_vmcore(last_aper_base, last_aper_order);
                        return 1;

(fix is never set to 1)
no_iommu is only checked after that.


> 3) If people enable GART in bios, there's a ram memory hole for GART.
> Nothing need to do while kdump kernel doesn't know GART is enabled or
> not in bios, will try to avoid it anyway. It won't hurt anythig though,
> in logic it's not suggested since confusion will be brought in.

I don't have easy access to the HP machines. I have a machine right here in our
lab that has this issue. It has no "enable GART" setting in BIOS.  It has a
"enable IOMMU" setting. The bug stays there regardless of the setting.
It's old. Noone will fix the firmware. The patch fixes it.

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
