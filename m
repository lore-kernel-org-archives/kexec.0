Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pfepa.post.tele.dk ([195.41.46.235])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2KZI-0000kT-FG
	for kexec@lists.infradead.org; Fri, 08 May 2009 07:32:47 +0000
Date: Fri, 8 May 2009 09:34:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 02/14] x86,
	boot: honor CONFIG_PHYSICAL_START when relocatable
Message-ID: <20090508073436.GB12808@uranus.ravnborg.org>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-3-git-send-email-hpa@linux.intel.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1241735222-6640-3-git-send-email-hpa@linux.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, tglx@linutronix.de, vgoyal@redhat.com

On Thu, May 07, 2009 at 03:26:50PM -0700, H. Peter Anvin wrote:
> From: H. Peter Anvin <hpa@zytor.com>
> 
> Currently, when building a relocatable kernel, CONFIG_PHYSICAL_START
> is ignored.  This is undesirable, as we would like to keep the kernel
> out of ZONE_DMA and away from the possible memory hole at 15 MB (which
> some vendors for some bizarre reason still have.)
> 
> With this patch, CONFIG_PHYSICAL_START is considered the *minimum*
> address at which the kernel can be located; a relocating bootloader
> can locate it higher, but not lower.  This also restores the
> originally intended behavior that CONFIG_RELOCATABLE is functionally a
> noop if used with a non-relocating bootloader.
> 
> This patch also change movsb and stosb to movsl, stosl and stosq, to
> shave a small fraction off the boot time.

On the coding style side of thing...
> +     movl %ebp, %ebx
> +     cmpl %ebx, %eax
> +     jbe 1f
> +     movl %eax, %ebx

This looks messy with different idention of the operand.

Compare it to this:
> +	movl	%ebp, %ebx
> +	cmpl	%ebx, %eax
> +	jbe	1f
> +	movl	%eax, %ebx


I like the latter more with vertical alignment of the operand.
I see that you add spaces around operators (,) - good.



>   */
>  
>  #ifdef CONFIG_RELOCATABLE
> -	movl 	%ebp, %ebx
> -	addl    $(CONFIG_PHYSICAL_ALIGN - 1), %ebx
> -	andl    $(~(CONFIG_PHYSICAL_ALIGN - 1)), %ebx
> +	movl $LOAD_PHYSICAL_ADDR, %eax
> +	movl %ebp, %ebx
> +	cmpl %ebx, %eax
> +	jbe 1f
> +	movl %eax, %ebx
> +1:
> +	addl $(CONFIG_PHYSICAL_ALIGN - 1), %ebx
> +	andl $(~(CONFIG_PHYSICAL_ALIGN - 1)), %ebx
>  #else
>  	movl $LOAD_PHYSICAL_ADDR, %ebx
>  #endif
> +	movl %ebx, %edi		/* Save kernel target address */
>  
>  	/* Replace the compressed data size with the uncompressed size */
>  	subl input_len(%ebp), %ebx
> @@ -84,27 +90,30 @@ ENTRY(startup_32)
>  	addl $4095, %ebx
>  	andl $~4095, %ebx

Not part of your patch...
But this is most likely (PAGE_SIZE - 1) so it would be better to write so.


>  
> -/* Copy the compressed kernel to the end of our buffer
> +/*
> + * Set up the stack
> + */
> +	leal boot_stack_end(%ebx), %esp
> +	pushl %edi		/* Saved kernel target address */
> +
> +/*
> + * Copy the compressed kernel to the end of our buffer
>   * where decompression in place becomes safe.
>   */
>  	pushl %esi
> -	leal _ebss(%ebp), %esi
> -	leal _ebss(%ebx), %edi
> -	movl $(_ebss - startup_32), %ecx
> +	leal (_bss-4)(%ebp), %esi
> +	leal (_bss-4)(%ebx), %edi
> +	movl $(_bss - startup_32), %ecx
> +	shrl $2, %ecx

I do not see why you mess around with _bss here?
Do you use .bss for decompression?


Note: I do not speak x86 assembler so I have not tried to
      understand the functionality.

      I tired to grasp the changes around clear bss - but faild :-(

	Sam

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
