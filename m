Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g57RW-0007Bl-Pw
 for kexec@lists.infradead.org; Wed, 26 Sep 2018 10:53:20 +0000
Received: by mail-lf1-f68.google.com with SMTP id w21-v6so8815642lff.6
 for <kexec@lists.infradead.org>; Wed, 26 Sep 2018 03:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180925111020.23834-1-kasong@redhat.com>
 <6e15796e-31e9-2dc6-4a31-5c1b01554b45@amd.com>
 <20180925172608.GB15464@zn.tnic> <20180926073252.GC2555@MiWiFi-R3L-srv>
In-Reply-To: <20180926073252.GC2555@MiWiFi-R3L-srv>
From: Kairui Song <kasong@redhat.com>
Date: Wed, 26 Sep 2018 18:52:33 +0800
Message-ID: <CACPcB9efDdBGnU53wRLw8uP0fzLcq0c2O8V3z=8xW_DMSOUtYw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
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
To: Thomas.Lendacky@amd.com
Cc: brijesh.singh@amd.com, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, bp@suse.de, Dave Young <dyoung@redhat.com>

On Wed, Sep 26, 2018 at 3:33 PM Baoquan He <bhe@redhat.com> wrote:
>
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
>
> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> index eaa843a52907..0b60eb867d25 100644
> --- a/arch/x86/boot/compressed/mem_encrypt.S
> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> @@ -27,19 +27,6 @@ ENTRY(get_sev_encryption_bit)
>         push    %edx
>         push    %edi
>
> -       /*
> -        * RIP-relative addressing is needed to access the encryption bit
> -        * variable. Since we are running in 32-bit mode we need this call/pop
> -        * sequence to get the proper relative addressing.
> -        */
> -       call    1f
> -1:     popl    %edi
> -       subl    $1b, %edi
> -
> -       movl    enc_bit(%edi), %eax
> -       cmpl    $0, %eax
> -       jge     .Lsev_exit
> -
>         /* Check if running under a hypervisor */
>         movl    $1, %eax
>         cpuid
> @@ -69,12 +56,10 @@ ENTRY(get_sev_encryption_bit)
>
>         movl    %ebx, %eax
>         andl    $0x3f, %eax             /* Return the encryption bit location */
> -       movl    %eax, enc_bit(%edi)
>         jmp     .Lsev_exit
>
>  .Lno_sev:
>         xor     %eax, %eax
> -       movl    %eax, enc_bit(%edi)
>
>  .Lsev_exit:
>         pop     %edi
> @@ -113,9 +98,6 @@ ENTRY(set_sev_encryption_mask)
>  ENDPROC(set_sev_encryption_mask)
>
>         .data
> -enc_bit:
> -       .int    0xffffffff
> -
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>         .balign 8
>  GLOBAL(sme_me_mask)

That is much cleaner indeed, I'm not sure if enc_bit have any other
usage, if not we can just drop it for sure.

Hi Thomas, can you help confirm if enc_bit is only a cache to avoid
doing the cpuid stuff?

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
