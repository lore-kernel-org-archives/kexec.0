Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-sn1nam04on0628.outbound.protection.outlook.com
 ([2a01:111:f400:fe4c::628]
 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5WAh-0000DN-PH
 for kexec@lists.infradead.org; Thu, 27 Sep 2018 13:17:38 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Date: Thu, 27 Sep 2018 13:16:57 +0000
Message-ID: <1a9e75fa-5105-f17d-e8f8-a3d2314c9680@amd.com>
References: <20180927123845.32052-1-kasong@redhat.com>
In-Reply-To: <20180927123845.32052-1-kasong@redhat.com>
Content-Language: en-US
Content-ID: <41260C7D53A8124F84B47302815E6E84@namprd12.prod.outlook.com>
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
To: Kairui Song <kasong@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "ghook@redhat.com" <ghook@redhat.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "bp@suse.de" <bp@suse.de>, "dyoung@redhat.com" <dyoung@redhat.com>

On 09/27/2018 07:38 AM, Kairui Song wrote:
> Commit 1958b5fc4010 ("x86/boot: Add early boot support when running
> with SEV active") is causing kexec becomes sometimes unstable even if
> SEV is not active. kexec reboot won't start a second kernel bypassing
> BIOS boot process, instead, the system got reset.
> 
> That's because, in get_sev_encryption_bit function, we are using
> 32-bit RIP-relative addressing to read the value of enc_bit, but
> kexec may alloc the early boot up code to a higher location, which
> is beyond 32-bit addressing limit. Some garbage will be read and
> get_sev_encryption_bit will return the wrong value, which leads to
> wrong memory page flag.
> 
> This patch removes the use of enc_bit, as currently, enc_bit's only
> purpose is to avoid duplicated encryption bit reading, but the overhead
> of reading encryption bit is so tiny, so no need to cache that.
> 
> Fixes: 1958b5fc4010 ("x86/boot: Add early boot support when running with SEV active")
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Kairui Song <kasong@redhat.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/boot/compressed/mem_encrypt.S | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> index eaa843a52907..a480356e0ed8 100644
> --- a/arch/x86/boot/compressed/mem_encrypt.S
> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> @@ -25,20 +25,6 @@ ENTRY(get_sev_encryption_bit)
>  	push	%ebx
>  	push	%ecx
>  	push	%edx
> -	push	%edi
> -
> -	/*
> -	 * RIP-relative addressing is needed to access the encryption bit
> -	 * variable. Since we are running in 32-bit mode we need this call/pop
> -	 * sequence to get the proper relative addressing.
> -	 */
> -	call	1f
> -1:	popl	%edi
> -	subl	$1b, %edi
> -
> -	movl	enc_bit(%edi), %eax
> -	cmpl	$0, %eax
> -	jge	.Lsev_exit
>  
>  	/* Check if running under a hypervisor */
>  	movl	$1, %eax
> @@ -69,15 +55,12 @@ ENTRY(get_sev_encryption_bit)
>  
>  	movl	%ebx, %eax
>  	andl	$0x3f, %eax		/* Return the encryption bit location */
> -	movl	%eax, enc_bit(%edi)
>  	jmp	.Lsev_exit
>  
>  .Lno_sev:
>  	xor	%eax, %eax
> -	movl	%eax, enc_bit(%edi)
>  
>  .Lsev_exit:
> -	pop	%edi
>  	pop	%edx
>  	pop	%ecx
>  	pop	%ebx
> @@ -113,8 +96,6 @@ ENTRY(set_sev_encryption_mask)
>  ENDPROC(set_sev_encryption_mask)
>  
>  	.data
> -enc_bit:
> -	.int	0xffffffff
>  
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  	.balign	8
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
