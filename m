Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WpsML-0001sL-6B
 for kexec@lists.infradead.org; Thu, 29 May 2014 04:54:33 +0000
Received: by mail-pa0-f44.google.com with SMTP id lj1so376488pab.3
 for <kexec@lists.infradead.org>; Wed, 28 May 2014 21:54:09 -0700 (PDT)
Message-ID: <5386BD6A.7020509@linaro.org>
Date: Thu, 29 May 2014 13:54:02 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND] ARM: kdump: 2nd kernel should use strict pfn_valid
 in SPARSEMEM platform
References: <1401266668-34365-1-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1401266668-34365-1-git-send-email-wangnan0@huawei.com>
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
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Wang Nan <wangnan0@huawei.com>, Russell King <linux@arm.linux.org.uk>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Geng Hui <hui.geng@huawei.com>, Simon Horman <horms@verge.net.au>, linux-arm-kernel@lists.infradead.org

Catalin, Will

Can we assume that HAVE_ARCH_PFN_VALID is alway yes on arm64?
Looking at arm64/Kconfig,
config ARCH_HAS_HOLES_MEMORYMODEL
	def_bool y if SPARSEMEM
...
config HAVE_ARCH_PFN_VALID
	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM

is this intentional?

-Takahiro AKASHI

On 05/28/2014 05:44 PM, Wang Nan wrote:
> This patch removes an irrational limitation for crash dump kernel on ARM
> platform with SPARSEMEM enabled.
>
> Without this patch, crash reservation area for a crash dump kernel with
> SPARSEMEM selected must occupy a full section plus 1MiB. If not,
> elfcorehdr and some memory space used by the first kernel will unable to
> get accessed. This is caused by pfn_valid: fast pfn_valid ragards any
> pfn in a valid section as valid and prevents it to be ioremapped.
>
> This limitation wastes memory, because sections are always large and
> crash dump kernel should be as small as possible.
>
> This patch selects HAVE_ARCH_PFN_VALID for CRASH_DUMP, makes crash dump
> kernel to use strict version of pfn_valid().
>
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> ---
>
> This is the third time I post this patch. The previous records can be
> retrived from:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256498.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/257472.html
>
> Different from previous version, this patch select HAVE_ARCH_PFN_VALID
> right after CRASH_DUMP config entry.
>
> ---
>
>   arch/arm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c57ddcb..d5ffbb1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2160,6 +2160,7 @@ config ATAGS_PROC
>
>   config CRASH_DUMP
>   	bool "Build kdump crash kernel (EXPERIMENTAL)"
> +	select HAVE_ARCH_PFN_VALID if SPARSEMEM
>   	help
>   	  Generate crash dump after being started by kexec. This should
>   	  be normally only set in special crash dump kernels which are
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
