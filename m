Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XpLnL-0000BV-2z
 for kexec@lists.infradead.org; Fri, 14 Nov 2014 18:40:33 +0000
Received: by mail-lb0-f180.google.com with SMTP id z11so6427802lbi.39
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 10:40:06 -0800 (PST)
Message-ID: <54664C84.1040003@cogentembedded.com>
Date: Fri, 14 Nov 2014 21:40:04 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/8] arm64/kexec: Add checks for KVM and EFI
References: <cover.1415926876.git.geoff@infradead.org>	
 <b7b2f48822a563bafe2888d7ac8e863731159796.1415926876.git.geoff@infradead.org>	
 <546614D7.8080401@cogentembedded.com> <1415989719.15847.121.camel@smoke>
In-Reply-To: <1415989719.15847.121.camel@smoke>
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
To: Geoff Levand <geoff@infradead.org>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, christoffer.dall@linaro.org, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 11/14/2014 09:28 PM, Geoff Levand wrote:

> Add runtime checks that fail the arm64 kexec syscall for situations that would
> result in system instability do to problems in the KVM and EFI kernel support.
> These checks should be removed when the KVM and EFI problems are fixed.

> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> v2: Typo fixes.

>   arch/arm64/kernel/machine_kexec.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 775bcc3..faeb4f1 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
[...]
> @@ -101,6 +107,22 @@ int machine_kexec_prepare(struct kimage *image)
>
>   	kexec_image_info(image);
>
> +	/* TODO: Remove this message when KVM can support a kexec reboot. */
> +	if (IS_ENABLED(CONFIG_KVM) && is_hyp_mode_available()) {
> +		pr_err("%s: Your kernel is configured with KVM support "
> +			"(CONFIG_KVM=y) which currently does not allow for "
> +			"kexec re-boot.\n", __func__);

    Er, failed to notice the first time: you do not need to break up the 
message. This helps finding the messages in the kernel code. If you would have 
run the patch thru scripst/checkpatch.pl you would have gotten the actual 
warnings about that...

[...]

WBR, Sergei


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
