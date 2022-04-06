From: joeyli <jlee@suse.com>
Date: Wed, 6 Apr 2022 23:46:38 +0800
Subject: [PATCH 3/4] kexec, KEYS, s390: Make use of built-in and
 secondary keyring for signature verification
In-Reply-To: <9f8b71f368843568d7dd6764f8c8a68b1f3a9bbc.1644953683.git.msuchanek@suse.de>
References: <cover.1644953683.git.msuchanek@suse.de>
 <9f8b71f368843568d7dd6764f8c8a68b1f3a9bbc.1644953683.git.msuchanek@suse.de>
Message-ID: <20220406154623.GN11641@linux-l9pv.suse>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Feb 15, 2022 at 08:39:40PM +0100, Michal Suchanek wrote:
> commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> adds support for KEXEC_SIG verification with keys from platform keyring
> but the built-in keys and secondary keyring are not used.
> 
> Add support for the built-in keys and secondary keyring as x86 does.
> 
> Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: kexec at lists.infradead.org
> Cc: keyrings at vger.kernel.org
> Cc: linux-security-module at vger.kernel.org
> Cc: stable at kernel.org
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

> ---
>  arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 8f43575a4dd3..fc6d5f58debe 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>  	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
>  	struct module_signature *ms;
>  	unsigned long sig_len;
> +	int ret;
>  
>  	/* Skip signature verification when not secure IPLed. */
>  	if (!ipl_secure_flag)
> @@ -65,11 +66,18 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>  		return -EBADMSG;
>  	}
>  
> -	return verify_pkcs7_signature(kernel, kernel_len,
> -				      kernel + kernel_len, sig_len,
> -				      VERIFY_USE_PLATFORM_KEYRING,
> -				      VERIFYING_MODULE_SIGNATURE,
> -				      NULL, NULL);
> +	ret = verify_pkcs7_signature(kernel, kernel_len,
> +				     kernel + kernel_len, sig_len,
> +				     VERIFY_USE_SECONDARY_KEYRING,
> +				     VERIFYING_MODULE_SIGNATURE,
> +				     NULL, NULL);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
> +		ret = verify_pkcs7_signature(kernel, kernel_len,
> +					     kernel + kernel_len, sig_len,
> +					     VERIFY_USE_PLATFORM_KEYRING,
> +					     VERIFYING_MODULE_SIGNATURE,
> +					     NULL, NULL);
> +	return ret;
>  }
>  #endif /* CONFIG_KEXEC_SIG */
>  
> -- 
> 2.31.1


