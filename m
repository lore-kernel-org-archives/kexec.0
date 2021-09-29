Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 29 Sep 2021 17:24:28 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/2] arm64: kexec_file: use more system keyrings to
 verify kernel image signature
Message-ID: <20210929162428.GG22029@willie-the-truck>
References: <20210927005004.36367-1-coiby.xu@gmail.com>
 <20210927005004.36367-3-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210927005004.36367-3-coiby.xu@gmail.com>
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
To: Coiby Xu <coiby.xu@gmail.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Coiby Xu <coxu@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, open list <linux-kernel@vger.kernel.org>

On Mon, Sep 27, 2021 at 08:50:04AM +0800, Coiby Xu wrote:
> From: Coiby Xu <coxu@redhat.com>
> 
> This allows to verify arm64 kernel image signature using not only
> .builtin_trusted_keys but also .secondary_trusted_keys and .platform keyring.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  arch/arm64/kernel/kexec_image.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 9ec34690e255..2357ee2f229a 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -14,7 +14,6 @@
>  #include <linux/kexec.h>
>  #include <linux/pe.h>
>  #include <linux/string.h>
> -#include <linux/verification.h>
>  #include <asm/byteorder.h>
>  #include <asm/cpufeature.h>
>  #include <asm/image.h>
> @@ -133,8 +132,7 @@ static void *image_load(struct kimage *image,
>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
>  static int image_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	return verify_pefile_signature(kernel, kernel_len, NULL,
> -				       VERIFYING_KEXEC_PE_SIGNATURE);
> +	return arch_kexec_kernel_verify_pe_sig(kernel, kernel_len);

I'm fine with this in principle, but it looks like the first patch is the
important one.

So for the arm64 bit:

Acked-by: Will Deacon <will@kernel.org>

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
