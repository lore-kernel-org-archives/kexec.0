Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNkkd-0004KS-LQ
 for kexec@lists.infradead.org; Wed, 21 Jun 2017 18:53:17 +0000
Date: Wed, 21 Jun 2017 20:52:47 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 08/36] x86/mm: Add support to enable SME in early boot
 processing
In-Reply-To: <fc697503-ec54-f481-36b3-3d5bf63aaaee@amd.com>
Message-ID: <alpine.DEB.2.20.1706212051120.2152@nanos>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185115.18967.79622.stgit@tlendack-t1.amdoffice.net>
 <alpine.DEB.2.20.1706202259290.2157@nanos>
 <8d3c215f-cdad-5554-6e9c-5598e1081850@amd.com>
 <alpine.DEB.2.20.1706211720060.2328@nanos>
 <fc697503-ec54-f481-36b3-3d5bf63aaaee@amd.com>
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
> On 6/21/2017 10:38 AM, Thomas Gleixner wrote:
> > 	/*
> > 	 * Sanitize CPU configuration and retrieve the modifier
> > 	 * for the initial pgdir entry which will be programmed
> > 	 * into CR3. Depends on enabled SME encryption, normally 0.
> > 	 */
> > 	call __startup_secondary_64
> > 
> >          addq    $(init_top_pgt - __START_KERNEL_map), %rax
> > 
> > You can hide that stuff in C-code nicely without adding any cruft to the
> > ASM code.
> > 
> 
> Moving the call to verify_cpu into the C-code might be quite a bit of
> change.  Currently, the verify_cpu code is included code and not a
> global function.

Ah. Ok. I missed that.

> I can still do the __startup_secondary_64() function and then look to
> incorporate verify_cpu into both __startup_64() and
> __startup_secondary_64() as a post-patch to this series.

Yes, just having __startup_secondary_64() for now and there the extra bits
for that encryption stuff is fine.

> At least the secondary path will have a base C routine to which
> modifications can be made in the future if needed.  How does that sound?

Sounds like a plan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
