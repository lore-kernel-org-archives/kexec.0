Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20210531095720.77469-1-maz@kernel.org>
 <20210531095720.77469-2-maz@kernel.org>
In-Reply-To: <20210531095720.77469-2-maz@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 31 May 2021 21:37:49 +0200
Message-ID: <CAMj1kXFNUAtXPzO+EbMzZQPxgst4BMEUuYbrWwYer3P9trYdLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: kexec_file: Forbid non-crash kernels
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
To: Marc Zyngier <maz@kernel.org>
Cc: kexec@lists.infradead.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh SHARMA <bhupesh.sharma@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Moritz Fischer <mdf@kernel.org>, Android Kernel Team <kernel-team@android.com>, "# 3.4.x" <stable@vger.kernel.org>

On Mon, 31 May 2021 at 11:57, Marc Zyngier <maz@kernel.org> wrote:
>
> It has been reported that kexec_file doesn't really work on arm64.
> It completely ignores any of the existing reservations, which results
> in the secondary kernel being loaded where the GICv3 LPI tables live,
> or even corrupting the ACPI tables.
>
> Since only crash kernels are imune to this as they use a reserved
> memory region, disable the non-crash kernel use case. Further
> patches will try and restore the functionality.
>
> Reported-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org # 5.10

Acked-by: Ard Biesheuvel <ardb@kernel.org>

... but do we really only need this in 5.10 and not earlier?

> ---
>  arch/arm64/kernel/kexec_image.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 9ec34690e255..acf9cd251307 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -145,3 +145,23 @@ const struct kexec_file_ops kexec_image_ops = {
>         .verify_sig = image_verify_sig,
>  #endif
>  };
> +
> +/**
> + * arch_kexec_locate_mem_hole - Find free memory to place the segments.
> + * @kbuf:                       Parameters for the memory search.
> + *
> + * On success, kbuf->mem will have the start address of the memory region found.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> +{
> +       /*
> +        * For the time being, kexec_file_load isn't reliable except
> +        * for crash kernel. Say sorry to the user.
> +        */
> +       if (kbuf->image->type != KEXEC_TYPE_CRASH)
> +               return -EADDRNOTAVAIL;
> +
> +       return kexec_locate_mem_hole(kbuf);
> +}
> --
> 2.30.2
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
