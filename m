Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-co1nam03on0063.outbound.protection.outlook.com
 ([104.47.40.63] helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dG3RG-0000vX-4H
 for kexec@lists.infradead.org; Wed, 31 May 2017 13:13:27 +0000
Subject: Re: [PATCH v5 29/32] x86/mm: Add support to encrypt the kernel
 in-place
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212149.10190.70894.stgit@tlendack-t1.amdoffice.net>
 <20170518124626.hqyqqbjpy7hmlpqc@pd.tnic>
 <7e2ae014-525c-76f2-9fce-2124596db2d2@amd.com>
 <20170526162522.p7prrqqalx2ivfxl@pd.tnic>
 <33c075b1-71f6-b5d0-b1fa-d742d0659d38@amd.com>
 <20170531095148.pba6ju6im4qxbwfg@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <17394b27-d693-4ff9-9dbd-11b5237fcf6a@amd.com>
Date: Wed, 31 May 2017 08:12:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170531095148.pba6ju6im4qxbwfg@pd.tnic>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 5/31/2017 4:51 AM, Borislav Petkov wrote:
> On Tue, May 30, 2017 at 11:39:07AM -0500, Tom Lendacky wrote:
>> Yes, it's from objtool:
>>
>> arch/x86/mm/mem_encrypt_boot.o: warning: objtool: .text+0xd2: return
>> instruction outside of a callable function
> 
> Oh, well, let's make it a global symbol then. Who knows, we might have
> to live-patch it someday :-)

Can do.

Thanks,
Tom

> 
> ---
> diff --git a/arch/x86/mm/mem_encrypt_boot.S b/arch/x86/mm/mem_encrypt_boot.S
> index fb58f9f953e3..7720b0050840 100644
> --- a/arch/x86/mm/mem_encrypt_boot.S
> +++ b/arch/x86/mm/mem_encrypt_boot.S
> @@ -47,9 +47,9 @@ ENTRY(sme_encrypt_execute)
>   	movq	%rdx, %r12		/* Kernel length */
>   
>   	/* Copy encryption routine into the workarea */
> -	movq	%rax, %rdi		/* Workarea encryption routine */
> -	leaq	.Lenc_start(%rip), %rsi	/* Encryption routine */
> -	movq	$(.Lenc_stop - .Lenc_start), %rcx	/* Encryption routine length */
> +	movq	%rax, %rdi				/* Workarea encryption routine */
> +	leaq	__enc_copy(%rip), %rsi			/* Encryption routine */
> +	movq	$(.L__enc_copy_end - __enc_copy), %rcx	/* Encryption routine length */
>   	rep	movsb
>   
>   	/* Setup registers for call */
> @@ -70,8 +70,7 @@ ENTRY(sme_encrypt_execute)
>   	ret
>   ENDPROC(sme_encrypt_execute)
>   
> -.Lenc_start:
> -ENTRY(sme_enc_routine)
> +ENTRY(__enc_copy)
>   /*
>    * Routine used to encrypt kernel.
>    *   This routine must be run outside of the kernel proper since
> @@ -147,5 +146,5 @@ ENTRY(sme_enc_routine)
>   	wrmsr
>   
>   	ret
> -ENDPROC(sme_enc_routine)
> -.Lenc_stop:
> +.L__enc_copy_end:
> +ENDPROC(__enc_copy)
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
