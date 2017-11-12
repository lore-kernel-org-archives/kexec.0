Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eDpRD-0003sr-MF
 for kexec@lists.infradead.org; Sun, 12 Nov 2017 10:24:30 +0000
Date: Sun, 12 Nov 2017 18:23:57 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171112102357.GA10474@x1>
References: <20171103172822.4ty6yjhewroe4z4j@dwarf.suse.cz>
 <20171106024143.GA3669@x1>
 <20171106090155.p7jhe2m57whfxma3@dwarf.suse.cz>
 <20171106092729.GB3669@x1>
 <20171106095638.7iwlyjmlom3tqelt@dwarf.suse.cz>
 <20171107113956.GC3669@x1>
 <20171107134212.tmjdt7rdailtbosa@dwarf.suse.cz>
 <20171107153428.ex27nwkvelhm2nm7@dwarf.suse.cz>
 <20171112080426.GB6429@x1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171112080426.GB6429@x1>
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
To: Jiri Bohac <jbohac@suse.cz>, yinghai@kernel.org, joro@8bytes.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 11/12/17 at 04:04pm, Baoquan He wrote:
> On 11/07/17 at 04:34pm, Jiri Bohac wrote:
> > On Tue, Nov 07, 2017 at 02:42:12PM +0100, Jiri Bohac wrote:
> > > On Tue, Nov 07, 2017 at 07:39:56PM +0800, Baoquan He wrote:
> > > > don't worry about the user space kexec utility either. 
> > > 
> > > What's the problem with the userspace kexec? The bug is in
> > > reading /proc/vmcore by makedumpfile. kexec would only operate
> > > within the preallocated crashkernel area, right?
> > 
> > right, I see it (without -s the kexec userspace creates the ELF header
> > later used the second kernel for /proc/vmcore).
> 
> Yes, I meant this. In kernel, you can define global variable to store
> the starting address and end of GART aperture. While, in user space
> there's no way to know that. Now the non '-s' kexec are still being used
> by most of people.
> 
> I roughly went through agp3.0 doc and GART code, the root cause for this
> issue should be:
> 
> AMD system with GART need be enabled in BIOS in principle. Then firmware
> will arrange a hole in system address space, defaultly it's 64MB for GART
> aperture mapping, below and close to 4G usually. GART stands for Graphic
> Address Remap Table, each of its entry can be used to refer to a address
> region in the 64M of aperture for iommu usage.
> 
> However, in your testing AMD system, you don't enable GART IOMMU support
> in BIOS setting. So the current implementation in kernel is to find a
> region which is occupied by system RAM and configre the starting addr
> and size into GART cofig registers' AMD64_GARTAPERTURECTL and
> AMD64_GARTAPERTUREBASE. And this happens in the first kernel. I believe
> in kdump kernel, since only resereved crashkernel region is taken as
> available system RAM, the rest of original RAM space is seen as hole.
> So kdump kernel will still use the 1st kernel's aperture region for GART,
> and it also has been set in GART register, kdump kernel think it as BIOS
> has reserved hole for GART aperture.
> 
> Now the problem is that those pages reserved for GART aperture have been
> added into mm subsystem. GART is located on North Bridge. But when CPU
> try to access these them, will check North Bridge chip firstly, then
> hardware error occured that region has been set in GART registers which
                        ^since (missed)
> locates in NB.
> 
> Solution:
> 1) Remove the code which support GART IOMMU when it's not enabled in
> BIOS. This has been done in the new generation of hardware IOMMU like
> intel vt-d IOMMU and amd-Vi IOMMU. We should not make GART IOMMU be
> exceptional.
> 
> 2) Remove those pages from mm subsystem since they are not seen any more
> though they have been added into mm subsystem, because CPU can't see
> them.
> 
> 3) Remove the apreture region from /proc/iomem so that pages in that
> region can't be seen by kdump kernel. This is easier, but just a work
> around.
> 
> Hi Yinghai, Joerg, and Bjorn
> 
> Found patches you contributed to GART IOMMU, do you have any suggestion
> about this issue? Or any comment about these 3 options? 
> 
> I personally prefer the 1st one.
> 
> Thanks
> Baoquan
> 
> > 
> > No idea how to fix that nicely...
> > 
> > -- 
> > Jiri Bohac <jbohac@suse.cz>
> > SUSE Labs, Prague, Czechia
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
