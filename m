Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJVk0-0002CN-R2
 for kexec@lists.infradead.org; Tue, 10 Sep 2013 21:45:07 +0000
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 04/16] integrity: Allow digital signature verification with a
 given keyring ptr
Date: Tue, 10 Sep 2013 17:44:19 -0400
Message-Id: <1378849471-10521-5-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
Cc: matthew.garrett@nebula.com, d.kasatkin@samsung.com, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, zohar@linux.vnet.ibm.com, vgoyal@redhat.com

Currently digital signature verification code assumes that it can be
used only with 3 keyrings. IMA, EVM and MODULE keyring. Provide another
variant where one can pass in a pointer to keyring (struct key *), and
integrity code can try to find key in that keyring and verify signature.

This will be useful at two places.

- elf binary loader can use system keyring and call into integrity
  subsystem for signature verification.
- In later patches I am extending keyctl() to allow signature of
  a user buffer against specified keyring. That logic can make use
  of this code too.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 security/integrity/digsig.c    | 26 ++++++++++++++++----------
 security/integrity/integrity.h |  9 +++++++++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 160fec7..f1259bd 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -44,6 +44,20 @@ int integrity_get_digsig_size(char *sig)
 	return -EBADMSG;
 }
 
+int integrity_digsig_verify_keyring(struct key *keyring, const char *sig,
+			int siglen, const char *digest, int digestlen)
+{
+	switch (sig[0]) {
+	case 1:
+		return digsig_verify(keyring, sig, siglen,
+				     digest, digestlen);
+	case 2:
+		return asymmetric_verify(keyring, sig, siglen,
+					 digest, digestlen);
+	}
+	return -EOPNOTSUPP;
+}
+
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 					const char *digest, int digestlen)
 {
@@ -61,14 +75,6 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 		}
 	}
 
-	switch (sig[0]) {
-	case 1:
-		return digsig_verify(keyring[id], sig, siglen,
-				     digest, digestlen);
-	case 2:
-		return asymmetric_verify(keyring[id], sig, siglen,
-					 digest, digestlen);
-	}
-
-	return -EOPNOTSUPP;
+	return integrity_digsig_verify_keyring(keyring[id], sig, siglen,
+						digest, digestlen);
 }
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 4246417..130eb3b 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -101,6 +101,8 @@ struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
 
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 					const char *digest, int digestlen);
+int integrity_digsig_verify_keyring(struct key *keyring, const char *sig,
+			int siglen, const char *digest, int digestlen);
 extern int integrity_get_digsig_size(char *sig);
 
 #else
@@ -112,6 +114,13 @@ static inline int integrity_digsig_verify(const unsigned int id,
 	return -EOPNOTSUPP;
 }
 
+static inline int integrity_digsig_verify_keyring(struct key *keyring,
+			const char *sig, int siglen, const char *digest,
+			int digestlen)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int integrity_get_digsig_size(char *sig) { return -EOPNOTSUPP; }
 
 #endif /* CONFIG_INTEGRITY_SIGNATURE */
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
