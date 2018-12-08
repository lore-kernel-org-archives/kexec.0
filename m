Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVjG1-0002Ic-9m
 for kexec@lists.infradead.org; Sat, 08 Dec 2018 20:31:28 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB8KT7m3156292
 for <kexec@lists.infradead.org>; Sat, 8 Dec 2018 15:31:19 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p8b1d0kmt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Sat, 08 Dec 2018 15:31:19 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <nayna@linux.ibm.com>;
 Sat, 8 Dec 2018 20:31:17 -0000
From: Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 7/7] ima: Support platform keyring for kernel appraisal
Date: Sun,  9 Dec 2018 01:57:05 +0530
In-Reply-To: <20181208202705.18673-1-nayna@linux.ibm.com>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
Message-Id: <20181208202705.18673-8-nayna@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-integrity@vger.kernel.org
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, Nayna Jain <nayna@linux.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, vgoyal@redhat.com

On secure boot enabled systems, the bootloader verifies the kernel
image and possibly the initramfs signatures based on a set of keys. A
soft reboot(kexec) of the system, with the same kernel image and
initramfs, requires access to the original keys to verify the
signatures.

This patch allows IMA-appraisal access to those original keys, now
loaded on the platform keyring, needed for verifying the kernel image
and initramfs signatures.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
- replace 'rc' with 'xattr_len' when calling integrity_digsig_verify()
with INTEGRITY_KEYRING_IMA for readability
Suggested-by: Serge Hallyn <serge@hallyn.com>
---
Changelog:

v2:
- replace 'rc' with 'xattr_len' when calling integrity_digsig_verify()
with INTEGRITY_KEYRING_IMA for readability

 security/integrity/ima/ima_appraise.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index deec1804a00a..e8f520450895 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -289,12 +289,21 @@ int ima_appraise_measurement(enum ima_hooks func,
 	case EVM_IMA_XATTR_DIGSIG:
 		set_bit(IMA_DIGSIG, &iint->atomic_flags);
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
-					     (const char *)xattr_value, rc,
+					     (const char *)xattr_value,
+					     xattr_len,
 					     iint->ima_hash->digest,
 					     iint->ima_hash->length);
 		if (rc == -EOPNOTSUPP) {
 			status = INTEGRITY_UNKNOWN;
-		} else if (rc) {
+			break;
+		}
+		if (rc && func == KEXEC_KERNEL_CHECK)
+			rc = integrity_digsig_verify(INTEGRITY_KEYRING_PLATFORM,
+						     (const char *)xattr_value,
+						     xattr_len,
+						     iint->ima_hash->digest,
+						     iint->ima_hash->length);
+		if (rc) {
 			cause = "invalid-signature";
 			status = INTEGRITY_FAIL;
 		} else {
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
