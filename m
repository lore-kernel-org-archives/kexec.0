Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <5768147E.1050900@arm.com>
Date: Mon, 20 Jun 2016 17:06:22 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v19 05/13] arm64/kexec: Add pr_debug output
References: <cover.1466120418.git.geoff@infradead.org>
 <dd245cadf97ea0d8fd5b0fe5743ecf9fa512d3c0.1466120418.git.geoff@infradead.org>
In-Reply-To: <dd245cadf97ea0d8fd5b0fe5743ecf9fa512d3c0.1466120418.git.geoff@infradead.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Geoff,

On 17/06/16 00:48, Geoff Levand wrote:
> To aid in debugging kexec problems or when adding new functionality to
> kexec add a new routine kexec_image_info() and several inline pr_debug
> statements.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index a6dcb9c..7372e58 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/kexec.h>
>  #include <linux/smp.h>
> +#include <linux/uaccess.h>

Now that the get_user(maybe_dtb_addr,.. has gone, I don't think we need this header.

>  
>  #include <asm/cacheflush.h>
>  #include <asm/cpu_ops.h>


Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
