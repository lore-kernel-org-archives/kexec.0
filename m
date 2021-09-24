Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mThi0-00Dv5A-29
 for kexec@lists.infradead.org; Fri, 24 Sep 2021 09:41:33 +0000
Received: by mail-lf1-x130.google.com with SMTP id b15so37079516lfe.7
 for <kexec@lists.infradead.org>; Fri, 24 Sep 2021 02:41:31 -0700 (PDT)
Date: Fri, 24 Sep 2021 12:41:32 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
Message-ID: <20210924094132.gxyqp4z3qdk5w4j6@box.shutemov.name>
References: <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
 <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
 <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
 <YUuJZ2qOgbdpfk6N@zn.tnic>
 <20210922210558.itofvu3725dap5xx@box.shutemov.name>
 <YUzFj+yH79XRc3F3@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUzFj+yH79XRc3F3@zn.tnic>
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

On Thu, Sep 23, 2021 at 08:21:03PM +0200, Borislav Petkov wrote:
> On Thu, Sep 23, 2021 at 12:05:58AM +0300, Kirill A. Shutemov wrote:
> > Unless we find other way to guarantee RIP-relative access, we must use
> > fixup_pointer() to access any global variables.
> 
> Yah, I've asked compiler folks about any guarantees we have wrt
> rip-relative addresses but it doesn't look good. Worst case, we'd have
> to do the fixup_pointer() thing.
> 
> In the meantime, Tom and I did some more poking at this and here's a
> diff ontop.
> 
> The direction being that we'll stick both the AMD and Intel
> *cc_platform_has() call into cc_platform.c for which instrumentation
> will be disabled so no issues with that.
> 
> And that will keep all that querying all together in a single file.

And still do cc_platform_has() calls in __startup_64() codepath?

It's broken.

Intel detection in cc_platform_has() relies on boot_cpu_data.x86_vendor
which is not initialized until early_cpu_init() in setup_arch(). Given
that X86_VENDOR_INTEL is 0 it leads to false-positive.

I think opencode these two calls is the way forward. Maybe also move the
check from sme_encrypt_kernel() to __startup_64().

-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
