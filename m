Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNzuY-00010F-Ce
 for kexec@lists.infradead.org; Thu, 22 Jun 2017 11:04:32 +0000
Received: by mail-wr0-x232.google.com with SMTP id c11so18356403wrc.3
 for <kexec@lists.infradead.org>; Thu, 22 Jun 2017 04:04:08 -0700 (PDT)
Date: Thu, 22 Jun 2017 12:04:05 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH v7 19/36] x86/mm: Add support to access boot related data
 in the clear
Message-ID: <20170622110405.GC3129@codeblueprint.co.uk>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185326.18967.43278.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170616185326.18967.43278.stgit@tlendack-t1.amdoffice.net>
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

On Fri, 16 Jun, at 01:53:26PM, Tom Lendacky wrote:
> Boot data (such as EFI related data) is not encrypted when the system is
> booted because UEFI/BIOS does not run with SME active. In order to access
> this data properly it needs to be mapped decrypted.
> 
> Update early_memremap() to provide an arch specific routine to modify the
> pagetable protection attributes before they are applied to the new
> mapping. This is used to remove the encryption mask for boot related data.
> 
> Update memremap() to provide an arch specific routine to determine if RAM
> remapping is allowed.  RAM remapping will cause an encrypted mapping to be
> generated. By preventing RAM remapping, ioremap_cache() will be used
> instead, which will provide a decrypted mapping of the boot related data.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/io.h |    5 +
>  arch/x86/mm/ioremap.c     |  179 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/io.h        |    2 +
>  kernel/memremap.c         |   20 ++++-
>  mm/early_ioremap.c        |   18 ++++-
>  5 files changed, 217 insertions(+), 7 deletions(-)

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
