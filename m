From: Michal Suchanek <msuchanek@suse.de>
Date: Tue, 11 Jan 2022 12:37:43 +0100
Subject: [PATCH v5 1/6] s390/kexec_file: Don't opencode appended signature
 check.
In-Reply-To: <cover.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
Message-ID: <940cd6a0e88793060cdf5ddb7880c03564b38bdd.1641900831.git.msuchanek@suse.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Module verification already implements appeded signature check.

Reuse it for kexec_file.

The kexec_file implementation uses EKEYREJECTED error in some cases when
there is no key and the common implementation uses ENOPKG or EBADMSG
instead.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
v3: Philipp Rudo <prudo@redhat.com>: Update the commit with note about
change of return value
---
 arch/s390/kernel/machine_kexec_file.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8f43575a4dd3..c944d71316c7 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature *ms;
 	unsigned long sig_len;
+	int ret;
 
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
@@ -45,25 +46,12 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	kernel_len -= marker_len;
 
 	ms = (void *)kernel + kernel_len - sizeof(*ms);
-	kernel_len -= sizeof(*ms);
+	ret = mod_check_sig(ms, kernel_len, "kexec");
+	if (ret)
+		return ret;
 
 	sig_len = be32_to_cpu(ms->sig_len);
-	if (sig_len >= kernel_len)
-		return -EKEYREJECTED;
-	kernel_len -= sig_len;
-
-	if (ms->id_type != PKEY_ID_PKCS7)
-		return -EKEYREJECTED;
-
-	if (ms->algo != 0 ||
-	    ms->hash != 0 ||
-	    ms->signer_len != 0 ||
-	    ms->key_id_len != 0 ||
-	    ms->__pad[0] != 0 ||
-	    ms->__pad[1] != 0 ||
-	    ms->__pad[2] != 0) {
-		return -EBADMSG;
-	}
+	kernel_len -= sizeof(*ms) + sig_len;
 
 	return verify_pkcs7_signature(kernel, kernel_len,
 				      kernel + kernel_len, sig_len,
-- 
2.31.1


