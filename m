Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0QKc-0006Pw-9z
 for kexec@lists.infradead.org; Tue, 28 Jul 2020 14:11:51 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RESEND PATCH v5 08/11] ppc64/kexec_file: setup backup region for
 kdump kernel
In-Reply-To: <159579235754.5790.5203600072984600891.stgit@hbathini>
References: <159579157320.5790.6748078824637688685.stgit@hbathini>
 <159579235754.5790.5203600072984600891.stgit@hbathini>
Date: Wed, 29 Jul 2020 00:11:43 +1000
Message-ID: <87y2n36868.fsf@mpe.ellerman.id.au>
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
To: Hari Bathini <hbathini@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hari Bathini <hbathini@linux.ibm.com> writes:
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index a5c1442590b2..88408b17a7f6 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -697,6 +699,69 @@ static int update_usable_mem_fdt(void *fdt, struct crash_mem *usable_mem)
>  	return ret;
>  }
>  
> +/**
> + * load_backup_segment - Locate a memory hole to place the backup region.
> + * @image:               Kexec image.
> + * @kbuf:                Buffer contents and memory parameters.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int load_backup_segment(struct kimage *image, struct kexec_buf *kbuf)
> +{
> +	void *buf;
> +	int ret;
> +
> +	/* Setup a segment for backup region */
> +	buf = vzalloc(BACKUP_SRC_SIZE);

This worried me initially, because we can't copy from physically
discontiguous pages in real mode.

But as you explained this buffer is not used for copying.

I think if you move the large comment below up here, it would be
clearer.


> diff --git a/arch/powerpc/purgatory/trampoline_64.S b/arch/powerpc/purgatory/trampoline_64.S
> index 464af8e8a4cb..d4b52961f592 100644
> --- a/arch/powerpc/purgatory/trampoline_64.S
> +++ b/arch/powerpc/purgatory/trampoline_64.S
> @@ -43,14 +44,38 @@ master:
>  	mr	%r17,%r3	/* save cpu id to r17 */
>  	mr	%r15,%r4	/* save physical address in reg15 */
>  
> +	bl	0f		/* Work out where we're running */
> +0:	mflr	%r18

I know you just moved it, but this should use:

	bcl	20, 31, $+4
	mflr	%r18

Which is a special form of branch and link that doesn't unbalance the
link stack in the chip.

> +	/*
> +	 * Copy BACKUP_SRC_SIZE bytes from BACKUP_SRC_START to
> +	 * backup_start 8 bytes at a time.
> +	 *
> +	 * Use r3 = dest, r4 = src, r5 = size, r6 = count
> +	 */
> +	ld	%r3,(backup_start - 0b)(%r18)
> +	cmpdi	%cr0,%r3,0

I prefer spaces or tabs between arguments, eg:

	cmpdi	%cr0, %r3, 0

> +	beq	80f		/* skip if there is no backup region */

Local labels will make this clearer I think. eg:

	beq	.Lskip_copy

> +	lis	%r5,BACKUP_SRC_SIZE@h
> +	ori	%r5,%r5,BACKUP_SRC_SIZE@l
> +	cmpdi	%cr0,%r5,0
> +	beq	80f		/* skip if copy size is zero */
> +	lis	%r4,BACKUP_SRC_START@h
> +	ori	%r4,%r4,BACKUP_SRC_START@l
> +	li	%r6,0
> +70:

.Lcopy_loop:

> +	ldx	%r0,%r6,%r4
> +	stdx	%r0,%r6,%r3
> +	addi	%r6,%r6,8
> +	cmpld	%cr0,%r6,%r5
> +	blt	70b

	blt	.Lcopy_loop

> +

.Lskip_copy:

> +80:
>  	or	%r3,%r3,%r3	/* ok now to high priority, lets boot */
>  	lis	%r6,0x1
>  	mtctr	%r6		/* delay a bit for slaves to catch up */
>  	bdnz	.		/* before we overwrite 0-100 again */


cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
