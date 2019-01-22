Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gly7U-0004Ti-6W
 for kexec@lists.infradead.org; Tue, 22 Jan 2019 15:37:45 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0MFVY0K120927
 for <kexec@lists.infradead.org>; Tue, 22 Jan 2019 10:37:40 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q63g873qx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 22 Jan 2019 10:37:40 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Tue, 22 Jan 2019 15:37:38 -0000
Subject: Re: [PATCH v5 1/2] integrity, KEYS: add a reference to platform
 keyring
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 22 Jan 2019 10:37:18 -0500
In-Reply-To: <20190121095929.26915-2-kasong@redhat.com>
References: <20190121095929.26915-1-kasong@redhat.com>
 <20190121095929.26915-2-kasong@redhat.com>
Mime-Version: 1.0
Message-Id: <1548171438.4038.2.camel@linux.ibm.com>
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
> commit 9dc92c45177a ('integrity: Define a trusted platform keyring')
> introduced a .platform keyring for storing preboot keys, used for
> verifying kernel images' signature. Currently only IMA-appraisal is able
> to use the keyring to verify kernel images that have their signature
> stored in xattr.
> 
> This patch exposes the .platform keyring, making it
> accessible for verifying PE signed kernel images as well.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>

Reviewed/Tested-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  certs/system_keyring.c        | 9 +++++++++
>  include/keys/system_keyring.h | 9 +++++++++
>  security/integrity/digsig.c   | 3 +++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 81728717523d..4690ef9cda8a 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -24,6 +24,9 @@ static struct key *builtin_trusted_keys;
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  static struct key *secondary_trusted_keys;
>  #endif
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +static struct key *platform_trusted_keys;
> +#endif
>  
>  extern __initconst const u8 system_certificate_list[];
>  extern __initconst const unsigned long system_certificate_list_size;
> @@ -265,4 +268,10 @@ int verify_pkcs7_signature(const void *data, size_t len,
>  }
>  EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
>  
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +void __init set_platform_trusted_keys(struct key *keyring) {
> +	platform_trusted_keys = keyring;
> +}
> +#endif
> +
>  #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> index 359c2f936004..df766ef8f03c 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -61,5 +61,14 @@ static inline struct key *get_ima_blacklist_keyring(void)
>  }
>  #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
>  
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +
> +extern void __init set_platform_trusted_keys(struct key* keyring);
> +
> +#else
> +
> +static inline void set_platform_trusted_keys(struct key* keyring) { };
> +
> +#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
>  
>  #endif /* _KEYS_SYSTEM_KEYRING_H */
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index f45d6edecf99..e19c2eb72c51 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -87,6 +87,9 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
>  		pr_info("Can't allocate %s keyring (%d)\n",
>  			keyring_name[id], err);
>  		keyring[id] = NULL;
> +	} else {
> +		if (id == INTEGRITY_KEYRING_PLATFORM)
> +			set_platform_trusted_keys(keyring[id]);
>  	}
>  
>  	return err;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
