Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3e9Q-0006Zt-Vb
 for kexec@lists.infradead.org; Thu, 06 Aug 2020 11:33:38 +0000
Date: Thu, 6 Aug 2020 19:33:15 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv2] x86/purgatory: don't generate debug info for
 purgatory.ro
Message-ID: <20200806113315.GA2492@dhcp-128-65.nay.redhat.com>
References: <1596433788-3784-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1596433788-3784-1-git-send-email-kernelfans@gmail.com>
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
Cc: Steve Wahl <steve.wahl@hpe.com>, kexec@lists.infradead.org, x86@kernel.org, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Arvind Sankar <nivedita@alum.mit.edu>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On 08/03/20 at 01:49pm, Pingfan Liu wrote:
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
> ---
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
> @@ -64,6 +64,9 @@ CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)
>  CFLAGS_REMOVE_string.o		+= $(PURGATORY_CFLAGS_REMOVE)
>  CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
>  
> +AFLAGS_REMOVE_setup-x86_$(BITS).o	+= -Wa,-gdwarf-2
> +AFLAGS_REMOVE_entry64.o			+= -Wa,-gdwarf-2
> +
>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
>  		$(call if_changed,ld)
>  
> -- 
> 2.7.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

Hi Pingfan,

Looks good, thanks for the patch.

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
