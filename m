Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG40r-003FHG-QT
 for kexec@lists.infradead.org; Tue, 17 Aug 2021 18:40:42 +0000
Date: Tue, 17 Aug 2021 20:41:16 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 05/12] x86/sme: Replace occurrences of sme_active()
 with prot_guest_has()
Message-ID: <YRwCzH75WlfuQ6Yy@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <c6c38d6253dc78381f9ff0f1823b6ee5ddeefacc.1628873970.git.thomas.lendacky@amd.com>
 <YRt6yCNCBLwyyx5X@zn.tnic>
 <2996b1c8-1ea1-0e56-3aad-08b46fc207f0@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2996b1c8-1ea1-0e56-3aad-08b46fc207f0@amd.com>
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
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, Joerg Roedel <jroedel@suse.de>

On Tue, Aug 17, 2021 at 09:46:58AM -0500, Tom Lendacky wrote:
> I'm ok with letting the TDX folks make changes to these calls to be SME or
> SEV specific, if necessary, later.

Yap, exactly. Let's add the specific stuff only when really needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
