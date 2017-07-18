Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dXRFd-0005tc-9F
 for kexec@lists.infradead.org; Tue, 18 Jul 2017 12:05:20 +0000
Date: Tue, 18 Jul 2017 14:03:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v10 00/38] x86: Secure Memory Encryption (AMD)
In-Reply-To: <cover.1500319216.git.thomas.lendacky@amd.com>
Message-ID: <alpine.DEB.2.20.1707181402340.1945@nanos>
References: <cover.1500319216.git.thomas.lendacky@amd.com>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, Toshimitsu Kani <toshi.kani@hpe.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 17 Jul 2017, Tom Lendacky wrote:
> This patch series provides support for AMD's new Secure Memory Encryption (SME)
> feature.
> 
> SME can be used to mark individual pages of memory as encrypted through the
> page tables. A page of memory that is marked encrypted will be automatically
> decrypted when read from DRAM and will be automatically encrypted when
> written to DRAM. Details on SME can found in the links below.
> 
> The SME feature is identified through a CPUID function and enabled through
> the SYSCFG MSR. Once enabled, page table entries will determine how the
> memory is accessed. If a page table entry has the memory encryption mask set,
> then that memory will be accessed as encrypted memory. The memory encryption
> mask (as well as other related information) is determined from settings
> returned through the same CPUID function that identifies the presence of the
> feature.
> 
> The approach that this patch series takes is to encrypt everything possible
> starting early in the boot where the kernel is encrypted. Using the page
> table macros the encryption mask can be incorporated into all page table
> entries and page allocations. By updating the protection map, userspace
> allocations are also marked encrypted. Certain data must be accounted for
> as having been placed in memory before SME was enabled (EFI, initrd, etc.)
> and accessed accordingly.
> 
> This patch series is a pre-cursor to another AMD processor feature called
> Secure Encrypted Virtualization (SEV). The support for SEV will build upon
> the SME support and will be submitted later. Details on SEV can be found
> in the links below.

Well done series. Thanks to all people involved, especially Tom and Boris!
It was a pleasure to review that.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
