Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dfdND-0004BP-AW
 for kexec@lists.infradead.org; Thu, 10 Aug 2017 02:39:00 +0000
Date: Thu, 10 Aug 2017 10:28:34 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [V2] kexec_file: use crypto_free_shash to free memory
Message-ID: <20170810022834.GA2345@x1>
References: <1502278201-14562-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1502278201-14562-1-git-send-email-bianpan2016@163.com>
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
To: Pan Bian <bianpan2016@163.com>, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On 08/09/17 at 07:30pm, Pan Bian wrote:
> In function kexec_calculate_store_digests(), kfree() is used to free
> memory allocated by crypto_alloc_shash(). It is better to use function
> crypto_free_shash(), which frees up tfm and any resources associated with
> it. And then, the refcount of the algorithm used in crypto_alloc_shash()
> is also dropped.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Makes sense to call the crypto alloc/free api in pairs.

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 9f48f44..94eeb38 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -627,7 +627,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  out_free_desc:
>  	kfree(desc);
>  out_free_tfm:
> -	kfree(tfm);
> +	crypto_free_shash(tfm);
>  out:
>  	return ret;
>  }
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
