Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr710082.outbound.protection.outlook.com
 ([40.107.71.82] helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g4oPu-0000E4-5U
 for kexec@lists.infradead.org; Tue, 25 Sep 2018 14:34:24 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Date: Tue, 25 Sep 2018 14:33:48 +0000
Message-ID: <6e15796e-31e9-2dc6-4a31-5c1b01554b45@amd.com>
References: <20180925111020.23834-1-kasong@redhat.com>
In-Reply-To: <20180925111020.23834-1-kasong@redhat.com>
Content-Language: en-US
Content-ID: <CF965B29EA876340B16CB7BC6D31989D@namprd12.prod.outlook.com>
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
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, "dyoung@redhat.com" <dyoung@redhat.com>

On 09/25/2018 06:10 AM, Kairui Song wrote:
> Commit 1958b5fc4010 ("x86/boot: Add early boot support when running
> with SEV active") is causing kexec becomes sometimes unstable, kexec
> reboot won't start a second kernel bypassing BIOS boot process, instead,
> the system got reset.
> 
> That's because, in get_sev_encryption_bit function, we are using
> 32-bit RIP-relative addressing to read the value of enc_bit, but
> kexec may alloc the early boot up code to a higher location, which
> is beyond 32-bit addressing limit. Some garbage will be read and
> get_sev_encryption_bit will return the wrong value, which lead to
> wrong memory page flag.
> 
> This patch adds a get_sev_encryption_bit_64 function to avoid this
> problem. 64-bit early boot code will use this function instead, it
> uses native RIP addressing to read the enc_bit which have no problem
> with any location.
> 
> Fixes: 1958b5fc4010 ("x86/boot: Add early boot support when running with SEV active")
> Signed-off-by: Kairui Song <kasong@redhat.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/boot/compressed/mem_encrypt.S | 64 ++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> index eaa843a52907..41933550449a 100644
> --- a/arch/x86/boot/compressed/mem_encrypt.S
> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> @@ -18,27 +18,13 @@
>  
>  	.text
>  	.code32
> -ENTRY(get_sev_encryption_bit)
> +do_get_sev_encryption_bit:
>  	xor	%eax, %eax
>  
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
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
> @@ -69,25 +55,65 @@ ENTRY(get_sev_encryption_bit)
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
>  
> +#endif	/* CONFIG_AMD_MEM_ENCRYPT */
> +
> +	ret
> +
> +ENTRY(get_sev_encryption_bit)
> +	xor	%eax, %eax
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	push	%edi
> +
> +	/*
> +	 * RIP-relative addressing is needed to access the encryption bit
> +	 * variable. Since we are running in 32-bit mode we need this call/pop
> +	 * sequence to get the proper relative addressing.
> +	 */
> +	call	1f
> +1:	popl	%edi
> +	subl	$1b, %edi
> +
> +	movl	enc_bit(%edi), %eax
> +	cmpl	$0, %eax
> +	jge 2f
> +
> +	call    do_get_sev_encryption_bit
> +	movl	%eax, enc_bit(%edi)
> +2:
> +	pop	%edi
>  #endif	/* CONFIG_AMD_MEM_ENCRYPT */
>  
>  	ret
>  ENDPROC(get_sev_encryption_bit)
>  
>  	.code64
> +ENTRY(get_sev_encryption_bit_64)
> +	xor	%rax, %rax
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	movl	enc_bit(%rip), %eax
> +	cmpl	$0, %eax
> +	jge 1f
> +
> +	call    do_get_sev_encryption_bit
> +	movl	%eax, enc_bit(%rip)
> +1:
> +#endif	/* CONFIG_AMD_MEM_ENCRYPT */
> +
> +	ret
> +ENDPROC(get_sev_encryption_bit_64)
> +
>  ENTRY(set_sev_encryption_mask)
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  	push	%rbp
> @@ -95,7 +121,7 @@ ENTRY(set_sev_encryption_mask)
>  
>  	movq	%rsp, %rbp		/* Save current stack pointer */
>  
> -	call	get_sev_encryption_bit	/* Get the encryption bit position */
> +	call	get_sev_encryption_bit_64	/* Get the encryption bit position */
>  	testl	%eax, %eax
>  	jz	.Lno_sev_mask
>  
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
