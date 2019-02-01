Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpb5j-0003jh-Ol
 for kexec@lists.infradead.org; Fri, 01 Feb 2019 15:51:18 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH] arm64: wipe old initrd addresses when patching the DTB
Date: Fri,  1 Feb 2019 15:50:28 +0000
Message-Id: <20190201155028.43562-1-jean-philippe.brucker@arm.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

When copying the DTB from the current kernel, if the user didn't pass an
initrd on the command-line, make sure that the new DTB doesn't contain
initrd properties with stale addresses. Otherwise the next kernel will
try to unpack the initramfs from a location that contains junk, since
the initial initrd is long gone:

[   49.370026] Initramfs unpacking failed: junk in compressed archive

This issue used to be hidden by a successful recovery, but since commit
ff1522bb7d98 ("initramfs: cleanup incomplete rootfs") in Linux, the
kernel removes the default /root mountpoint after failing to load an
initramfs, and cannot mount the rootfs passed on the command-line
anymore.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 kexec/arch/arm64/kexec-arm64.c | 5 +++++
 kexec/dt-ops.c                 | 6 ++++++
 kexec/dt-ops.h                 | 1 +
 3 files changed, 12 insertions(+)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 1cde75d..2992bce 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -713,6 +713,11 @@ int arm64_load_other_segments(struct kexec_info *info,
 		}
 	}
 
+	if (!initrd_buf) {
+		/* Don't reuse the initrd addresses from 1st DTB */
+		dtb_clear_initrd((char **)&dtb.buf, &dtb.size);
+	}
+
 	/* Check size limit as specified in booting.txt. */
 
 	if (dtb.size > MiB(2)) {
diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
index 5626c47..dd2feaa 100644
--- a/kexec/dt-ops.c
+++ b/kexec/dt-ops.c
@@ -45,6 +45,12 @@ int dtb_set_initrd(char **dtb, off_t *dtb_size, off_t start, off_t end)
 	return 0;
 }
 
+void dtb_clear_initrd(char **dtb, off_t *dtb_size)
+{
+	dtb_delete_property(*dtb, n_chosen, p_initrd_start);
+	dtb_delete_property(*dtb, n_chosen, p_initrd_end);
+}
+
 int dtb_set_bootargs(char **dtb, off_t *dtb_size, const char *command_line)
 {
 	return dtb_set_property(dtb, dtb_size, n_chosen, p_bootargs,
diff --git a/kexec/dt-ops.h b/kexec/dt-ops.h
index e70d15d..03659ce 100644
--- a/kexec/dt-ops.h
+++ b/kexec/dt-ops.h
@@ -4,6 +4,7 @@
 #include <sys/types.h>
 
 int dtb_set_initrd(char **dtb, off_t *dtb_size, off_t start, off_t end);
+void dtb_clear_initrd(char **dtb, off_t *dtb_size);
 int dtb_set_bootargs(char **dtb, off_t *dtb_size, const char *command_line);
 int dtb_set_property(char **dtb, off_t *dtb_size, const char *node,
 	const char *prop, const void *value, int value_len);
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
