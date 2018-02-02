Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ehgAj-000414-T5
 for kexec@lists.infradead.org; Fri, 02 Feb 2018 18:34:51 +0000
Received: from [192.168.86.209] (c-67-165-203-88.hsd1.co.comcast.net
 [67.165.203.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sgoel@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F87C60285
 for <kexec@lists.infradead.org>; Fri,  2 Feb 2018 18:34:38 +0000 (UTC)
Subject: Re: [PATCH] arm64: fix an issue with kaslr-enabled vmlinux
References: <20170824073249.18056-1-takahiro.akashi@linaro.org>
From: "Goel, Sameer" <sgoel@codeaurora.org>
Message-ID: <6a9d6bc2-ff57-5aa9-fb6a-ab7b0102d0a1@codeaurora.org>
Date: Fri, 2 Feb 2018 11:34:37 -0700
MIME-Version: 1.0
In-Reply-To: <20170824073249.18056-1-takahiro.akashi@linaro.org>
Content-Language: en-US
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
To: kexec@lists.infradead.org

I tested this fix and it works well. I am wondering which kexec tool release will pick this fix?

On 8/24/2017 1:32 AM, AKASHI Takahiro wrote:
> Normally vmlinux for arm64 is of ET_EXEC type, while if built with
> CONFIG_RANDAMIZE_BASE (that is KASLR), it will be of ET_DYN type.
> Meanwhile, physical address field of segments in vmlinux has actually
> the same value as virtual address field.
> 
> Accordingly, in this case, it totally makes no sense to check for
> validity of segments against physical memory ranges and, if necessary,
> relocate them in elf_exec_load() on arm64.
> 
> This patch allows to unconditionally skip the check on arm64.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  include/elf.h          | 3 ++-
>  kexec/kexec-elf-exec.c | 6 +++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/elf.h b/include/elf.h
> index 5db637b..b7677a2 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -258,7 +258,8 @@ typedef struct
>  #define EM_OPENRISC	92		/* OpenRISC 32-bit embedded processor */
>  #define EM_ARC_A5	93		/* ARC Cores Tangent-A5 */
>  #define EM_XTENSA	94		/* Tensilica Xtensa Architecture */
> -#define EM_NUM		95
> +#define EM_AARCH64	183		/* ARM AARCH64 */
> +#define EM_NUM		184
>  
>  /* If it is necessary to assign new unofficial EM_* values, please
>     pick large random numbers (0x8523, 0xa7f2, etc.) to minimize the
> diff --git a/kexec/kexec-elf-exec.c b/kexec/kexec-elf-exec.c
> index cb62d04..a9329ac 100644
> --- a/kexec/kexec-elf-exec.c
> +++ b/kexec/kexec-elf-exec.c
> @@ -63,9 +63,13 @@ int elf_exec_load(struct mem_ehdr *ehdr, struct kexec_info *info)
>  
>  	/* If I have a dynamic executable find it's size
>  	 * and then find a location for it in memory.
> +	 * Note on arm64:
> +	 * arm64's vmlinux has virtual address in physical address
> +	 * field of PT_LOAD segments. So the following validity check
> +	 * and relocation makes no sense on arm64.
>  	 */
>  	base = 0;
> -	if (ehdr->e_type == ET_DYN) {
> +	if ((ehdr->e_machine != EM_AARCH64) && (ehdr->e_type == ET_DYN)) {
>  		unsigned long first, last, align;
>  		first = ULONG_MAX;
>  		last  = 0;
> 

-- 
 Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
