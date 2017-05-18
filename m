Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dBRS8-0003iI-2V
 for kexec@lists.infradead.org; Thu, 18 May 2017 19:51:22 +0000
Received: by mail-wm0-x233.google.com with SMTP id d127so64074764wmf.0
 for <kexec@lists.infradead.org>; Thu, 18 May 2017 12:50:54 -0700 (PDT)
Date: Thu, 18 May 2017 20:50:51 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH v5 17/32] x86/mm: Add support to access boot related data
 in the clear
Message-ID: <20170518195051.GA5651@codeblueprint.co.uk>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211921.10190.1537.stgit@tlendack-t1.amdoffice.net>
 <20170515183517.mb4k2gp2qobbuvtm@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170515183517.mb4k2gp2qobbuvtm@pd.tnic>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 15 May, at 08:35:17PM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 04:19:21PM -0500, Tom Lendacky wrote:
>
> > +		paddr = boot_params.efi_info.efi_memmap_hi;
> > +		paddr <<= 32;
> > +		paddr |= boot_params.efi_info.efi_memmap;
> > +		if (phys_addr == paddr)
> > +			return true;
> > +
> > +		paddr = boot_params.efi_info.efi_systab_hi;
> > +		paddr <<= 32;
> > +		paddr |= boot_params.efi_info.efi_systab;
> 
> So those two above look like could be two global vars which are
> initialized somewhere in the EFI init path:
> 
> efi_memmap_phys and efi_systab_phys or so.
> 
> Matt ?
> 
> And then you won't need to create that paddr each time on the fly. I
> mean, it's not a lot of instructions but still...
 
We should already have the physical memmap address available in
'efi.memmap.phys_map'.

And the physical address of the system table should be in
'efi_phys.systab'. See efi_init().

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
