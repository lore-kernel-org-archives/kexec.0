Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNLqz-0004t5-Pm
 for kexec@lists.infradead.org; Tue, 20 Jun 2017 16:18:11 +0000
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com
 [209.85.217.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D951C239F2
 for <kexec@lists.infradead.org>; Tue, 20 Jun 2017 16:17:47 +0000 (UTC)
Received: by mail-ua0-f182.google.com with SMTP id d45so46559112uai.1
 for <kexec@lists.infradead.org>; Tue, 20 Jun 2017 09:17:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170616185154.18967.71073.stgit@tlendack-t1.amdoffice.net>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185154.18967.71073.stgit@tlendack-t1.amdoffice.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 20 Jun 2017 09:17:26 -0700
Message-ID: <CALCETrVkyj=wfcgNMVG_BU+xGb3yBNhxrDdSTxJLx7UYraVcUA@mail.gmail.com>
Subject: Re: [PATCH v7 11/36] x86/mm: Add SME support for read_cr3_pa()
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
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>, X86 ML <x86@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev <kasan-dev@googlegroups.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, xen-devel <xen-devel@lists.xen.org>, iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jun 16, 2017 at 11:51 AM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> The cr3 register entry can contain the SME encryption mask that indicates
> the PGD is encrypted.  The encryption mask should not be used when
> creating a virtual address from the cr3 register, so remove the SME
> encryption mask in the read_cr3_pa() function.
>
> During early boot SME will need to use a native version of read_cr3_pa(),
> so create native_read_cr3_pa().
>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/processor-flags.h |    3 ++-
>  arch/x86/include/asm/processor.h       |    5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
> index 79aa2f9..cb6999c 100644
> --- a/arch/x86/include/asm/processor-flags.h
> +++ b/arch/x86/include/asm/processor-flags.h
> @@ -2,6 +2,7 @@
>  #define _ASM_X86_PROCESSOR_FLAGS_H
>
>  #include <uapi/asm/processor-flags.h>
> +#include <linux/mem_encrypt.h>
>
>  #ifdef CONFIG_VM86
>  #define X86_VM_MASK    X86_EFLAGS_VM
> @@ -33,7 +34,7 @@
>   */
>  #ifdef CONFIG_X86_64
>  /* Mask off the address space ID bits. */
> -#define CR3_ADDR_MASK 0x7FFFFFFFFFFFF000ull
> +#define CR3_ADDR_MASK __sme_clr(0x7FFFFFFFFFFFF000ull)

Can you update the comment one line above, too?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
