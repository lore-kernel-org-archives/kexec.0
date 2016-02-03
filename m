Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aR2nY-0003Zu-4W
 for kexec@lists.infradead.org; Wed, 03 Feb 2016 19:09:10 +0000
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 4 Feb 2016 05:08:42 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 61C5A2CE8056
 for <kexec@lists.infradead.org>; Thu,  4 Feb 2016 06:08:40 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13J8WUq22806678
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:08:40 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13J871e010430
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:08:08 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 17/22] ima: remove firmware and module specific cached
 status info
Date: Wed,  3 Feb 2016 14:06:25 -0500
Message-Id: <1454526390-19792-18-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, linux-modules@vger.kernel.org, fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Kees Cook <keescook@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>

Each time a file is read by the kernel, the file should be re-measured and
the file signature re-appraised, based on policy.  As there is no need to
preserve the status information, this patch replaces the firmware and
module specific cache status with a generic one named read_file.

This change simplifies adding support for other files read by the kernel.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/iint.c             |  4 ++--
 security/integrity/ima/ima.h          |  3 ++-
 security/integrity/ima/ima_appraise.c | 35 ++++++++++++++++-------------------
 security/integrity/ima/ima_policy.c   |  9 ++++-----
 security/integrity/integrity.h        | 16 ++++------------
 5 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8f1ab37..345b759 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -77,7 +77,7 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
 	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
 	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-	iint->ima_module_status = INTEGRITY_UNKNOWN;
+	iint->ima_read_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	kmem_cache_free(iint_cache, iint);
 }
@@ -157,7 +157,7 @@ static void init_once(void *foo)
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
 	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
 	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-	iint->ima_module_status = INTEGRITY_UNKNOWN;
+	iint->ima_read_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 }
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 0b7134c..a5d2592 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -144,9 +144,10 @@ enum ima_hooks {
 	FILE_CHECK = 1,
 	MMAP_CHECK,
 	BPRM_CHECK,
+	POST_SETATTR,
 	MODULE_CHECK,
 	FIRMWARE_CHECK,
-	POST_SETATTR
+	MAX_CHECK
 };
 
 /* LIM API function definitions */
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index cb0d0ff..6b4694a 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -74,13 +74,12 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 		return iint->ima_mmap_status;
 	case BPRM_CHECK:
 		return iint->ima_bprm_status;
-	case MODULE_CHECK:
-		return iint->ima_module_status;
-	case FIRMWARE_CHECK:
-		return iint->ima_firmware_status;
 	case FILE_CHECK:
-	default:
+	case POST_SETATTR:
 		return iint->ima_file_status;
+	case MODULE_CHECK ... MAX_CHECK - 1:
+	default:
+		return iint->ima_read_status;
 	}
 }
 
@@ -95,15 +94,14 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 	case BPRM_CHECK:
 		iint->ima_bprm_status = status;
 		break;
-	case MODULE_CHECK:
-		iint->ima_module_status = status;
-		break;
-	case FIRMWARE_CHECK:
-		iint->ima_firmware_status = status;
-		break;
 	case FILE_CHECK:
-	default:
+	case POST_SETATTR:
 		iint->ima_file_status = status;
+		break;
+	case MODULE_CHECK ... MAX_CHECK - 1:
+	default:
+		iint->ima_read_status = status;
+		break;
 	}
 }
 
@@ -117,15 +115,14 @@ static void ima_cache_flags(struct integrity_iint_cache *iint,
 	case BPRM_CHECK:
 		iint->flags |= (IMA_BPRM_APPRAISED | IMA_APPRAISED);
 		break;
-	case MODULE_CHECK:
-		iint->flags |= (IMA_MODULE_APPRAISED | IMA_APPRAISED);
-		break;
-	case FIRMWARE_CHECK:
-		iint->flags |= (IMA_FIRMWARE_APPRAISED | IMA_APPRAISED);
-		break;
 	case FILE_CHECK:
-	default:
+	case POST_SETATTR:
 		iint->flags |= (IMA_FILE_APPRAISED | IMA_APPRAISED);
+		break;
+	case MODULE_CHECK ... MAX_CHECK - 1:
+	default:
+		iint->flags |= (IMA_READ_APPRAISED | IMA_APPRAISED);
+		break;
 	}
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index cfbe86f..7571ce8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -300,13 +300,12 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 		return IMA_MMAP_APPRAISE;
 	case BPRM_CHECK:
 		return IMA_BPRM_APPRAISE;
-	case MODULE_CHECK:
-		return IMA_MODULE_APPRAISE;
-	case FIRMWARE_CHECK:
-		return IMA_FIRMWARE_APPRAISE;
 	case FILE_CHECK:
-	default:
+	case POST_SETATTR:
 		return IMA_FILE_APPRAISE;
+	case MODULE_CHECK ... MAX_CHECK - 1:
+	default:
+		return IMA_READ_APPRAISE;
 	}
 }
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 9a0ea4c..c7a111c 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -45,18 +45,12 @@
 #define IMA_MMAP_APPRAISED	0x00000800
 #define IMA_BPRM_APPRAISE	0x00001000
 #define IMA_BPRM_APPRAISED	0x00002000
-#define IMA_MODULE_APPRAISE	0x00004000
-#define IMA_MODULE_APPRAISED	0x00008000
-#define IMA_FIRMWARE_APPRAISE	0x00010000
-#define IMA_FIRMWARE_APPRAISED	0x00020000
-#define IMA_READ_APPRAISE	0x00040000
-#define IMA_READ_APPRAISED	0x00080000
+#define IMA_READ_APPRAISE	0x00004000
+#define IMA_READ_APPRAISED	0x00008000
 #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
-				 IMA_BPRM_APPRAISE | IMA_MODULE_APPRAISE | \
-				 IMA_FIRMWARE_APPRAISE | IMA_READ_APPRAISE)
+				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE)
 #define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
-				 IMA_BPRM_APPRAISED | IMA_MODULE_APPRAISED | \
-				 IMA_FIRMWARE_APPRAISED | IMA_READ_APPRAISED)
+				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED)
 
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
@@ -111,8 +105,6 @@ struct integrity_iint_cache {
 	enum integrity_status ima_file_status:4;
 	enum integrity_status ima_mmap_status:4;
 	enum integrity_status ima_bprm_status:4;
-	enum integrity_status ima_module_status:4;
-	enum integrity_status ima_firmware_status:4;
 	enum integrity_status ima_read_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
