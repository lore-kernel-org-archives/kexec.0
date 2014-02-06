Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBJQb-0006EU-Sn
 for kexec@lists.infradead.org; Thu, 06 Feb 2014 07:31:18 +0000
Date: Thu, 6 Feb 2014 16:30:49 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] zImage_ppc64_probe: return 0 instead of 1 in case of
 success
Message-ID: <20140206073049.GE24865@verge.net.au>
References: <1391668244-13631-1-git-send-email-dyoung@redhat.com>
 <1391668244-13631-2-git-send-email-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1391668244-13631-2-git-send-email-dyoung@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org

On Thu, Feb 06, 2014 at 02:30:43PM +0800, Dave Young wrote:
> All other _probe functions return 0 for probing the kernel
> image successfully, so there's no reason to return 1 here.
> 
> Fix it to return 0 instead.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Thanks, applied.

> ---
>  kexec/arch/ppc64/kexec-zImage-ppc64.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/ppc64/kexec-zImage-ppc64.c b/kexec/arch/ppc64/kexec-zImage-ppc64.c
> index 24a87c6..d084ee5 100644
> --- a/kexec/arch/ppc64/kexec-zImage-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-zImage-ppc64.c
> @@ -36,6 +36,7 @@
>  int zImage_ppc64_probe(FILE *file)
>  {
>  	Elf32_Ehdr elf;
> +	int valid;
>  
>  	if (fseek(file, 0, SEEK_SET) < 0) {
>  		fprintf(stderr, "seek error: %s\n",
> @@ -53,7 +54,7 @@ int zImage_ppc64_probe(FILE *file)
>  		return -1;
>  	}
>  
> -	return (elf.e_ident[EI_MAG0]  == ELFMAG0        &&
> +	valid = (elf.e_ident[EI_MAG0]  == ELFMAG0        &&
>  		elf.e_ident[EI_MAG1]  == ELFMAG1        &&
>  		elf.e_ident[EI_MAG2]  == ELFMAG2        &&
>  		elf.e_ident[EI_MAG3]  == ELFMAG3        &&
> @@ -61,6 +62,8 @@ int zImage_ppc64_probe(FILE *file)
>  		elf.e_ident[EI_DATA]  == ELFDATA2MSB &&
>  		elf.e_type            == ET_EXEC        &&
>  		elf.e_machine         == EM_PPC);
> +
> +	return valid ? 0 : -1;
>  }
>  
>  int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
> -- 
> 1.8.3.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
