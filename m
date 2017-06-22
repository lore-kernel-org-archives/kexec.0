Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNzp6-0007bN-S1
 for kexec@lists.infradead.org; Thu, 22 Jun 2017 10:58:54 +0000
Received: by mail-wr0-x231.google.com with SMTP id c11so18154472wrc.3
 for <kexec@lists.infradead.org>; Thu, 22 Jun 2017 03:58:32 -0700 (PDT)
Date: Thu, 22 Jun 2017 11:58:30 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH v7 18/36] x86/efi: Update EFI pagetable creation to work
 with SME
Message-ID: <20170622105830.GB3129@codeblueprint.co.uk>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185317.18967.99499.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170616185317.18967.99499.stgit@tlendack-t1.amdoffice.net>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 16 Jun, at 01:53:17PM, Tom Lendacky wrote:
> When SME is active, pagetable entries created for EFI need to have the
> encryption mask set as necessary.
> 
> When the new pagetable pages are allocated they are mapped encrypted. So,
> update the efi_pgt value that will be used in cr3 to include the encryption
> mask so that the PGD table can be read successfully. The pagetable mapping
> as well as the kernel are also added to the pagetable mapping as encrypted.
> All other EFI mappings are mapped decrypted (tables, etc.).
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/platform/efi/efi_64.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
 
Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
