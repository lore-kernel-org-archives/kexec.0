Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNhiB-0005vv-9J
 for kexec@lists.infradead.org; Wed, 21 Jun 2017 15:38:36 +0000
Date: Wed, 21 Jun 2017 17:38:04 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 08/36] x86/mm: Add support to enable SME in early boot
 processing
In-Reply-To: <8d3c215f-cdad-5554-6e9c-5598e1081850@amd.com>
Message-ID: <alpine.DEB.2.20.1706211720060.2328@nanos>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185115.18967.79622.stgit@tlendack-t1.amdoffice.net>
 <alpine.DEB.2.20.1706202259290.2157@nanos>
 <8d3c215f-cdad-5554-6e9c-5598e1081850@amd.com>
MIME-Version: 1.0
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 21 Jun 2017, Tom Lendacky wrote:
> On 6/21/2017 2:16 AM, Thomas Gleixner wrote:
> > Why is this an unconditional function? Isn't the mask simply 0 when the MEM
> > ENCRYPT support is disabled?
> 
> I made it unconditional because of the call from head_64.S. I can't make
> use of the C level static inline function and since the mask is not a
> variable if CONFIG_AMD_MEM_ENCRYPT is not configured (#defined to 0) I
> can't reference the variable directly.
> 
> I could create a #define in head_64.S that changes this to load rax with
> the variable if CONFIG_AMD_MEM_ENCRYPT is configured or a zero if it's
> not or add a #ifdef at that point in the code directly. Thoughts on
> that?

See below.

> > That does not make any sense. Neither the call to sme_encrypt_kernel() nor
> > the following call to sme_get_me_mask().
> > 
> > __startup_64() is already C code, so why can't you simply call that from
> > __startup_64() in C and return the mask from there?
> 
> I was trying to keep it explicit as to what was happening, but I can
> move those calls into __startup_64().

That's much preferred. And the return value wants to be documented in both
C and ASM code.

> I'll still need the call to sme_get_me_mask() in the secondary_startup_64
> path, though (depending on your thoughts to the above response).

        call verify_cpu

        movq    $(init_top_pgt - __START_KERNEL_map), %rax

So if you make that:

	/*
	 * Sanitize CPU configuration and retrieve the modifier
	 * for the initial pgdir entry which will be programmed
	 * into CR3. Depends on enabled SME encryption, normally 0.
	 */
	call __startup_secondary_64

        addq    $(init_top_pgt - __START_KERNEL_map), %rax

You can hide that stuff in C-code nicely without adding any cruft to the
ASM code.

Thanks,

	tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
