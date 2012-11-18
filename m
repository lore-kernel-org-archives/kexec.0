Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZyd3-0001EG-Pn
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 06:45:18 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
 <50A86563.30303@zytor.com> <876253sej9.fsf@xmission.com>
 <CAE9FiQVfRHpoBoUyZssfE32wv7j3fD2skRL4UFXP=FBq7rrE1w@mail.gmail.com>
 <878v9zqyfh.fsf@xmission.com>
 <306ab84f-139c-47e2-8790-eb7b4b45c261@email.android.com>
Date: Sat, 17 Nov 2012 22:44:52 -0800
In-Reply-To: <306ab84f-139c-47e2-8790-eb7b4b45c261@email.android.com>
 (H. Peter Anvin's message of "Sat, 17 Nov 2012 22:23:16 -0800")
Message-ID: <87pq3bpfyz.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] add mem64_min/max control
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

"H. Peter Anvin" <hpa@zytor.com> writes:

> I think you just need one of the PIC models, or the medium model.

-fPIC has the unfortunate tendency to require a global offset table
 and still have relocations against .data so it is usually easier to
 avoid it.

That said it looks like what is left is to modify the .S files to
contain 64bit relocations or actuall position independent code.

Is there any easy way to write position independent 32bit code that will
load all of the registers, and jump to known address? 

This is what the code does right now.

	.code32
	/* load the data segments */
	movl	$0x18, %eax	/* data segment */
	movl	%eax, %ds
	movl	%eax, %es
	movl	%eax, %ss
	movl	%eax, %fs
	movl	%eax, %gs

	/* Load the registers */
	movl	eax, %eax
	movl	ecx, %ecx
	movl	edx, %edx
	movl	esi, %esi
	movl	edi, %edi
	movl	esp, %esp
	movl	ebp, %ebp
	movl	ebx, %ebx

	/* Jump to the loaded image */
	jmpl	*(eip)

	.section ".rodata"
	.balign 4
entry32_regs:  
eax:	.long 0x00000000
ebx:	.long 0x00000000
ecx:	.long 0x00000000
edx:	.long 0x00000000
esi:	.long 0x00000000
edi:	.long 0x00000000
esp:	.long 0x00000000
ebp:	.long 0x00000000
eip:	.long entry16
	.size entry32_regs, . - entry32_regs

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
