Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eK1T3-0002xy-9h
 for kexec@lists.infradead.org; Wed, 29 Nov 2017 12:27:59 +0000
Date: Wed, 29 Nov 2017 13:27:32 +0100
From: Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171129122732.qcpi655yf26iuspg@dwarf.suse.cz>
References: <20171106024143.GA3669@x1>
 <20171106090155.p7jhe2m57whfxma3@dwarf.suse.cz>
 <20171106092729.GB3669@x1>
 <20171106095638.7iwlyjmlom3tqelt@dwarf.suse.cz>
 <20171107113956.GC3669@x1>
 <20171107134212.tmjdt7rdailtbosa@dwarf.suse.cz>
 <20171107153428.ex27nwkvelhm2nm7@dwarf.suse.cz>
 <20171112080426.GB6429@x1>
 <20171128215833.hhcjvn5qjfc3bdrk@dwarf.suse.cz>
 <20171129024307.GE15074@x1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171129024307.GE15074@x1>
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

On Wed, Nov 29, 2017 at 10:43:07AM +0800, Baoquan He wrote:
> On 11/28/17 at 10:58pm, Jiri Bohac wrote:
> > On Sun, Nov 12, 2017 at 04:04:26PM +0800, Baoquan He wrote:
> > > Solution:
> > > 1) Remove the code which support GART IOMMU when it's not enabled in
> > > BIOS. This has been done in the new generation of hardware IOMMU like
> > > intel vt-d IOMMU and amd-Vi IOMMU. We should not make GART IOMMU be
> > > exceptional.
> > 
> > Wouldn't this break old machines with actual AGP and
> > misconfigured/bugg BIOSes? Wasn't that the reason why we have the
> > workaround of mapping the hole over real memory?
> 
> Hmm, a quick question, does it work when GART support is enabled in
> bios? In intel vt-d and amd-vi iommu, if user doesn't enable it in bios,
> the functionality will be disabled in kernel, why would we not do that
> for GART IOMMU? and why is GART so special?

My feeling is that there is no technical reason (perhaps there
were more broken BIOSes in the AGP days?). The main reason is
that the kernel has included the workaround since ever and
removing it now will break these machines. Even if most of them
would be fixed by properly configuring the BIOS, it will still be
regardes as a regression by the user, which I don't think is
acceptable. 

Currently everything works with the workaround, except kdump.
That's why I came up with a fix for [half of] kdump.

> > > 2) Remove those pages from mm subsystem since they are not seen any more
> > > though they have been added into mm subsystem, because CPU can't see
> > > them.

Could you explain what exactly you mean and how it would fix the
vmcore issue? 

> > > 3) Remove the apreture region from /proc/iomem so that pages in that
> > > region can't be seen by kdump kernel. This is easier, but just a work
> > > around.
> > 
> > I like this idea, but won't this cause pci_claim_resource() fail
> > after the call to pci_find_parent_resource() ? See my previous
> > mail.
> 
> Not very sure, now have not time to investigate why it cause failure.
> 
> I tried to find a system with GART in our lab, but failed. Those
> machines are too old

The vmcore problem is reproducible on modern AMD systems. This
has originally been reported by a customer running an "HP ProLiant
BL465c Gen8". I later reproduced it on a "ProLiant DL385p Gen8",
as well as many older systems.

So I believe kdump/vmcore needs fixing - it is broken on machines
sold today.

What became a bit "old" is the reason why we don't include the
"GART" region in the iomem resources - fix for a resource
conflict resulting in malfuncioning AGP hardware as reported in
bko#72201; see my original mail for the full info. But I don't
think we should break this old hardware again just to make the
kdump fix more beautiful.

> If have a easy fix, worth to have a try.

The fix for kexec_file_load-based kdump is easy and tested. I
don't insist on fixing the old kexec, because we don't use it on
x86_64. But I'm willing to help if you think it needs to be fixed
as well.

Regards,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
