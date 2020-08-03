Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2e0m-00063f-7o
 for kexec@lists.infradead.org; Mon, 03 Aug 2020 17:12:33 +0000
Received: by mail-pl1-x642.google.com with SMTP id g19so8508143plq.0
 for <kexec@lists.infradead.org>; Mon, 03 Aug 2020 10:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <1596433788-3784-1-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1596433788-3784-1-git-send-email-kernelfans@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 3 Aug 2020 10:12:16 -0700
Message-ID: <CAKwvOd=o0fjh3VzdHSon+JYECjyDXO552ppGk1xk5VjsvjNtvg@mail.gmail.com>
Subject: Re: [PATCHv2] x86/purgatory: don't generate debug info for
 purgatory.ro
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
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Arvind Sankar <nivedita@alum.mit.edu>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Sun, Aug 2, 2020 at 10:50 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> Purgatory.ro is a standalone binary that is not linked against the rest of
> the kernel.  Its image is copied into an array that is linked to the
> kernel, and from there kexec relocates it wherever it desires.
>
> Unlike the debug info for vmlinux, which can be used for analyzing crash
> such info is useless in purgatory.ro. And discarding them can save about
> 200K space.
>
> Original:
>   259080  kexec-purgatory.o
> Stripped debug info:
>    29152  kexec-purgatory.o
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> To: x86@kernel.org

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---

Thanks for the patch! One thing that can be handy for reviewers (but
isn't strictly necessary) is to put a comment about what changed since
the previous version below the above^ `---` line.  By putting comments
"below the fold" you can pass along information to the reviewers that
won't wind up in `git log` when committed.  Not strictly necessary,
and less so for smaller patches, but hope this helps.  (No need for a
v3 over that).

>  arch/x86/purgatory/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 088bd76..d24b43a 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -32,7 +32,7 @@ KCOV_INSTRUMENT := n
>  # make up the standalone purgatory.ro
>
>  PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> -PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
> +PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
>  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
>  PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
>
> @@ -64,6 +64,9 @@ CFLAGS_sha256.o                       += $(PURGATORY_CFLAGS)
>  CFLAGS_REMOVE_string.o         += $(PURGATORY_CFLAGS_REMOVE)
>  CFLAGS_string.o                        += $(PURGATORY_CFLAGS)
>
> +AFLAGS_REMOVE_setup-x86_$(BITS).o      += -Wa,-gdwarf-2
> +AFLAGS_REMOVE_entry64.o                        += -Wa,-gdwarf-2
> +
>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>                 $(call if_changed,ld)
>
> --
> 2.7.5
>


-- 
Thanks,
~Nick Desaulniers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
