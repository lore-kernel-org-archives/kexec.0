Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aRNhM-0006C8-7b
 for kexec@lists.infradead.org; Thu, 04 Feb 2016 17:28:04 +0000
Received: by mail-io0-x236.google.com with SMTP id g73so100660490ioe.3
 for <kexec@lists.infradead.org>; Thu, 04 Feb 2016 09:27:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454526390-19792-6-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-6-git-send-email-zohar@linux.vnet.ibm.com>
Date: Thu, 4 Feb 2016 09:27:43 -0800
Message-ID: <CAGXu5jJwZzYm5ZEMRmypg7auJaPsRS4GM2ES9uGQj81LFqQrQQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/22] firmware: move completing fw into a helper
From: Kees Cook <keescook@chromium.org>
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
Cc: Rusty Russell <rusty@rustcorp.com.au>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, Feb 3, 2016 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@kernel.org>
>
> This will be re-used later through a new extensible interface.
>
> Reviewed-by: Josh Boyer <jwboyer@fedoraproject.org>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/base/firmware_class.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
> index 3358f5d..fb64814 100644
> --- a/drivers/base/firmware_class.c
> +++ b/drivers/base/firmware_class.c
> @@ -322,6 +322,15 @@ fail:
>         return rc;
>  }
>
> +static void fw_finish_direct_load(struct device *device,
> +                                 struct firmware_buf *buf)
> +{
> +       mutex_lock(&fw_lock);
> +       set_bit(FW_STATUS_DONE, &buf->status);
> +       complete_all(&buf->completion);
> +       mutex_unlock(&fw_lock);
> +}
> +
>  static int fw_get_filesystem_firmware(struct device *device,
>                                        struct firmware_buf *buf)
>  {
> @@ -363,10 +372,7 @@ static int fw_get_filesystem_firmware(struct device *device,
>         if (!rc) {
>                 dev_dbg(device, "direct-loading %s\n",
>                         buf->fw_id);
> -               mutex_lock(&fw_lock);
> -               set_bit(FW_STATUS_DONE, &buf->status);
> -               complete_all(&buf->completion);
> -               mutex_unlock(&fw_lock);
> +               fw_finish_direct_load(device, buf);
>         }
>
>         return rc;
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS & Brillo Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
