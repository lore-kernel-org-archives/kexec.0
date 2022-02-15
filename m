From: Michal Suchanek <msuchanek@suse.de>
Date: Tue, 15 Feb 2022 20:39:39 +0100
Subject: [PATCH 2/4] kexec, KEYS,
 arm64: Make use of platform keyring for signature verification
In-Reply-To: <cover.1644953683.git.msuchanek@suse.de>
References: <cover.1644953683.git.msuchanek@suse.de>
Message-ID: <7581dcfe676024aa438beddecbf162e4ec81ccfc.1644953683.git.msuchanek@suse.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

commit 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
adds platform keyring support on x86 kexec but not arm64.

Add platform keyring support on arm64 as well.

Fixes: 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
Cc: kexec at lists.infradead.org
Cc: keyrings at vger.kernel.org
Cc: linux-security-module at vger.kernel.org
Cc: stable at kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/arm64/kernel/kexec_image.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 1fbf2ee7c005..3dee7b2d8336 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -133,9 +133,17 @@ static void *image_load(struct kimage *image,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
 static int image_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	return verify_pefile_signature(kernel, kernel_len,
-				       VERIFY_USE_SECONDARY_KEYRING,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
+	int ret;
+
+	ret = verify_pefile_signature(kernel, kernel_len,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+					      VERIFY_USE_PLATFORM_KEYRING,
+					      VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+	return ret;
 }
 #endif
 
-- 
2.31.1


