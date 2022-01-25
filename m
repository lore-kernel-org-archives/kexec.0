From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 25 Jan 2022 12:15:56 -0800
Subject: [PATCH v5 3/6] kexec_file: Don't opencode appended signature
 verification.
In-Reply-To: <7834eb187ef67cd88fc67f10e831130e3717d776.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
 <7834eb187ef67cd88fc67f10e831130e3717d776.1641900831.git.msuchanek@suse.de>
Message-ID: <YfBafIXgnLzf0QMb@bombadil.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Jan 11, 2022 at 12:37:45PM +0100, Michal Suchanek wrote:
> diff --git a/include/linux/verification.h b/include/linux/verification.h
> index a655923335ae..32db9287a7b0 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -60,5 +60,8 @@ extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
>  				   enum key_being_used_for usage);
>  #endif
>  
> +int verify_appended_signature(const void *data, unsigned long *len,
> +			      struct key *trusted_keys, const char *what);
> +

Looks very non-module specific.

> diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> index 8723ae70ea1f..30149969f21f 100644
> --- a/kernel/module_signing.c
> +++ b/kernel/module_signing.c
> @@ -14,32 +14,38 @@
>  #include <crypto/public_key.h>
>  #include "module-internal.h"
>  
> -/*
> - * Verify the signature on a module.
> +/**
> + * verify_appended_signature - Verify the signature on a module with the
> + * signature marker stripped.
> + * @data: The data to be verified
> + * @len: Size of @data.
> + * @trusted_keys: Keyring to use for verification
> + * @what: Informational string for log messages
>   */
> -int mod_verify_sig(const void *mod, struct load_info *info)
> +int verify_appended_signature(const void *data, unsigned long *len,
> +			      struct key *trusted_keys, const char *what)
>  {
> -	struct module_signature ms;
> -	size_t sig_len, modlen = info->len;
> +	struct module_signature *ms;

There goes the abstraction, so why not make this clear where we re-use
the struct module_signature for various things and call it as it is,
verify_mod_appended_signature() or some such?

David? Any preference?

Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

