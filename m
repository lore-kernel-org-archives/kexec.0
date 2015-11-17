Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zyk4c-0002NG-Rl
 for kexec@lists.infradead.org; Tue, 17 Nov 2015 17:29:44 +0000
Date: Tue, 17 Nov 2015 09:29:18 -0800
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] kexex: arm: create ATAGS_MEM tag from devicetree
 memory node
Message-ID: <20151117172918.GE23979@verge.net.au>
References: <1447678615-16987-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1447678615-16987-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
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
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>, kexec@lists.infradead.org

On Mon, Nov 16, 2015 at 01:56:54PM +0100, Andreas Fenkart wrote:
> From: Andreas Fenkart <afenkart@gmail.com>
> 
> booting a non-devicetree kernel from a devicetree kernel failed,
> since the memory layout wasn't passed.

Nice catch.

> Signed-off-by: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>
> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 43 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index ff4e38d..f460ba7 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -4,6 +4,7 @@
>   */
>  #define _GNU_SOURCE
>  #define _XOPEN_SOURCE
> +#include <assert.h>
>  #include <stdio.h>
>  #include <string.h>
>  #include <stdlib.h>
> @@ -139,6 +140,42 @@ struct tag * atag_read_tags(void)
>  	return (struct tag *) buf;
>  }
>  
> +static
> +int create_mem32_tag(struct tag_mem32 *tag_mem32)
> +{
> +	const char fn[]= "/proc/device-tree/memory/reg";
> +	FILE *fp;
> +	uint32_t tmp[2];
> +	int ret = 0;
> +
> +	assert(tag_mem32);

I think the assertion here is unnecessary. Could you remove it?

> +	fp = fopen(fn, "r");
> +	if (!fp) {
> +		ret = errno;
> +		fprintf(stderr, "Cannot open %s: %m\n", fn);
> +		return ret;

I think that returning -1 for error and 0 for success would
be both consistent with the rest of the source in the same file
and result in slightly simpler code.

> +	}
> +
> +	if (!fread(tmp, sizeof(tmp[0]), 2, fp)) {
> +		ret = ENOENT;
> +		fprintf(stderr, "Short read %s\n", fn);
> +		goto out;
> +	}
> +
> +	if (ferror(fp)) {
> +		ret = errno;
> +		fprintf(stderr, "Cannot read %s: %m\n", fn);
> +		goto out;
> +	}
> +
> +	/* atags_mem32 has base/size fields reversed! */
> +	tag_mem32->size = be32_to_cpu(tmp[1]);
> +	tag_mem32->start = be32_to_cpu(tmp[0]);
> +
> +out:
> +	fclose(fp);
> +	return ret;
> +}
>  
>  static
>  int atag_arm_load(struct kexec_info *info, unsigned long base,
> @@ -182,6 +219,12 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
>  		params->hdr.size = 2;
>  		params->hdr.tag = ATAG_CORE;
>  		params = tag_next(params);
> +
> +		if (!create_mem32_tag(&params->u.mem)) {
> +			params->hdr.size = 4;
> +			params->hdr.tag = ATAG_MEM;
> +			params = tag_next(params);
> +		}
>  	}
>  
>  	if (initrd) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
