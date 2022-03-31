From: Baoquan He <bhe@redhat.com>
Date: Thu, 31 Mar 2022 19:22:43 +0800
Subject: [PATCH] kexec: Remove redundant assignments
In-Reply-To: <20220326180948.192154-1-michalorzel.eng@gmail.com>
References: <20220326180948.192154-1-michalorzel.eng@gmail.com>
Message-ID: <YkWPA0XDEMq1NVcr@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 03/26/22 at 07:09pm, Michal Orzel wrote:
> Get rid of redundant assignments which end up in values not being
> read either because they are overwritten or the function ends.
> 
> Reported by clang-tidy [deadcode.DeadStores]
> 
> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
> ---
>  kernel/kexec_core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 68480f731192..d08904a27362 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -768,7 +768,6 @@ static struct page *kimage_alloc_page(struct kimage *image,
>  				kimage_free_pages(old_page);
>  				continue;
>  			}
> -			addr = old_addr;
>  			page = old_page;
>  			break;
>  		}
> @@ -788,7 +787,6 @@ static int kimage_load_normal_segment(struct kimage *image,
>  	unsigned char __user *buf = NULL;
>  	unsigned char *kbuf = NULL;
>  
> -	result = 0;
>  	if (image->file_mode)
>  		kbuf = segment->kbuf;
>  	else

LGTM, thx

Acked-by: Baoquan He <bhe@redhat.com>


