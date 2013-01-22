Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TxfNU-0001zY-D6
 for kexec@lists.infradead.org; Tue, 22 Jan 2013 15:03:10 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/3] kexec: Split kernel_version() to also be able to pass a
 release string
Date: Tue, 22 Jan 2013 16:02:13 +0100
Message-Id: <1358866935-18458-2-git-send-email-trenn@suse.de>
In-Reply-To: <1358866935-18458-1-git-send-email-trenn@suse.de>
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: x86@kernel.org, kexec@lists.infradead.org, hpa@zytor.com, yinghai@kernel.org, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

No functional change, later patches need this.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 kexec/arch/i386/crashdump-x86.c |    2 +-
 kexec/kernel_version.c          |   33 +++++++++++++++++++--------------
 kexec/kexec.h                   |    3 ++-
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 245402c..a900b03 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -63,7 +63,7 @@ static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
 	int kv;
 
 	if (elf_info->machine == EM_X86_64) {
-		kv = kernel_version();
+		kv = kernel_version_running();
 		if (kv < 0)
 			return -1;
 
diff --git a/kexec/kernel_version.c b/kexec/kernel_version.c
index 079312b..e27a0b7 100644
--- a/kexec/kernel_version.c
+++ b/kexec/kernel_version.c
@@ -6,18 +6,15 @@
 #include <limits.h>
 #include <stdlib.h>
 
-long kernel_version(void)
+#define unsupported_release(str) \
+	fprintf(stderr, "Unsupported release string: %s\n", str);
+
+long kernel_version(char *release_str)
 {
-	struct utsname utsname;
 	unsigned long major, minor, patch;
 	char *p;
 
-	if (uname(&utsname) < 0) {
-		fprintf(stderr, "uname failed: %s\n", strerror(errno));
-		return -1;
-	}
-
-	p = utsname.release;
+	p = release_str;
 	major = strtoul(p, &p, 10);
 	if (major == ULONG_MAX) {
 		fprintf(stderr, "strtoul failed: %s\n", strerror(errno));
@@ -25,8 +22,7 @@ long kernel_version(void)
 	}
 
 	if (*p++ != '.') {
-		fprintf(stderr, "Unsupported utsname.release: %s\n",
-			utsname.release);
+		unsupported_release(release_str);
 		return -1;
 	}
 
@@ -37,8 +33,7 @@ long kernel_version(void)
 	}
 
 	if (*p++ != '.') {
-		fprintf(stderr, "Unsupported utsname.release: %s\n",
-			utsname.release);
+		unsupported_release(release_str);
 		return -1;
 	}
 
@@ -49,10 +44,20 @@ long kernel_version(void)
 	}
 
 	if (major >= 256 || minor >= 256 || patch >= 256) {
-		fprintf(stderr, "Unsupported utsname.release: %s\n",
-			utsname.release);
+		unsupported_release(release_str);
 		return -1;
 	}
 
 	return KERNEL_VERSION(major, minor, patch);
 }
+
+long kernel_version_running(void)
+{
+	struct utsname utsname;
+
+	if (uname(&utsname) < 0) {
+		fprintf(stderr, "uname failed: %s\n", strerror(errno));
+		return -1;
+	}
+	return kernel_version(utsname.release);
+}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 94c62c1..ecc75d9 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -154,7 +154,8 @@ long physical_arch(void);
 
 #define KERNEL_VERSION(major, minor, patch) \
 	(((major) << 16) | ((minor) << 8) | patch)
-long kernel_version(void);
+long kernel_version(char *release);
+long kernel_version_running(void);
 
 void usage(void);
 int get_memory_ranges(struct memory_range **range, int *ranges,
-- 
1.7.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
