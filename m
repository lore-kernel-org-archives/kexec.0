Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 15 Dec 2015 17:15:18 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v12 09/16] arm64/kexec: Add pr_devel output
Message-ID: <20151215171517.GB353@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <0e4d27286ec607b0c1f6e17b3034279c96d6b6a6.1448403503.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0e4d27286ec607b0c1f6e17b3034279c96d6b6a6.1448403503.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org, christoffer.dall@linaro.org

On Tue, Nov 24, 2015 at 10:25:34PM +0000, Geoff Levand wrote:
> To aid in debugging kexec problems or when adding new functionality to kexec add
> a new routine kexec_image_info() and several inline pr_devel statements.

We don't currently have any pr_devel invocations under arm64. Can you
either remove these or change them to pr_debug?

> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/kernel/machine_kexec.c | 63 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 8b990b8..da28a26 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -25,6 +25,48 @@ extern const unsigned long arm64_relocate_new_kernel_size;
>  
>  static unsigned long kimage_start;
>  
> +/**
> + * kexec_is_dtb - Helper routine to check the device tree header signature.
> + */
> +static bool kexec_is_dtb(const void *dtb)
> +{
> +	__be32 magic;
> +
> +	return get_user(magic, (__be32 *)dtb) ? false :
> +		(be32_to_cpu(magic) == OF_DT_HEADER);

Isn't there an fdt32_to_cpu helper for this already? I also can't help
but thing this would be more readable if you didn't bother with the
ternary if form.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
