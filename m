Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1hlVq4-0000FE-7D
 for kexec@lists.infradead.org; Thu, 11 Jul 2019 09:58:12 +0000
Date: Thu, 11 Jul 2019 11:58:01 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] kexec/kexec-zlib.h: Add 'is_zlib_file()' helper
 function
Message-ID: <20190711095800.i6flfrcdidw2t6la@verge.net.au>
References: <1562788469-22935-1-git-send-email-bhsharma@redhat.com>
 <1562788469-22935-4-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1562788469-22935-4-git-send-email-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: takahiro.akashi@linaro.org, bhupesh.linux@gmail.com, kexec@lists.infradead.org

On Thu, Jul 11, 2019 at 01:24:28AM +0530, Bhupesh Sharma wrote:
> This patch adds 'is_zlib_file()' helper function which can be
> used to quickly determine with the passed kernel image is a zlib
> compressed kernel image.
> 
> This is specifically useful for arm64 zImage (or Image.gz) support,
> which is introduced by later patches in this patchset.
> 
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  kexec/kexec-zlib.h |  1 +
>  kexec/zlib.c       | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/kexec/kexec-zlib.h b/kexec/kexec-zlib.h
> index 43c107bf4a72..16300f294759 100644
> --- a/kexec/kexec-zlib.h
> +++ b/kexec/kexec-zlib.h
> @@ -6,5 +6,6 @@
>  
>  #include "config.h"
>  
> +int is_zlib_file(const char *filename, off_t *r_size);
>  char *zlib_decompress_file(const char *filename, off_t *r_size);
>  #endif /* __KEXEC_ZLIB_H */
> diff --git a/kexec/zlib.c b/kexec/zlib.c
> index 95b608059d41..34d5ca566769 100644
> --- a/kexec/zlib.c
> +++ b/kexec/zlib.c
> @@ -23,6 +23,32 @@ static void _gzerror(gzFile fp, int *errnum, const char **errmsg)
>  	}
>  }
>  
> +int is_zlib_file(const char *filename, off_t *r_size)
> +{
> +	gzFile fp;
> +	int errnum;
> +	const char *msg;
> +
> +	if (!filename)
> +		goto out;
> +
> +	fp = gzopen(filename, "rb");

Does fp need to be closed somewhere to avoid a leak?

> +	if (fp == 0) {
> +		_gzerror(fp, &errnum, &msg);
> +		dbgprintf("Cannot open `%s': %s\n", filename, msg);
> +		goto out;
> +	}
> +
> +	if (gzdirect(fp))
> +		/* It's not in gzip format */
> +		goto out;
> +
> +	/* It's in gzip format */
> +	return 1;
> +out:
> +	return 0;
> +}
> +
>  char *zlib_decompress_file(const char *filename, off_t *r_size)
>  {
>  	gzFile fp;
> @@ -84,6 +110,12 @@ fail:
>  	return buf;
>  }
>  #else
> +
> +int is_zlib_file(const char *filename, off_t *r_size)
> +{
> +	return 0;
> +}
> +
>  char *zlib_decompress_file(const char *UNUSED(filename), off_t *UNUSED(r_size))
>  {
>  	return NULL;
> -- 
> 2.7.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
