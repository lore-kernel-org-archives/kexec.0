From: Baoquan He <bhe@redhat.com>
Date: Mon, 18 Apr 2022 10:11:02 +0800
Subject: [PATCH v6 4/4] kexec, KEYS, s390: Make use of built-in and
 secondary keyring for signature verification
In-Reply-To: <20220414014344.228523-5-coxu@redhat.com>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-5-coxu@redhat.com>
Message-ID: <YlzItpGMPat1BFPq@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/14/22 at 09:43am, Coiby Xu wrote:
> From: Michal Suchanek <msuchanek@suse.de>
> 
> commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> adds support for KEXEC_SIG verification with keys from platform keyring
> but the built-in keys and secondary keyring are not used.
> 
> Add support for the built-in keys and secondary keyring as x86 does.
> 
> Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")

Should Cc stable kernel?

Otherwise, LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: kexec at lists.infradead.org
> Cc: keyrings at vger.kernel.org
> Cc: linux-security-module at vger.kernel.org
> Cc: stable at kernel.org
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
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
> 2.34.1
> 
> 


