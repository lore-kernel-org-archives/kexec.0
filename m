Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eC49F-0001Me-HQ
 for kexec@lists.infradead.org; Tue, 07 Nov 2017 13:42:40 +0000
Date: Tue, 7 Nov 2017 14:42:12 +0100
From: Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171107134212.tmjdt7rdailtbosa@dwarf.suse.cz>
References: <20171103172822.4ty6yjhewroe4z4j@dwarf.suse.cz>
 <20171106024143.GA3669@x1>
 <20171106090155.p7jhe2m57whfxma3@dwarf.suse.cz>
 <20171106092729.GB3669@x1>
 <20171106095638.7iwlyjmlom3tqelt@dwarf.suse.cz>
 <20171107113956.GC3669@x1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171107113956.GC3669@x1>
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
Cc: Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Nov 07, 2017 at 07:39:56PM +0800, Baoquan He wrote:
> I saw you defined the variable as xx_stolen_xx, does it mean that the
> memory region where aperture located will be stolen from memory domain?
> I am wondering if it will cause error when access this region from direct
> mapping since allocate_aperture() is called in pci_iommu_alloc(), while
> in setup_arch() we have built the direct mapping for all system
> ram. Did I miss anything?

yes, I believe accessing it through the direct mapping would
cause the error; but the range is allocated by the memblock
allocator and never given back, which effectively steals it from
any other use; The memory will never be given to any user by any
subsequent allocation, so nothing will access it.

> Anyway, if it should be excluded from crash memory region, can we dig it
> away from /proc/iomem so that it's a hole in /proc/vmcore? Like this, we

Not sure this would work. In bko#72201, marking the range as used
caused pci_claim_resource() to error out with -EBUSY after
request_resource_conflict() (the error message has changed in
29003be but the logic remains).

My (possibly wrong?) reading of pci_claim_resource() tells me
that leaving the range out of the map would cause it to error out
a little earlier with -EINVAL just after
pci_find_parent_resource().  I'd rather avoid such experiments in
fear of causing regressions similar to bko#72201. This particular
one remained unnoticed for 8 years. I can't possibly test all AGP
drivers :/ 
(So much for my justification of passing this to crash
independently of the iomem_resource/e820 infrastructure.)

> don't worry about the user space kexec utility either. 

What's the problem with the userspace kexec? The bug is in
reading /proc/vmcore by makedumpfile. kexec would only operate
within the preallocated crashkernel area, right?

Regards,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
