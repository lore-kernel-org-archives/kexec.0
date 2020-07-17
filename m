Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwVkX-0007hS-Mk
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 19:10:27 +0000
Received: by mail-wr1-x443.google.com with SMTP id z15so12184742wrl.8
 for <kexec@lists.infradead.org>; Fri, 17 Jul 2020 12:10:25 -0700 (PDT)
Subject: Re: [PATCH 03/13] fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED
 enum
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-4-keescook@chromium.org>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <8ee5f0f1-8eae-510a-a3bb-7420a3fca001@broadcom.com>
Date: Fri, 17 Jul 2020 12:10:15 -0700
MIME-Version: 1.0
In-Reply-To: <20200717174309.1164575-4-keescook@chromium.org>
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, KP Singh <kpsingh@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-integrity@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>



On 2020-07-17 10:42 a.m., Kees Cook wrote:
> The "FIRMWARE_EFI_EMBEDDED" enum is a "where", not a "what". It
> should not be distinguished separately from just "FIRMWARE", as this
> confuses the LSMs about what is being loaded. Additionally, there was
> no actual validation of the firmware contents happening.
>
> Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firmware_request_platform()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
> To aid in backporting, this change is made before moving
> kernel_read_file() to separate header/source files.
> ---
>   drivers/base/firmware_loader/fallback_platform.c | 2 +-
>   include/linux/fs.h                               | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
> index 685edb7dd05a..6958ab1a8059 100644
> --- a/drivers/base/firmware_loader/fallback_platform.c
> +++ b/drivers/base/firmware_loader/fallback_platform.c
> @@ -17,7 +17,7 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
>   	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
>   		return -ENOENT;
>   
> -	rc = security_kernel_load_data(LOADING_FIRMWARE_EFI_EMBEDDED);
> +	rc = security_kernel_load_data(LOADING_FIRMWARE);
>   	if (rc)
>   		return rc;
>   
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 95fc775ed937..f50a35d54a61 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2993,11 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
>   #endif
>   extern int do_pipe_flags(int *, int);
>   
> -/* This is a list of *what* is being read, not *how*. */
> +/* This is a list of *what* is being read, not *how* nor *where*. */
>   #define __kernel_read_file_id(id) \
>   	id(UNKNOWN, unknown)		\
>   	id(FIRMWARE, firmware)		\
> -	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
>   	id(MODULE, kernel-module)		\
>   	id(KEXEC_IMAGE, kexec-image)		\
>   	id(KEXEC_INITRAMFS, kexec-initramfs)	\


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
