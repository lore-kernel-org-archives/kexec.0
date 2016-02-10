Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-x241.google.com ([2a00:1450:4010:c04::241])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTauX-0006YR-2Q
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 19:58:49 +0000
Received: by mail-lb0-x241.google.com with SMTP id e10so1319020lbb.1
 for <kexec@lists.infradead.org>; Wed, 10 Feb 2016 11:58:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454526390-19792-11-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-11-git-send-email-zohar@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 21:58:27 +0200
Message-ID: <CACE9dm9uTYHP1+9K2mo-F=8Z9KQzTBAZGm3-mwG2_YeyfV4xVA@mail.gmail.com>
Subject: Re: [PATCH v3 10/22] ima: calculate the hash of a buffer using
 aynchronous hash(ahash)
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, Feb 3, 2016 at 9:06 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Setting up ahash has some overhead.  Only use ahash to calculate the
> hash of a buffer, if the buffer is larger than ima_ahash_minsize.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>

> ---
>  security/integrity/ima/ima_crypto.c | 75 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index fccb6ce..38f2ed8 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -519,6 +519,63 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
>         return rc;
>  }
>
> +static int calc_buffer_ahash_atfm(const void *buf, loff_t len,
> +                                 struct ima_digest_data *hash,
> +                                 struct crypto_ahash *tfm)
> +{
> +       struct ahash_request *req;
> +       struct scatterlist sg;
> +       struct ahash_completion res;
> +       int rc, ahash_rc = 0;
> +
> +       hash->length = crypto_ahash_digestsize(tfm);
> +
> +       req = ahash_request_alloc(tfm, GFP_KERNEL);
> +       if (!req)
> +               return -ENOMEM;
> +
> +       init_completion(&res.completion);
> +       ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
> +                                  CRYPTO_TFM_REQ_MAY_SLEEP,
> +                                  ahash_complete, &res);
> +
> +       rc = ahash_wait(crypto_ahash_init(req), &res);
> +       if (rc)
> +               goto out;
> +
> +       sg_init_one(&sg, buf, len);
> +       ahash_request_set_crypt(req, &sg, NULL, len);
> +
> +       ahash_rc = crypto_ahash_update(req);
> +
> +       /* wait for the update request to complete */
> +       rc = ahash_wait(ahash_rc, &res);
> +       if (!rc) {
> +               ahash_request_set_crypt(req, NULL, hash->digest, 0);
> +               rc = ahash_wait(crypto_ahash_final(req), &res);
> +       }
> +out:
> +       ahash_request_free(req);
> +       return rc;
> +}
> +
> +static int calc_buffer_ahash(const void *buf, loff_t len,
> +                            struct ima_digest_data *hash)
> +{
> +       struct crypto_ahash *tfm;
> +       int rc;
> +
> +       tfm = ima_alloc_atfm(hash->algo);
> +       if (IS_ERR(tfm))
> +               return PTR_ERR(tfm);
> +
> +       rc = calc_buffer_ahash_atfm(buf, len, hash, tfm);
> +
> +       ima_free_atfm(tfm);
> +
> +       return rc;
> +}
> +
>  static int calc_buffer_shash_tfm(const void *buf, loff_t size,
>                                 struct ima_digest_data *hash,
>                                 struct crypto_shash *tfm)
> @@ -550,8 +607,8 @@ static int calc_buffer_shash_tfm(const void *buf, loff_t size,
>         return rc;
>  }
>
> -int ima_calc_buffer_hash(const void *buf, loff_t len,
> -                        struct ima_digest_data *hash)
> +static int calc_buffer_shash(const void *buf, loff_t len,
> +                            struct ima_digest_data *hash)
>  {
>         struct crypto_shash *tfm;
>         int rc;
> @@ -566,6 +623,20 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
>         return rc;
>  }
>
> +int ima_calc_buffer_hash(const void *buf, loff_t len,
> +                        struct ima_digest_data *hash)
> +{
> +       int rc;
> +
> +       if (ima_ahash_minsize && len >= ima_ahash_minsize) {
> +               rc = calc_buffer_ahash(buf, len, hash);
> +               if (!rc)
> +                       return 0;
> +       }
> +
> +       return calc_buffer_shash(buf, len, hash);
> +}
> +
>  static void __init ima_pcrread(int idx, u8 *pcr)
>  {
>         if (!ima_used_chip)
> --
> 2.1.0
>



-- 
Thanks,
Dmitry

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
