Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eU6Oj-0000Nv-FD
 for kexec@lists.infradead.org; Wed, 27 Dec 2017 07:45:11 +0000
Date: Wed, 27 Dec 2017 15:44:49 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171227074449.GA15255@x1>
References: <20171216001514.x5eg37ad4aa2fwqt@dwarf.suse.cz>
 <20171216010142.GK12442@x1>
 <20171217214735.nuxq5zo2eknqpbpi@pd.tnic>
 <20171218134736.GA4035@x1>
 <20171218143753.k7xyq6yiyjisnonh@pd.tnic>
 <20171219015804.GC4035@x1>
 <20171219175827.oqfskuax6zzm2ljq@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171219175827.oqfskuax6zzm2ljq@dwarf.suse.cz>
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

On 12/19/17 at 06:58pm, Jiri Bohac wrote:

Sorry for late response. Please see the inline comments.

> 
> On Tue, Dec 19, 2017 at 09:58:04AM +0800, Baoquan He wrote:
> > Hmm, as I have said in the first replying mail, the v2 will introduce
> > issues:
> > 
> > 1) If 'iommu=off' is specified in 1st kernel but not in kdump kernel, it
> > will ignore the ram we need dump.
> 
> yes, instead of crashing the machine (because GART may be initialized in the
> 2nd kernel, overlapping the 1st kernel memory, which the 2nd kernel with its
> fake e820 map sees as unused).
> 
> I'd say this is an improvement.

I don't get what you said. If 'iommu=off' only specified in 1st kernel,
kdump kernel will think the memory which GART bar pointed as a hole.
This is incorrect. I don't see the improvement.

> 
> > 2) If 'iommu=off' is specified in kdump kernel, but not in 1st kernel,
> > it won't get the GART region, this patch does't work.
> 
> No. It will work:
> 
> First kernel initializes the GART (either in a hole properly provided by the
> BIOS or overlapping e820 RAM).
> 
> Second kernel will start with the GART initialized.  In gart_iommu_hole_init()
> the setting is read from the northbridge registers and verified as valid. It
> does not overlap e820 memory, because the second kernel has a fake e820 map
> only spanning the crashkernel= reserved range. "fix" is never set to 1, so it
> will exclude GART from vmcore in this path:
> 
> out:
>         if (!fix && !fallback_aper_force) {
>                 if (last_aper_base) {
>                         exclude_from_vmcore(last_aper_base, last_aper_order);
>                         return 1;
> 
> (fix is never set to 1)
> no_iommu is only checked after that.

Seems yes. Well, the interesting thing is 'iommu=off' doesn't even work,
right? Well, I don't know why the GART hardware/firmware/implementation
is so ..., well, freaky. Even though 'iommu=off' is specified
explicitly, it will initialize anyway.
> 
> 
> > 3) If people enable GART in bios, there's a ram memory hole for GART.
> > Nothing need to do while kdump kernel doesn't know GART is enabled or
> > not in bios, will try to avoid it anyway. It won't hurt anythig though,
> > in logic it's not suggested since confusion will be brought in.
> 
> I don't have easy access to the HP machines. I have a machine right here in our
> lab that has this issue. It has no "enable GART" setting in BIOS.  It has a
> "enable IOMMU" setting. The bug stays there regardless of the setting.
> It's old. Noone will fix the firmware. The patch fixes it.

OK, then we need fix it. In fact, in my personal opinion, if there's
a chance, we should avoid to fix it, because
 ..GART is too old, and systems with GART rarely are seen currently;
 ..The code is too freaky, no clear code comment. As you can see, we
usually clean up codes around too when we fix a found issue. While
there's no way to begin to do clean up for GART, and it's not worth
doing that.

I understand you could get a bug report from other people, and have to
fix it as an assignee. And this fix is located in aperture_64.c only,
I am fine it's done like this. Maybe you can try the way I suggested
that only removing the region from io resource, but not touching anything
else, if you have interest.

So if have to, could you add some code comments around your fix to notice
people why these code are introduced? Commit log can help to understand
added code, while sometime file moving may make this checking very hard.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
