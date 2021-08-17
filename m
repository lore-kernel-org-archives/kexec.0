Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFvyO-001zIM-K7
 for kexec@lists.infradead.org; Tue, 17 Aug 2021 10:05:36 +0000
Date: Tue, 17 Aug 2021 12:06:10 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 07/12] x86/sev: Replace occurrences of sev_es_active()
 with prot_guest_has()
Message-ID: <YRuKEhzOh8pO4He1@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <0b8480d93b5090fcc34cf5d5035d4d89aa765d79.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0b8480d93b5090fcc34cf5d5035d4d89aa765d79.1628873970.git.thomas.lendacky@amd.com>
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
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

On Fri, Aug 13, 2021 at 11:59:26AM -0500, Tom Lendacky wrote:
> Replace occurrences of sev_es_active() with the more generic
> prot_guest_has() using PATTR_GUEST_PROT_STATE, except for in
> arch/x86/kernel/sev*.c and arch/x86/mm/mem_encrypt*.c where PATTR_SEV_ES
> will be used. If future support is added for other memory encyrption
> techonologies, the use of PATTR_GUEST_PROT_STATE can be updated, as
> required, to specifically use PATTR_SEV_ES.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h | 2 --
>  arch/x86/kernel/sev.c              | 6 +++---
>  arch/x86/mm/mem_encrypt.c          | 7 +++----
>  arch/x86/realmode/init.c           | 3 +--
>  4 files changed, 7 insertions(+), 11 deletions(-)

Same comments to this one as for the previous two.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
