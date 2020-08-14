Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]
 helo=smtprelay.hostedemail.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Ss5-0000pa-QA
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 06:07:23 +0000
Message-ID: <d1414df440b872ab7792946725991cb948537654.camel@perches.com>
Subject: Re: [PATCH] kexec: Delete an unnecessary comparison
From: Joe Perches <joe@perches.com>
Date: Thu, 13 Aug 2020 23:07:16 -0700
In-Reply-To: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
References: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
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
To: Youling Tang <tangyouling@loongson.cn>, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, 2020-08-13 at 20:45 +0800, Youling Tang wrote:
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

If you really want to change the function, then
you could change a couple of breaks to gotos,
remove multiple unnecessary tests, and unindent
a block of code too.

---
 kernel/kexec_file.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ca40bef75a61..34a025e85887 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -763,7 +763,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
-			break;
+			goto out_free_digest;
 
 		/*
 		 * Assume rest of the buffer is filled with zero and
@@ -777,32 +777,26 @@ static int kexec_calculate_store_digests(struct kimage *image)
 				bytes = zero_buf_sz;
 			ret = crypto_shash_update(desc, zero_buf, bytes);
 			if (ret)
-				break;
+				goto out_free_digest;
 			nullsz -= bytes;
 		}
 
-		if (ret)
-			break;
-
 		sha_regions[j].start = ksegment->mem;
 		sha_regions[j].len = ksegment->memsz;
 		j++;
 	}
 
-	if (!ret) {
-		ret = crypto_shash_final(desc, digest);
-		if (ret)
-			goto out_free_digest;
-		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
-						     sha_regions, sha_region_sz, 0);
-		if (ret)
-			goto out_free_digest;
+	ret = crypto_shash_final(desc, digest);
+	if (ret)
+		goto out_free_digest;
 
-		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
-						     digest, SHA256_DIGEST_SIZE, 0);
-		if (ret)
-			goto out_free_digest;
-	}
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
+					     sha_regions, sha_region_sz, 0);
+	if (ret)
+		goto out_free_digest;
+
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
+					     digest, SHA256_DIGEST_SIZE, 0);
 
 out_free_digest:
 	kfree(digest);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
