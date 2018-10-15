Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gBurK-0007H1-AR
 for kexec@lists.infradead.org; Mon, 15 Oct 2018 04:52:03 +0000
Date: Mon, 15 Oct 2018 12:51:38 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/3] x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one
 error
Message-ID: <20181015045138.GA9719@dhcp-128-65.nay.redhat.com>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805811578.1157.6948388946904655969.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180930092110.GB6950@dhcp-128-65.nay.redhat.com>
 <20180930092741.GC6950@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180930092741.GC6950@dhcp-128-65.nay.redhat.com>
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
To: Bjorn Helgaas <helgaas@kernel.org>, bp@suse.de
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, akpm@linux-foundation.org, dan.j.williams@intel.com, Vivek Goyal <vgoyal@redhat.com>

On 09/30/18 at 05:27pm, Dave Young wrote:
> On 09/30/18 at 05:21pm, Dave Young wrote:
> > Hi Bjorn,
> > 
> > On 09/27/18 at 09:21am, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > The only use of KEXEC_BACKUP_SRC_END is as an argument to
> > > walk_system_ram_res():
> > > 
> > >   int crash_load_segments(struct kimage *image)
> > >   {
> > >     ...
> > >     walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
> > >                         image, determine_backup_region);
> > > 
> > > walk_system_ram_res() expects "start, end" arguments that are inclusive,
> > > i.e., the range to be walked includes both the start and end addresses.
> > 
> > Looking at the function comment of find_next_iomem_res,  the res->end
> > should be exclusive, am I missing something?
> 
> Oops,  you fix it in 2nd patch, I apparently miss that.
> 
> Since the fix of checking the end is in another patch, probably merge
> these two patches so that they are in one patch to avoid break bisect. 

Not sure if above comment was missed, Boris, would you mind to fold the
patch 1 and 2?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
