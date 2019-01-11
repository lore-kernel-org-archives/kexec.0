Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghx5e-0004AG-QJ
 for kexec@lists.infradead.org; Fri, 11 Jan 2019 13:43:16 +0000
Date: Fri, 11 Jan 2019 21:43:03 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
Message-ID: <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
References: <20190109164824.19708-1-kasong@redhat.com>
 <20190109164824.19708-3-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190109164824.19708-3-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: jwboyer@fedoraproject.org, ebiggers@google.com, nayna@linux.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, jmorris@namei.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

On 01/10/19 at 12:48am, Kairui Song wrote:
> kexec_file_load will need to verify the kernel signed with third part
> keys, and the keys could be stored in firmware, then got loaded into
> the .platform keyring. Now we have a .platform_trusted_keyring
> as the reference to .platform keyring, this patch makes use if it and
> allow kexec_file_load to verify the image against keys in .platform
> keyring.
> 
> This commit adds a VERIFY_USE_PLATFORM_KEYRING similar to previous
> VERIFY_USE_SECONDARY_KEYRING indicating that verify_pkcs7_signature
> should verify the signature using platform keyring. Also, decrease
> the error message log level when verification failed with -ENOKEY,
> so that if called tried multiple time with different keyring it
> won't generate extra noises.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
>  certs/system_keyring.c            |  7 ++++++-
>  include/linux/verification.h      |  1 +
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 7d97e432cbbc..a8a5c1773ccc 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -534,9 +534,16 @@ static int bzImage64_cleanup(void *loader_data)
>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	return verify_pefile_signature(kernel, kernel_len,
> -				       VERIFY_USE_SECONDARY_KEYRING,
> -				       VERIFYING_KEXEC_PE_SIGNATURE);
> +	int ret;
> +	ret = verify_pefile_signature(kernel, kernel_len,
> +			VERIFY_USE_SECONDARY_KEYRING,
> +			VERIFYING_KEXEC_PE_SIGNATURE);
> +	if (ret == -ENOKEY) {
> +		ret = verify_pefile_signature(kernel, kernel_len,
> +				VERIFY_USE_PLATFORM_KEYRING,
> +				VERIFYING_KEXEC_PE_SIGNATURE);
> +	}
> +	return ret;
>  }
>  #endif
>  
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index a61b95390b80..7514e69e719f 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -18,6 +18,7 @@
>  #include <linux/verification.h>
>  #include <keys/asymmetric-type.h>
>  #include <keys/system_keyring.h>
> +#include <keys/platform_keyring.h>
>  #include <crypto/pkcs7.h>
>  
>  static struct key *builtin_trusted_keys;
> @@ -239,12 +240,16 @@ int verify_pkcs7_signature(const void *data, size_t len,
>  		trusted_keys = secondary_trusted_keys;
>  #else
>  		trusted_keys = builtin_trusted_keys;
> +#endif
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +	} else if (trusted_keys == VERIFY_USE_PLATFORM_KEYRING) {
> +		trusted_keys = platform_trusted_keys;
>  #endif
>  	}
>  	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
>  	if (ret < 0) {
>  		if (ret == -ENOKEY)
> -			pr_err("PKCS#7 signature not signed with a trusted key\n");
> +			pr_devel("PKCS#7 signature not signed with a trusted key\n");
>  		goto error;
>  	}
>  
> diff --git a/include/linux/verification.h b/include/linux/verification.h
> index cfa4730d607a..018fb5f13d44 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -17,6 +17,7 @@
>   * should be used.
>   */
>  #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
> +#define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
>  
>  /*
>   * The use to which an asymmetric key is being put.
> -- 
> 2.20.1
> 

Personally I would like to see platform key separated from integrity.
But for the kexec_file part I think it is good at least it works with
this fix.

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
