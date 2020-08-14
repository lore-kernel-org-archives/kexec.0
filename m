Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Scp-0007MI-A9
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 05:51:36 +0000
Date: Fri, 14 Aug 2020 13:51:19 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec: Delete an unnecessary comparison
Message-ID: <20200814055119.GA17263@dhcp-128-65.nay.redhat.com>
References: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
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
To: Youling Tang <tangyouling@loongson.cn>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org

On 08/13/20 at 08:45pm, Youling Tang wrote:
> Regardless of whether the ret value is zero or non-zero, the trajectory
> of the program execution is the same, so there is no need to compare.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  kernel/kexec_file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 78c0837..3ad0ae2 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -800,8 +800,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
>  						     digest, SHA256_DIGEST_SIZE, 0);
> -		if (ret)
> -			goto out_free_digest;
>  	}
>  
>  out_free_digest:
> -- 
> 2.1.0
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
