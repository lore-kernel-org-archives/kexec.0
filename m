Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXJkG-0005Ad-Uh
 for kexec@lists.infradead.org; Thu, 13 Dec 2018 05:41:15 +0000
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so634745ljh.13
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 21:41:01 -0800 (PST)
MIME-Version: 1.0
References: <1544654224.18411.11.camel@lca.pw>
 <20181213052259.56352-1-cai@lca.pw>
In-Reply-To: <20181213052259.56352-1-cai@lca.pw>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 13 Dec 2018 11:10:47 +0530
Message-ID: <CACi5LpP+NHa1WQg78xm1y1YM0KXnFJ72pw+YrizxR5y7yt4AiQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: invalidate TLB before turning MMU on
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Qian Cai,

On Thu, Dec 13, 2018 at 10:53 AM Qian Cai <cai@lca.pw> wrote:
>
> On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
> dump just hung. It has 4 threads on each core. Each 2-core share a same
> L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
> L3 cache.
>
> It turned out that this was due to the TLB contained stale entries (or
> uninitialized junk which just happened to look valid) from the first
> kernel before turning the MMU on in the second kernel which caused this
> instruction hung,
>
> msr     sctlr_el1, x0
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/kernel/head.S | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4471f570a295..5196f3d729de 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
>         msr     ttbr0_el1, x2                   // load TTBR0
>         msr     ttbr1_el1, x1                   // load TTBR1
>         isb
> +       dsb     nshst
> +       tlbi    vmalle1                         // invalidate TLB
> +       dsb     nsh
> +       isb

This will be executed both for the primary and kdump kernel, right? I
don't think we really want to invalidate the TLB when booting the
primary kernel.
It would be too slow and considering that we need to minimize boot
timings on embedded arm64 devices, I think it would not be a good
idea.

>         msr     sctlr_el1, x0
>         isb
>         /*
> --
> 2.17.2 (Apple Git-113)
>

Also did you check this issue I reported on the HPE apollo machines
some days back with the kdump kernel boot
<https://www.spinics.net/lists/kexec/msg21750.html>.
Can you please confirm that you are not facing the same issue (as I
suspect from reading your earlier Bug Report) on the HPE apollo
machine. Also adding 'earlycon' to the bootargs being passed to the
kdump kernel you can see if you are able to atleast get some console
output from the kdump kernel.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
