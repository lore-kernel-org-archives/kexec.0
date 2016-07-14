Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNWEu-0004T4-6T
 for kexec@lists.infradead.org; Thu, 14 Jul 2016 02:19:00 +0000
Date: Thu, 14 Jul 2016 10:18:34 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [V2][PATCH 2/2] pefile: Fix the failure of calculation for digest
Message-ID: <20160714021834.GC3798@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1468416937-21237-2-git-send-email-jia.zhang@windriver.com>
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
To: Lans Zhang <jia.zhang@windriver.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, kexec@lists.infradead.org, dhowells@redhat.com, linux-crypto@vger.kernel.org, vgoyal@redhat.com

Cc crypto list

On 07/13/16 at 09:35pm, Lans Zhang wrote:
> The commit e68503bd68 forgot to set digest_len and thus cause the following
> error reported by kexec when launching a crash kernel:
> "kexec_file_load failed: Bad message"
> 
> Fixes: e68503bd68 (KEYS: Generalise system_verify_data() to provide access to internal content)
> Signed-off-by: Lans Zhang <jia.zhang@windriver.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> ---
>  crypto/asymmetric_keys/mscode_parser.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
> index 6a76d5c..9492e1c 100644
> --- a/crypto/asymmetric_keys/mscode_parser.c
> +++ b/crypto/asymmetric_keys/mscode_parser.c
> @@ -124,5 +124,10 @@ int mscode_note_digest(void *context, size_t hdrlen,
>  	struct pefile_context *ctx = context;
>  
>  	ctx->digest = kmemdup(value, vlen, GFP_KERNEL);
> -	return ctx->digest ? 0 : -ENOMEM;
> +	if (!ctx->digest)
> +		return -ENOMEM;
> +
> +	ctx->digest_len = vlen;
> +
> +	return 0;
>  }
> -- 
> 1.9.1
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
