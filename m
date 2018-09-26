Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g57u3-0003IO-N4
 for kexec@lists.infradead.org; Wed, 26 Sep 2018 11:22:49 +0000
Date: Wed, 26 Sep 2018 19:22:08 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Message-ID: <20180926112208.GE2555@MiWiFi-R3L-srv>
References: <20180925111020.23834-1-kasong@redhat.com>
 <6e15796e-31e9-2dc6-4a31-5c1b01554b45@amd.com>
 <20180925172608.GB15464@zn.tnic>
 <20180926073252.GC2555@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180926073252.GC2555@MiWiFi-R3L-srv>
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
To: Borislav Petkov <bp@suse.de>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, Kairui Song <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>

On 09/26/18 at 03:32pm, Baoquan He wrote:
> On 09/25/18 at 07:26pm, Borislav Petkov wrote:
> > IINM, the problem can be addressed in a simpler way by getting rid of
> > enc_bit and thus getting rid of the need to do relative addressing of
> > anything and simply doing the whole dance of figuring out the C-bit each
> > time. It probably wouldn't be even measurable...
> 
> Couldn't agree more.
> 
> Obviously enc_bit is redundent here. We only check eax each time,
> removing it can fix the RIP-relative addressing issue in kexec.

OK, in distros CONFIG_AMD_MEM_ENCRYPT=y is set by default usually.
enc_bit can save once in normal boot, then fetch and skip the cpuid
detection in initialize_identity_maps(). However this only speeds up in
amd system with SME, on intel cpu and amd cpu w/o sme, it still needs to
do cpuid twice. Removing it should be not measurable as Boris said.
Not sure if Tom has other concern.

Thanks
Baoquan

> 
> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> index eaa843a52907..0b60eb867d25 100644
> --- a/arch/x86/boot/compressed/mem_encrypt.S
> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> @@ -27,19 +27,6 @@ ENTRY(get_sev_encryption_bit)
>  	push	%edx
>  	push	%edi
>  
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
> -
>  	/* Check if running under a hypervisor */
>  	movl	$1, %eax
>  	cpuid
> @@ -69,12 +56,10 @@ ENTRY(get_sev_encryption_bit)
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
>  	pop	%edi
> @@ -113,9 +98,6 @@ ENTRY(set_sev_encryption_mask)
>  ENDPROC(set_sev_encryption_mask)
>  
>  	.data
> -enc_bit:
> -	.int	0xffffffff
> -
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  	.balign	8
>  GLOBAL(sme_me_mask)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
