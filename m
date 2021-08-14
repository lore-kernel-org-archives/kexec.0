Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEvWW-00ELCZ-7m
 for kexec@lists.infradead.org; Sat, 14 Aug 2021 15:24:42 +0000
Date: Sat, 14 Aug 2021 17:25:03 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 01/12] x86/ioremap: Selectively build arch override
 encryption functions
Message-ID: <YRfgTzhKCn7otSzy@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <a4338245609a6be63b162e3516d3f6614db782a4.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4338245609a6be63b162e3516d3f6614db782a4.1628873970.git.thomas.lendacky@amd.com>
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
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Fri, Aug 13, 2021 at 11:59:20AM -0500, Tom Lendacky wrote:
> In prep for other uses of the prot_guest_has() function besides AMD's
> memory encryption support, selectively build the AMD memory encryption
> architecture override functions only when CONFIG_AMD_MEM_ENCRYPT=y. These
> functions are:
> - early_memremap_pgprot_adjust()
> - arch_memremap_can_ram_remap()
> 
> Additionally, routines that are only invoked by these architecture
> override functions can also be conditionally built. These functions are:
> - memremap_should_map_decrypted()
> - memremap_is_efi_data()
> - memremap_is_setup_data()
> - early_memremap_is_setup_data()
> 
> And finally, phys_mem_access_encrypted() is conditionally built as well,
> but requires a static inline version of it when CONFIG_AMD_MEM_ENCRYPT is
> not set.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/io.h | 8 ++++++++
>  arch/x86/mm/ioremap.c     | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)

LGTM.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
