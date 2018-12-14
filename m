Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXfcA-0001Dd-1O
 for kexec@lists.infradead.org; Fri, 14 Dec 2018 05:02:21 +0000
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so3799310lja.5
 for <kexec@lists.infradead.org>; Thu, 13 Dec 2018 21:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20181213052259.56352-1-cai@lca.pw>
 <20181214040819.58625-1-cai@lca.pw>
In-Reply-To: <20181214040819.58625-1-cai@lca.pw>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 14 Dec 2018 10:31:52 +0530
Message-ID: <CACi5LpNQ1WGE54uv35OwNmJkKR_xnqTNqFK+R9oFBVkb683z_Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
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
To: cai@lca.pw
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, kexec mailing list <kexec@lists.infradead.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Fri, Dec 14, 2018 at 9:39 AM Qian Cai <cai@lca.pw> wrote:
>
> On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
> dump just hung. It has 4 threads on each core. Each 2-core share a same
> L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
> L3 cache.
>
> It turned out that this was due to the TLB contained stale entries (or
> uninitialized junk which just happened to look valid) before turning the
> MMU on in the second kernel which caused this instruction hung,
>
> msr     sctlr_el1, x0
>
> Although there is a local TLB flush in the second kernel in
> __cpu_setup(), it is called too early. When the time to turn the MMU on
> later, the TLB is dirty again from some reasons.
>
> Also tried to move the local TLB flush part around a bit inside
> __cpu_setup(), although it did complete kdump some times, it did trigger
> "Synchronous Exception" in EFI after a cold-reboot fairly often that
> seems no way to recover remotely without reinstalling the OS. For
> example, in those places,
>
> ENTRY(__cpu_setup)
> +       isb
>         tlbi    vmalle1
>         dsb     nsh
>
> or
>
>         mov     x0, #3 << 20
>         msr     cpacr_el1, x0
> +       tlbi    vmalle1
> +       dsb     nsh
>
> Since it is only necessary to flush local TLB right before turning the
> MMU on, just re-arrage the part a bit like the one in __primary_switch()
> within CONFIG_RANDOMIZE_BASE path, so it does not depends on other
> instructions in between that could pollute the TLB, and it no longer
> trigger "Synchronous Exception" as well.
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>
> v2: merge the similar part from __cpu_setup() pointed out by James.
>
>  arch/arm64/kernel/head.S | 4 ++++
>  arch/arm64/mm/proc.S     | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4471f570a295..7f555dd4577e 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
>         msr     ttbr0_el1, x2                   // load TTBR0
>         msr     ttbr1_el1, x1                   // load TTBR1
>         isb
> +
> +       tlbi    vmalle1                         // invalidate TLB
> +       dsb     nsh
> +
>         msr     sctlr_el1, x0
>         isb
>         /*
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 2c75b0b903ae..14f68afdd57f 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -406,9 +406,6 @@ ENDPROC(idmap_kpti_install_ng_mappings)
>   */
>         .pushsection ".idmap.text", "awx"
>  ENTRY(__cpu_setup)
> -       tlbi    vmalle1                         // Invalidate local TLB
> -       dsb     nsh
> -
>         mov     x0, #3 << 20
>         msr     cpacr_el1, x0                   // Enable FP/ASIMD
>         mov     x0, #1 << 12                    // Reset mdscr_el1 and disable
> --
> 2.17.2 (Apple Git-113)
>

Not sure why I can't reproduce on my HPE Apollo machine, so a couple
of questions:
1. How many CPUs do you enable in the kdump kernel - do you pass
'nr_cpus=1' to the kdump kernel to limit the maximum number of cores
to 1 in the kdump kernel?
2. Which firmware version do you use on your board?

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
