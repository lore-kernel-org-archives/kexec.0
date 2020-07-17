Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwVib-0007G1-Ce
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 19:08:26 +0000
Received: by mail-wm1-x344.google.com with SMTP id a6so7738662wmm.0
 for <kexec@lists.infradead.org>; Fri, 17 Jul 2020 12:08:25 -0700 (PDT)
Subject: Re: [PATCH 01/13] firmware_loader: EFI firmware loader must handle
 pre-allocated buffer
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-2-keescook@chromium.org>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <d8aa2da5-d678-811a-9c28-b372b5491d4b@broadcom.com>
Date: Fri, 17 Jul 2020 12:08:14 -0700
MIME-Version: 1.0
In-Reply-To: <20200717174309.1164575-2-keescook@chromium.org>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, KP Singh <kpsingh@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-integrity@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>



On 2020-07-17 10:42 a.m., Kees Cook wrote:
> The EFI platform firmware fallback would clobber any pre-allocated
> buffers. Instead, correctly refuse to reallocate when too small (as
> already done in the sysfs fallback), or perform allocation normally
> when needed.
>
> Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firm ware_request_platform()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
> To aid in backporting, this change is made before moving
> kernel_read_file() to separate header/source files.
> ---
>   drivers/base/firmware_loader/fallback_platform.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
> index cdd2c9a9f38a..685edb7dd05a 100644
> --- a/drivers/base/firmware_loader/fallback_platform.c
> +++ b/drivers/base/firmware_loader/fallback_platform.c
> @@ -25,7 +25,10 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
>   	if (rc)
>   		return rc; /* rc == -ENOENT when the fw was not found */
>   
> -	fw_priv->data = vmalloc(size);
> +	if (fw_priv->data && size > fw_priv->allocated_size)
> +		return -ENOMEM;
> +	if (!fw_priv->data)
> +		fw_priv->data = vmalloc(size);
>   	if (!fw_priv->data)
>   		return -ENOMEM;
>   


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
