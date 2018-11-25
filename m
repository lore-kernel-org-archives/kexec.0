Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gQwBr-0007ZJ-2I
 for kexec@lists.infradead.org; Sun, 25 Nov 2018 15:19:21 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAPFEVHQ092551
 for <kexec@lists.infradead.org>; Sun, 25 Nov 2018 10:19:14 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nymsjxhp5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Sun, 25 Nov 2018 10:19:14 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <nayna@linux.ibm.com>;
 Sun, 25 Nov 2018 15:19:12 -0000
From: Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 7/7] ima: Support platform keyring for kernel appraisal
Date: Sun, 25 Nov 2018 20:45:00 +0530
In-Reply-To: <20181125151500.8298-1-nayna@linux.ibm.com>
References: <20181125151500.8298-1-nayna@linux.ibm.com>
Message-Id: <20181125151500.8298-8-nayna@linux.ibm.com>
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
---
 security/integrity/ima/ima_appraise.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index deec1804a00a..9c13585e7d3e 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -294,7 +294,16 @@ int ima_appraise_measurement(enum ima_hooks func,
 					     iint->ima_hash->length);
 		if (rc == -EOPNOTSUPP) {
 			status = INTEGRITY_UNKNOWN;
-		} else if (rc) {
+			break;
+		}
+		if (rc && func == KEXEC_KERNEL_CHECK)
+			rc = integrity_digsig_verify(
+					INTEGRITY_KEYRING_PLATFORM,
+					(const char *)xattr_value,
+					xattr_len,
+					iint->ima_hash->digest,
+					iint->ima_hash->length);
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
