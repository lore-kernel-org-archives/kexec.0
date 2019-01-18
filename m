Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkQJ3-00030x-7N
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 09:19:18 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v4 1/2] integrity, KEYS: add a reference to platform keyring
Date: Fri, 18 Jan 2019 17:17:32 +0800
Message-Id: <20190118091733.29940-2-kasong@redhat.com>
In-Reply-To: <20190118091733.29940-1-kasong@redhat.com>
References: <20190118091733.29940-1-kasong@redhat.com>
MIME-Version: 1.0
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
To: linux-kernel@vger.kernel.org
Cc: jwboyer@fedoraproject.org, Kairui Song <kasong@redhat.com>, ebiggers@google.com, dyoung@redhat.com, nayna@linux.ibm.com, kexec@lists.infradead.org, jmorris@namei.org, zohar@linux.ibm.com, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

commit 9dc92c45177a ('integrity: Define a trusted platform keyring')
introduced a .platform keyring for storing preboot keys, used for
verifying kernel images' signature. Currently only IMA-appraisal is able
to use the keyring to verify kernel images that have their signature
stored in xattr.

This patch exposes the .platform keyring, making it accessible for
verifying PE signed kernel images as well.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Tested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 5 +++++
 security/integrity/digsig.c   | 6 ++++++
 3 files changed, 20 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 81728717523d..4690ef9cda8a 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -24,6 +24,9 @@ static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
 #endif
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+static struct key *platform_trusted_keys;
+#endif
 
 extern __initconst const u8 system_certificate_list[];
 extern __initconst const unsigned long system_certificate_list_size;
@@ -265,4 +268,10 @@ int verify_pkcs7_signature(const void *data, size_t len,
 }
 EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+void __init set_platform_trusted_keys(struct key *keyring) {
+	platform_trusted_keys = keyring;
+}
+#endif
+
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 359c2f936004..9e1b7849b6aa 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -61,5 +61,10 @@ static inline struct key *get_ima_blacklist_keyring(void)
 }
 #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+
+extern void __init set_platform_trusted_keys(struct key* keyring);
+
+#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
 
 #endif /* _KEYS_SYSTEM_KEYRING_H */
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index f45d6edecf99..bfabc2a8111d 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -89,6 +89,12 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
 		keyring[id] = NULL;
 	}
 
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+	if (id == INTEGRITY_KEYRING_PLATFORM) {
+		set_platform_trusted_keys(keyring[id]);
+	}
+#endif
+
 	return err;
 }
 
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
