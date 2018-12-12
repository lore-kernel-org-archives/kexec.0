Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX92U-0002Rl-3v
 for kexec@lists.infradead.org; Wed, 12 Dec 2018 18:15:19 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBCIDc8u051241
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 13:15:06 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pb793gge9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 13:15:05 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.ibm.com>;
 Wed, 12 Dec 2018 18:15:05 -0000
References: <20181208202705.18673-1-nayna@linux.ibm.com>
 <20181208202705.18673-8-nayna@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] ima: Support platform keyring for kernel appraisal
In-reply-to: <20181208202705.18673-8-nayna@linux.ibm.com>
Date: Wed, 12 Dec 2018 16:14:47 -0200
MIME-Version: 1.0
Message-Id: <8736r2fw88.fsf@morokweng.localdomain>
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
To: Nayna Jain <nayna@linux.ibm.com>
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, linux-integrity@vger.kernel.org, vgoyal@redhat.com


Hello,

Nayna Jain <nayna@linux.ibm.com> writes:

> On secure boot enabled systems, the bootloader verifies the kernel
> image and possibly the initramfs signatures based on a set of keys. A
> soft reboot(kexec) of the system, with the same kernel image and
> initramfs, requires access to the original keys to verify the
> signatures.
>
> This patch allows IMA-appraisal access to those original keys, now
> loaded on the platform keyring, needed for verifying the kernel image
> and initramfs signatures.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> - replace 'rc' with 'xattr_len' when calling integrity_digsig_verify()
> with INTEGRITY_KEYRING_IMA for readability
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> ---
> Changelog:
>
> v2:
> - replace 'rc' with 'xattr_len' when calling integrity_digsig_verify()
> with INTEGRITY_KEYRING_IMA for readability
>
>  security/integrity/ima/ima_appraise.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index deec1804a00a..e8f520450895 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -289,12 +289,21 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	case EVM_IMA_XATTR_DIGSIG:
>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
>  		rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
> -					     (const char *)xattr_value, rc,
> +					     (const char *)xattr_value,
> +					     xattr_len,
>  					     iint->ima_hash->digest,
>  					     iint->ima_hash->length);
>  		if (rc == -EOPNOTSUPP) {
>  			status = INTEGRITY_UNKNOWN;
> -		} else if (rc) {
> +			break;
> +		}
> +		if (rc && func == KEXEC_KERNEL_CHECK)
> +			rc = integrity_digsig_verify(INTEGRITY_KEYRING_PLATFORM,
> +						     (const char *)xattr_value,
> +						     xattr_len,
> +						     iint->ima_hash->digest,
> +						     iint->ima_hash->length);

If CONFIG_INTEGRITY_PLATFORM_KEYRING=n the second call to
integrity_digsig_verify() above will always fail, and the audit message
of failed signature verifications for KEXEC_KERNEL will always log the
same rc value, which is whatever request_key() returns when asked to
look for an inexistent keyring.

Here is a patch which only performs the second try if the platform
keyring is enabled.


From d5fb94ab9eb13f6294f8dc44d1344cb85dfa41b8 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Wed, 12 Dec 2018 16:02:09 -0200
Subject: [PATCH] ima: Only use the platform keyring if it's enabled

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index e8f520450895..f6ac405daabb 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -297,7 +297,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 			status = INTEGRITY_UNKNOWN;
 			break;
 		}
-		if (rc && func == KEXEC_KERNEL_CHECK)
+		if (IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING) && rc &&
+		    func == KEXEC_KERNEL_CHECK)
 			rc = integrity_digsig_verify(INTEGRITY_KEYRING_PLATFORM,
 						     (const char *)xattr_value,
 						     xattr_len,


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
