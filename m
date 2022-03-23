From: Raphael Ning <raphning@gmail.com>
Date: Wed, 23 Mar 2022 14:44:18 +0000
Subject: [PATCH v2] kexec-xen: Allow xen_kexec_exec() to return in case of
 Live Update
Message-ID: <20220323144418.1658-1-raphning@gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Raphael Ning <raphning@amazon.com>

Currently, my_exec() does not expect the Xen KEXEC_CMD_kexec hypercall
to return on success, because it assumes that the hypercall always
triggers an immediate reboot. However, for Live Update, the hypercall
merely schedules the kexec operation and returns; the actual reboot
happens asynchronously. [1]

Therefore, rework the Xen code path of my_exec() such that it does not
treat a successfully processed Live Update request as an error. Also,
rephrase the comment above the function to remove ambiguity.

[1] https://lists.xen.org/archives/html/xen-devel/2021-05/msg00286.html

Signed-off-by: Raphael Ning <raphning@amazon.com>
---
Changes in v2:
- Fix --without-xen build.

---
 kexec/kexec-xen.c | 12 ++++++++----
 kexec/kexec.c     | 23 +++++++++++++++++++----
 kexec/kexec.h     |  2 +-
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index 47da3da466f0..a7c89339c4b7 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -247,21 +247,24 @@ int xen_kexec_status(uint64_t kexec_flags)
 	return ret;
 }
 
-void xen_kexec_exec(uint64_t kexec_flags)
+int xen_kexec_exec(uint64_t kexec_flags)
 {
 	xc_interface *xch;
 	uint8_t type = KEXEC_TYPE_DEFAULT;
+	int ret;
 
 	xch = xc_interface_open(NULL, NULL, 0);
 	if (!xch)
-		return;
+		return -1;
 
 	if (kexec_flags & KEXEC_LIVE_UPDATE)
 		type = KEXEC_TYPE_LIVE_UPDATE;
 
-	xc_kexec_exec(xch, type);
+	ret = xc_kexec_exec(xch, type);
 
 	xc_interface_close(xch);
+
+	return ret;
 }
 
 #else /* ! HAVE_LIBXENCTRL */
@@ -286,8 +289,9 @@ int xen_kexec_status(uint64_t kexec_flags)
 	return -1;
 }
 
-void xen_kexec_exec(uint64_t kexec_flags)
+int xen_kexec_exec(uint64_t kexec_flags)
 {
+	return -1;
 }
 
 #endif
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 7e4787bc8211..e7861049bbea 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -902,13 +902,28 @@ static int my_shutdown(void)
 }
 
 /*
- *	Exec the new kernel (reboot)
+ *	Exec the new kernel. If successful, this triggers an immediate reboot
+ *	and does not return, but Xen Live Update is an exception (more on this
+ *	below).
  */
 static int my_exec(void)
 {
-	if (xen_present())
-		xen_kexec_exec(kexec_flags);
-	else
+	if (xen_present()) {
+		int ret;
+
+		/*
+		 * There are two cases in which the Xen hypercall may return:
+		 * 1) An error occurred, e.g. the kexec image was not loaded.
+		 *    The exact error is indicated by errno.
+		 * 2) Live Update was successfully scheduled. Note that unlike
+		 *    a normal kexec, Live Update happens asynchronously, i.e.
+		 *    the hypercall merely schedules the kexec operation and
+		 *    returns immediately.
+		 */
+		ret = xen_kexec_exec(kexec_flags);
+		if ((kexec_flags & KEXEC_LIVE_UPDATE) && !ret)
+			return 0;
+	} else
 		reboot(LINUX_REBOOT_CMD_KEXEC);
 	/* I have failed if I make it here */
 	fprintf(stderr, "kexec failed: %s\n", 
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 595dd681db6d..0f97a974cb8a 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -324,7 +324,7 @@ void cmdline_add_liveupdate(char **base);
 int xen_present(void);
 int xen_kexec_load(struct kexec_info *info);
 int xen_kexec_unload(uint64_t kexec_flags);
-void xen_kexec_exec(uint64_t kexec_flags);
+int xen_kexec_exec(uint64_t kexec_flags);
 int xen_kexec_status(uint64_t kexec_flags);
 
 extern unsigned long long get_kernel_sym(const char *text);
-- 
2.32.0


