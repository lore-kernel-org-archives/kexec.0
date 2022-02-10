From: Michal Suchanek <msuchanek@suse.de>
Date: Thu, 10 Feb 2022 14:16:48 +0100
Subject: [PATCH] kexec: move KEXEC_SIG_FORCE from arch/x86 to arch
Message-ID: <20220210131648.16276-1-msuchanek@suse.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

There is nothing x86-specific about KEXEC_SIG_FORCE

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/Kconfig     | 7 +++++++
 arch/x86/Kconfig | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..dc2446f01ac1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -24,6 +24,13 @@ config KEXEC_ELF
 config HAVE_IMA_KEXEC
 	bool
 
+config KEXEC_SIG_FORCE
+	bool "Require a valid signature in kexec_file_load() syscall"
+	depends on KEXEC_SIG
+	help
+	  This option makes kernel signature verification mandatory for
+	  the kexec_file_load() syscall.
+
 config SET_FS
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..3ea648dad6b6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2032,13 +2032,6 @@ config KEXEC_SIG
 	  verification for the corresponding kernel image type being
 	  loaded in order for this to work.
 
-config KEXEC_SIG_FORCE
-	bool "Require a valid signature in kexec_file_load() syscall"
-	depends on KEXEC_SIG
-	help
-	  This option makes kernel signature verification mandatory for
-	  the kexec_file_load() syscall.
-
 config KEXEC_BZIMAGE_VERIFY_SIG
 	bool "Enable bzImage signature verification support"
 	depends on KEXEC_SIG
-- 
2.31.1


