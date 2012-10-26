Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TRaON-0003KK-83
 for kexec@lists.infradead.org; Fri, 26 Oct 2012 03:15:28 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20121025205408.GB17995@redhat.com>
Date: Thu, 25 Oct 2012 20:14:58 -0700
In-Reply-To: <20121025205408.GB17995@redhat.com> (Vivek Goyal's message of
 "Thu, 25 Oct 2012 16:54:08 -0400")
Message-ID: <87lietq5zh.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: Query regarding x86_64 purgatory and IA32-e compatibility mode
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Vivek Goyal <vgoyal@redhat.com> writes:

> Hi Eric,
>
> I am reading up x86_64 purgatory code to understand how transition to
> 32bit protected mode happens.
>
> My understanding is that we enter in purgatory_start (setup-x86_64.S).
> Then we jump to entry64 in entry64.S.
>
> We run following code in arch/x86_64/entry64.S
>
>         movq    $stack_init, %rsp
>         pushq   $0x10 /* CS */
>         pushq   $new_cs_exit
>         lretq
> new_cs_exit:
>
>         /* Load the registers */
>         movq    rax(%rip), %rax
>         movq    rbx(%rip), %rbx
>         movq    rcx(%rip), %rcx
>         movq    rdx(%rip), %rdx
>         movq    rsi(%rip), %rsi
>         movq    rdi(%rip), %rdi
>         movq    rsp(%rip), %rsp
>         movq    rbp(%rip), %rbp
>         movq    r8(%rip), %r8
>         movq    r9(%rip), %r9
>         movq    r10(%rip), %r10
>         movq    r11(%rip), %r11
>         movq    r12(%rip), %r12
>         movq    r13(%rip), %r13
>         movq    r14(%rip), %r14
>         movq    r15(%rip), %r15
>
> Will above lretq call not switch us in compatibility mode (from 64bit
> mode)? We have taken a long jump and our new CS seems to have L bit 
> 0.


> Following is our gdt.
>
> gdt:    /* 0x00 unusable segment 
>          * 0x08 unused
>          * so use them as the gdt ptr
>          */
>         .word   gdt_end - gdt - 1
>         .quad   gdt
>         .word   0, 0, 0
>
>         /* 0x10 4GB flat code segment */
>         .word   0xFFFF, 0x0000, 0x9A00, 0x00AF
>
>         /* 0x18 4GB flat data segment */
>         .word   0xFFFF, 0x0000, 0x9200, 0x00CF
> gdt_end:
>
> I see that bit 21  in second doubleword is 0. IIUC, that means that we
> will switch to compatibility mode. If yes, we are still continuing to
> use 64bit instructions and continue to access registers (rip, r8-15)
> which are available in 64bit mode only. Is this correct? How does this
> work?

         /* 0x10 4GB flat code segment */
        .word   0xFFFF, 0x0000, 0x9A00, 0x00AF

The high 16bits of that are:
31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16
 0  0  0  0  0  0  0  0  1  0  1  0  1  1  1  1

Since L is bit 21 I read that as L=1.

I don't know how you see L=1 there.

The transition happens in entry64-32.S
We get there via:
	jmp	*rip(%rip)

The default value of rip is entry32.

That is where we clear bit 21 in 
	ljmp	*lm_exit_addr(%rip)

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
