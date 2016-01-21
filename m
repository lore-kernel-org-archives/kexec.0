Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMF99-0003Vg-7O
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 13:19:32 +0000
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 21 Jan 2016 23:19:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8B2C93578053
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 00:19:05 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0LDIvWa51183662
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 00:19:05 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0LDIW4D018806
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 00:18:33 +1100
Message-ID: <1453382292.9549.136.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 03/11] ima: provide buffer hash calculation function
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 08:18:12 -0500
In-Reply-To: <CACE9dm8nd+zf-GKzdo1xYfedGhKSEtUrS2UrmARf2t+PKYNTgA@mail.gmail.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-4-git-send-email-zohar@linux.vnet.ibm.com>
 <CACE9dm8nd+zf-GKzdo1xYfedGhKSEtUrS2UrmARf2t+PKYNTgA@mail.gmail.com>
Mime-Version: 1.0
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
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Kasatkin <d.kasatkin@samsung.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Tue, 2016-01-19 at 21:26 +0200, Dmitry Kasatkin wrote:
> On Mon, Jan 18, 2016 at 5:11 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > From: Dmitry Kasatkin <d.kasatkin@samsung.com>
> >
> > This patch provides convenient buffer hash calculation function.
> >
> > Changelog:
> > - rewrite to support loff_t sized buffers - Mimi
> >   (based on Fenguang Wu's testing)
> >
> > Signed-off-by: Dmitry Kasatkin <d.kasatkin@samsung.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  security/integrity/ima/ima.h        |  2 ++
> >  security/integrity/ima/ima_crypto.c | 47 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 49 insertions(+)
> >
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index fb8da36..de53631 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -107,6 +107,8 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
> >                            const char *op, struct inode *inode,
> >                            const unsigned char *filename);
> >  int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
> > +int ima_calc_buffer_hash(const void *buf, loff_t len,
> > +                        struct ima_digest_data *hash);
> >  int ima_calc_field_array_hash(struct ima_field_data *field_data,
> >                               struct ima_template_desc *desc, int num_fields,
> >                               struct ima_digest_data *hash);
> > diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> > index fb30ce4..8d86281 100644
> > --- a/security/integrity/ima/ima_crypto.c
> > +++ b/security/integrity/ima/ima_crypto.c
> > @@ -519,6 +519,53 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
> >         return rc;
> >  }
> >
> > +static int calc_buffer_shash_tfm(const void *buf, loff_t size,
> > +                               struct ima_digest_data *hash,
> > +                               struct crypto_shash *tfm)
> > +{
> > +       SHASH_DESC_ON_STACK(shash, tfm);
> > +       unsigned int len;
> > +       loff_t offset = 0;
> > +       int rc;
> > +
> > +       shash->tfm = tfm;
> > +       shash->flags = 0;
> > +
> > +       hash->length = crypto_shash_digestsize(tfm);
> > +
> > +       rc = crypto_shash_init(shash);
> > +       if (rc != 0)
> > +               return rc;
> > +
> > +       len = size < PAGE_SIZE ? size : PAGE_SIZE;
> > +       while (offset < size) {
> > +               rc = crypto_shash_update(shash, buf + offset, len);
> > +               if (rc)
> > +                       break;
> > +               offset += len;
> > +       }
> > +
> 
> Hello Mimi,
> 
> May be this was my earlier patch, but it seems to have a problem of
> accessing beyond end of buffer using the same len.
> When buffer always padded by zeros it is not a problem, but it is a bug.
> 
> This seems to be better version.
> 
>    while (size) {
>                len = size < PAGE_SIZE ? size : PAGE_SIZE;
>                rc = crypto_shash_update(shash, buf, len);
>                if (rc)
>                        break;
>                buf += len;
>                size -= len;
>     }
> 
> Please change my sign-of to: dmitry.kasatkin@huawei.com

Good catch!  I think I unfortunately introduce this bug.  Thank you for
the review!

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
