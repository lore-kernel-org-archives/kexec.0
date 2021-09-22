Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT9RH-009euB-98
 for kexec@lists.infradead.org; Wed, 22 Sep 2021 21:06:01 +0000
Received: by mail-lf1-x135.google.com with SMTP id x27so17402406lfu.5
 for <kexec@lists.infradead.org>; Wed, 22 Sep 2021 14:05:58 -0700 (PDT)
Date: Thu, 23 Sep 2021 00:05:58 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
Message-ID: <20210922210558.itofvu3725dap5xx@box.shutemov.name>
References: <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
 <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
 <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
 <YUuJZ2qOgbdpfk6N@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUuJZ2qOgbdpfk6N@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Christoph Hellwig <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On Wed, Sep 22, 2021 at 09:52:07PM +0200, Borislav Petkov wrote:
> On Wed, Sep 22, 2021 at 05:30:15PM +0300, Kirill A. Shutemov wrote:
> > Not fine, but waiting to blowup with random build environment change.
> 
> Why is it not fine?
> 
> Are you suspecting that the compiler might generate something else and
> not a rip-relative access?

Yes. We had it before for __supported_pte_mask and other users of
fixup_pointer().

See for instance 4a09f0210c8b ("x86/boot/64/clang: Use fixup_pointer() to
access '__supported_pte_mask'")

Unless we find other way to guarantee RIP-relative access, we must use
fixup_pointer() to access any global variables.

-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
