Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dLRHa-0006nc-Rj
 for kexec@lists.infradead.org; Thu, 15 Jun 2017 09:41:44 +0000
Date: Thu, 15 Jun 2017 11:41:12 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 26/34] iommu/amd: Allow the AMD IOMMU to work with
 memory encryption
Message-ID: <20170615094111.wga334kg2bhxqib3@pd.tnic>
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191745.28645.81756.stgit@tlendack-t1.amdoffice.net>
 <20170614174208.p2yr5exs4b6pjxhf@pd.tnic>
 <0611d01a-19f8-d6ae-2682-932789855518@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0611d01a-19f8-d6ae-2682-932789855518@amd.com>
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
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jun 14, 2017 at 03:40:28PM -0500, Tom Lendacky wrote:
> I was trying to keep all the logic for it here in the SME related files
> rather than put it in the iommu code itself. But it is easy enough to
> move if you think it's worth it.

Yes please - the less needlessly global symbols, the better.

> > Also, you said in another mail on this subthread that c->microcode
> > is not yet set. Are you saying, that the iommu init gunk runs before
> > init_amd(), where we do set c->microcode?
> > 
> > If so, we can move the setting to early_init_amd() or so.
> 
> I'll look into that.

And I don't think c->microcode is not set by the time we init the iommu
because, AFAICT, we do the latter in pci_iommu_init() and that's a
rootfs_initcall() which happens later then the CPU init stuff.

> I'll look into simplifying the checks.

Something like this maybe?

	if (rev >= 0x1205)
		return true;

	if (rev <= 0x11ff && rev >= 0x1126)
		return true;

	return false;

> > WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
> > #134: FILE: drivers/iommu/amd_iommu.c:866:
> > +static void build_completion_wait(struct iommu_cmd *cmd, volatile u64 *sem)
> > 
> 
> The semaphore area is written to by the device so the use of volatile is
> appropriate in this case.

Do you mean this is like the last exception case in that document above:

"
  - Pointers to data structures in coherent memory which might be modified
    by I/O devices can, sometimes, legitimately be volatile.  A ring buffer
    used by a network adapter, where that adapter changes pointers to
    indicate which descriptors have been processed, is an example of this
    type of situation."

?

If so, it did work fine until now, without the volatile. Why is it
needed now, all of a sudden?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
