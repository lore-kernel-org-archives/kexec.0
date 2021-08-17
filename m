Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFwFy-0026j3-Dc
 for kexec@lists.infradead.org; Tue, 17 Aug 2021 10:23:48 +0000
Date: Tue, 17 Aug 2021 12:24:20 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 09/12] mm: Remove the now unused mem_encrypt_active()
 function
Message-ID: <YRuOVOdxOZm0S86j@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <83e4a62108eec470ac0b3f2510b982794d2b7989.1628873970.git.thomas.lendacky@amd.com>
 <YRuN6QhdIQtlluUh@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YRuN6QhdIQtlluUh@zn.tnic>
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
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Joerg Roedel <jroedel@suse.de>

On Tue, Aug 17, 2021 at 12:22:33PM +0200, Borislav Petkov wrote:
> This one wants to be part of the previous patch.

... and the three following patches too - the treewide patch does a
single atomic :) replacement and that's it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
