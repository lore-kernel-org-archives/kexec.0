Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG42a-003FVn-V9
 for kexec@lists.infradead.org; Tue, 17 Aug 2021 18:42:29 +0000
Date: Tue, 17 Aug 2021 20:43:03 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 06/12] x86/sev: Replace occurrences of sev_active()
 with prot_guest_has()
Message-ID: <YRwDN+hkQpuSp+Vt@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <2b3a8fc4659f2e7617399cecdcca549e0fa1dcb7.1628873970.git.thomas.lendacky@amd.com>
 <YRuJPqxFZ6ItZd++@zn.tnic>
 <b346ae1b-dbd3-cdbd-b5cd-b5ab9c304737@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b346ae1b-dbd3-cdbd-b5cd-b5ab9c304737@amd.com>
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
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Joerg Roedel <jroedel@suse.de>

On Tue, Aug 17, 2021 at 10:26:18AM -0500, Tom Lendacky wrote:
> >>  	/*
> >> -	 * If SME is active we need to be sure that kexec pages are
> >> -	 * not encrypted because when we boot to the new kernel the
> >> +	 * If host memory encryption is active we need to be sure that kexec
> >> +	 * pages are not encrypted because when we boot to the new kernel the
> >>  	 * pages won't be accessed encrypted (initially).
> >>  	 */
> > 
> > That hunk belongs logically into the previous patch which removes
> > sme_active().
> 
> I was trying to keep the sev_active() changes separate... so even though
> it's an SME thing, I kept it here. But I can move it to the previous
> patch, it just might look strange.

Oh I meant only the comment because it is a SME-related change. But not
too important so whatever.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
