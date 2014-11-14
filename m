Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-la0-f47.google.com ([209.85.215.47])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XpI5Q-0003BL-3s
 for kexec@lists.infradead.org; Fri, 14 Nov 2014 14:42:56 +0000
Received: by mail-la0-f47.google.com with SMTP id gd6so14783940lab.20
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 06:42:33 -0800 (PST)
Message-ID: <546614D7.8080401@cogentembedded.com>
Date: Fri, 14 Nov 2014 17:42:31 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Subject: Re: [PATCH 7/8] arm64/kexec: Add checks for KVM and EFI
References: <cover.1415926876.git.geoff@infradead.org>
 <b7b2f48822a563bafe2888d7ac8e863731159796.1415926876.git.geoff@infradead.org>
In-Reply-To: <b7b2f48822a563bafe2888d7ac8e863731159796.1415926876.git.geoff@infradead.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: marc.zyngier@arm.com, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org

Hello.

On 11/14/2014 4:22 AM, Geoff Levand wrote:

> Add runtime checks that fail the arm64 kexec syscall for situations that would
> result in system instability do to problems in the KVM and EFI kernel support.
> These checks should be removed when the KVM and EFI problems are fixed.

> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>   arch/arm64/kernel/machine_kexec.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 775bcc3..5b62bd1f 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -16,6 +16,12 @@
>   #include <asm/cacheflush.h>
>   #include <asm/system_misc.h>

> +/* TODO: Remove this include when KVM can support a kexc reboot. */

    s/kexc/kexec/ here and below.

> +#include <asm/virt.h>
> +
> +/* TODO: Remove this include when EFI can support a kexc reboot. */
> +#include <linux/efi.h>
> +
>   /* Global variables for the relocate_kernel routine. */
>   extern const unsigned char relocate_new_kernel[];
>   extern const unsigned long relocate_new_kernel_size;
> @@ -101,6 +107,22 @@ int machine_kexec_prepare(struct kimage *image)
>
>   	kexec_image_info(image);
>
> +	/* TODO: Remove this message when KVM can support a kexc reboot. */
> +	if (IS_ENABLED(CONFIG_KVM) && is_hyp_mode_available()) {
> +		pr_err("%s: Your kernel is configued with KVM support "

    Configured.

> +			"(CONFIG_KVM=y) which currently does not allow for "
> +			"kexec re-boot.\n", __func__);
> +		return -ENOSYS;
> +	}
> +
> +	/* TODO: Remove this message when EFI can support a kexc reboot. */
> +	if (efi_enabled(EFI_BOOT)) {
> +		pr_err("%s: Your kernel is using the Extensible Firmware "
> +			"Interface (EFI) which currently does not allow for "
> +			"kexec re-boot.\n", __func__);
> +		return -ENOSYS;
> +	}
> +
>   	return 0;
>   }

WBR, Sergei


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
