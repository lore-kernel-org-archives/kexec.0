Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 26 Jan 2015 19:19:42 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 7/8] arm64/kexec: Add checks for KVM
Message-ID: <20150126191942.GQ23313@leverpostej>
References: <cover.1421449714.git.geoff@infradead.org>
 <a3353cf2ac47f49c20bbbb88405301cbaa359805.1421449714.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a3353cf2ac47f49c20bbbb88405301cbaa359805.1421449714.git.geoff@infradead.org>
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
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> Add runtime checks that fail the arm64 kexec syscall for situations that would
> result in system instability do to problems in the KVM kernel support.
> These checks should be removed when the KVM problems are resolved fixed.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/kernel/machine_kexec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 3d84759..a36459d 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -16,6 +16,9 @@
>  #include <asm/cacheflush.h>
>  #include <asm/system_misc.h>
>  
> +/* TODO: Remove this include when KVM can support a kexec reboot. */
> +#include <asm/virt.h>
> +
>  /* Global variables for the relocate_kernel routine. */
>  extern const unsigned char relocate_new_kernel[];
>  extern const unsigned long relocate_new_kernel_size;
> @@ -100,6 +103,13 @@ int machine_kexec_prepare(struct kimage *image)
>  
>  	kexec_image_info(image);
>  
> +	/* TODO: Remove this message when KVM can support a kexec reboot. */
> +	if (IS_ENABLED(CONFIG_KVM) && is_hyp_mode_available()) {
> +		pr_err("%s: Your kernel is configured with KVM support (CONFIG_KVM=y) which currently does not allow for kexec re-boot.\n",
> +			__func__);
> +		return -ENOSYS;
> +	}

If you really don't want to implement KVM teardown, surely this should
be at the start of the series, so we don't have a point in the middle
where things may explode in this case?

Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
