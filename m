Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqKCq-0003rS-V5
 for kexec@lists.infradead.org; Sun, 03 Feb 2019 16:01:18 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH] integrity,
 KEYS: Fix build break with set_platform_trusted_keys
Date: Sun,  3 Feb 2019 23:59:27 +0800
Message-Id: <20190203155927.24390-1-kasong@redhat.com>
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

Commit 15ebb2eb0705 ("integrity, KEYS: add a reference to platform
keyring") introduced a function set_platform_trusted_keys
and calls the function in __integrity_init_keyring.

It only checks if CONFIG_INTEGRITY_PLATFORM_KEYRING is enabled when
enabling this function, but actually this function also depends on
CONFIG_SYSTEM_TRUSTED_KEYRING.

So when built with CONFIG_INTEGRITY_PLATFORM_KEYRING &&
!CONFIG_SYSTEM_TRUSTED_KEYRING. we will get following error:

digsig.c:92: undefined reference to `set_platform_trusted_keys'

And it also mistakenly wrapped the function code in the ifdef block of
CONFIG_SYSTEM_DATA_VERIFICATION.

This commit fixes the issue by adding the missing check of
CONFIG_SYSTEM_TRUSTED_KEYRING and move the function code out of
CONFIG_SYSTEM_DATA_VERIFICATION's ifdef block.

Fixes: 15ebb2eb0705 ("integrity, KEYS: add a reference to platform keyring")
Signed-off-by: Kairui Song <kasong@redhat.com>
---
 certs/system_keyring.c        | 4 ++--
 include/keys/system_keyring.h | 9 +++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 19bd0504bbcb..c05c29ae4d5d 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -279,11 +279,11 @@ int verify_pkcs7_signature(const void *data, size_t len,
 }
 EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
 
+#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
+
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 void __init set_platform_trusted_keys(struct key *keyring)
 {
 	platform_trusted_keys = keyring;
 }
 #endif
-
-#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index c7f899ee974e..42a93eda331c 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -61,16 +61,13 @@ static inline struct key *get_ima_blacklist_keyring(void)
 }
 #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
 
-#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
-
+#if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING) && \
+	defined(CONFIG_SYSTEM_TRUSTED_KEYRING)
 extern void __init set_platform_trusted_keys(struct key *keyring);
-
 #else
-
 static inline void set_platform_trusted_keys(struct key *keyring)
 {
 }
-
-#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
+#endif
 
 #endif /* _KEYS_SYSTEM_KEYRING_H */
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
