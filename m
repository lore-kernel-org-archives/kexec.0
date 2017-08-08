Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1df91v-0000zw-EA
 for kexec@lists.infradead.org; Tue, 08 Aug 2017 18:15:01 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1502195440-3600-1-git-send-email-bianpan2016@163.com>
Date: Tue, 08 Aug 2017 13:05:16 -0500
In-Reply-To: <1502195440-3600-1-git-send-email-bianpan2016@163.com> (Pan
 Bian's message of "Tue, 8 Aug 2017 20:30:40 +0800")
Message-ID: <87bmnqey03.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: kexec_file: use crypto_free_shash to free memory
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
To: Pan Bian <bianpan2016@163.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Pan Bian <bianpan2016@163.com> writes:

> In function kexec_calculate_store_digests(), kfree() is used to free
> memory allocated by crypto_alloc_shash(). It is better to use function
> crypto_free_shash(), which also zeroizes the memory to be freed.

Why is it important to zero memory?  There is nothing sensitive being
stored or hashed.  The hash is used for integrity checking purposes.

If the argument is that kfree is simply the wrong frunction for freeing
something allocating with crypto_alloc_shash() I can believe that.  In
which case that sounds like something that needs to be fixed.  But I am
concerned that wasn't your argument and you are talking about something
that appears to be completely irrelevant.

Eric

> Signed-off-by: Pan Bian <bianpan2016@163.com>
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
