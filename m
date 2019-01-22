Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gly7k-0004XB-LV
 for kexec@lists.infradead.org; Tue, 22 Jan 2019 15:38:02 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0MFVY6w120948
 for <kexec@lists.infradead.org>; Tue, 22 Jan 2019 10:38:00 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q63g8745f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 22 Jan 2019 10:37:59 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Tue, 22 Jan 2019 15:37:57 -0000
Subject: Re: [PATCH v5 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 22 Jan 2019 10:37:38 -0500
In-Reply-To: <20190121095929.26915-3-kasong@redhat.com>
References: <20190121095929.26915-1-kasong@redhat.com>
 <20190121095929.26915-3-kasong@redhat.com>
Mime-Version: 1.0
Message-Id: <1548171458.4038.3.camel@linux.ibm.com>
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
To: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc: jwboyer@fedoraproject.org, ebiggers@google.com, dyoung@redhat.com, nayna@linux.ibm.com, kexec@lists.infradead.org, jmorris@namei.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

On Mon, 2019-01-21 at 17:59 +0800, Kairui Song wrote:
> This patch let kexec_file_load makes use of .platform keyring as fall
> back if it failed to verify a PE signed image against secondary or
> builtin key ring, make it possible to verify kernel image signed with
> preboot keys as well.
> 
> This commit adds a VERIFY_USE_PLATFORM_KEYRING similar to previous
> VERIFY_USE_SECONDARY_KEYRING indicating that verify_pkcs7_signature
> should verify the signature using platform keyring. Also, decrease
> the error message log level when verification failed with -ENOKEY,
> so that if called tried multiple time with different keyring it
> won't generate extra noises.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>

Reviewed/Tested-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
>  certs/system_keyring.c            | 13 ++++++++++++-
>  include/linux/verification.h      |  1 +
>  3 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 7d97e432cbbc..2c007abd3d40 100644
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
> +				      VERIFY_USE_SECONDARY_KEYRING,
> +				      VERIFYING_KEXEC_PE_SIGNATURE);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> +		ret = verify_pefile_signature(kernel, kernel_len,
> +					      VERIFY_USE_PLATFORM_KEYRING,
> +					      VERIFYING_KEXEC_PE_SIGNATURE);
> +	}
> +	return ret;
>  }
>  #endif
>  
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 4690ef9cda8a..7085c286f4bd 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -240,11 +240,22 @@ int verify_pkcs7_signature(const void *data, size_t len,
>  #else
>  		trusted_keys = builtin_trusted_keys;
>  #endif
> +	} else if (trusted_keys == VERIFY_USE_PLATFORM_KEYRING) {
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +		trusted_keys = platform_trusted_keys;
> +#else
> +		trusted_keys = NULL;
> +#endif
> +		if (!trusted_keys) {
> +			ret = -ENOKEY;
> +			pr_devel("PKCS#7 platform keyring is not available\n");
> +			goto error;
> +		}
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
