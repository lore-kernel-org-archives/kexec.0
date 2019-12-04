Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icbL9-000687-BE
 for kexec@lists.infradead.org; Wed, 04 Dec 2019 20:33:40 +0000
Received: by mail-pl1-f197.google.com with SMTP id 66so262193plc.22
 for <kexec@lists.infradead.org>; Wed, 04 Dec 2019 12:33:34 -0800 (PST)
Subject: Re: [PATCH v2 1/3] libfdt: define UINT32_MAX in libfdt_env.h
References: <20191114051510.17037-1-takahiro.akashi@linaro.org>
 <20191114051510.17037-2-takahiro.akashi@linaro.org>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <aa35893d-fadc-be2a-1295-a986ced017fe@redhat.com>
Date: Thu, 5 Dec 2019 02:03:27 +0530
MIME-Version: 1.0
In-Reply-To: <20191114051510.17037-2-takahiro.akashi@linaro.org>
Content-Language: en-US
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com
Cc: james.morse@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Akashi,

On 11/14/2019 10:45 AM, AKASHI Takahiro wrote:
> In the implementation of kexec_file_load-based kdump for arm64,
> fdt_appendprop_addrrange() will be used, but fdt_addresses.c
> will fail to compile due to missing UINT32_MAX.
> 
> So just define it in libfdt_env.h.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> ---
>   include/linux/libfdt_env.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
> index edb0f0c30904..9ca00f11d9b1 100644
> --- a/include/linux/libfdt_env.h
> +++ b/include/linux/libfdt_env.h
> @@ -3,6 +3,7 @@
>   #define LIBFDT_ENV_H
>   
>   #include <linux/kernel.h>	/* For INT_MAX */
> +#include <linux/limits.h>	/* For UINT32_MAX */
>   #include <linux/string.h>
>   
>   #include <asm/byteorder.h>
> @@ -11,6 +12,8 @@ typedef __be16 fdt16_t;
>   typedef __be32 fdt32_t;
>   typedef __be64 fdt64_t;
>   
> +#define UINT32_MAX U32_MAX
> +
>   #define fdt32_to_cpu(x) be32_to_cpu(x)
>   #define cpu_to_fdt32(x) cpu_to_be32(x)
>   #define fdt64_to_cpu(x) be64_to_cpu(x)
> 

With following upstream patches accepted already in Linus's tree (see 
[0] and [1]), so we can drop this patch from the v3:

[0] 26ed19adbab1 ("libfdt: reduce the number of headers included from 
libfdt_env.h")
[1] a8de1304b7df ("libfdt: define INT32_MAX and UINT32_MAX in libfdt_env.h")

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
