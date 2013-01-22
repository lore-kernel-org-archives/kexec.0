Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TxfNU-0001zZ-DC
 for kexec@lists.infradead.org; Tue, 22 Jan 2013 15:03:09 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/3] kexec x86: Extract kernel version and convert it to
 KERNEL_VERSION() style
Date: Tue, 22 Jan 2013 16:02:14 +0100
Message-Id: <1358866935-18458-3-git-send-email-trenn@suse.de>
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

from the kernel which is going to be loaded.
This is needed if kexec wants to check for available features by kernel release
version.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 kexec/arch/i386/kexec-bzImage.c |   13 +++++++++++--
 kexec/arch/i386/kexec-x86.h     |    1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 0605909..0c8c6bc 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -40,6 +40,7 @@
 #include <arch/options.h>
 
 static const int probe_debug = 0;
+long kv_to_load;
 
 int bzImage_probe(const char *buf, off_t len)
 {
@@ -107,7 +108,7 @@ int do_bzImage_load(struct kexec_info *info,
 	struct x86_linux_header setup_header;
 	struct x86_linux_param_header *real_mode;
 	int setup_sects;
-	char *kernel_version;
+	char kernel_release[12];
 	size_t size;
 	int kern16_size;
 	unsigned long setup_base, setup_size;
@@ -131,7 +132,15 @@ int do_bzImage_load(struct kexec_info *info,
 	}
 
 	kern16_size = (setup_sects +1) *512;
-	kernel_version = ((char *)&setup_header) + 512 + setup_header.kver_addr;
+
+	memcpy(kernel_release, kernel +  setup_header.kver_addr + 512, 12);
+	kernel_release[11] = '\0';
+	kv_to_load = kernel_version(kernel_release);
+	if (kv_to_load < 0)
+		die("Invalid kernel version\n");
+	dbgprintf("Kernel release: %s in long format: 0x%lx\n",
+		  kernel_release, kv_to_load);
+
 	if (kernel_len < kern16_size) {
 		fprintf(stderr, "BzImage truncated?\n");
 		return -1;
diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 5aa2a46..db80879 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -11,6 +11,7 @@ enum coretype {
 
 extern unsigned char compat_x86_64[];
 extern uint32_t compat_x86_64_size, compat_x86_64_entry32;
+extern long kv_to_load;
 
 struct entry32_regs {
 	uint32_t eax;
-- 
1.7.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
