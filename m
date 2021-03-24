Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOst9-00G7JR-W3
 for kexec@lists.infradead.org; Wed, 24 Mar 2021 02:04:54 +0000
Received: by mail-pj1-x1031.google.com with SMTP id t18so10907924pjs.3
 for <kexec@lists.infradead.org>; Tue, 23 Mar 2021 19:04:49 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 02/12] buildid: Add method to get running kernel's build ID
Date: Tue, 23 Mar 2021 19:04:33 -0700
Message-Id: <20210324020443.1815557-3-swboyd@chromium.org>
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jessica Yu <jeyu@kernel.org>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

Add vmlinux_build_id() so that callers can print a hex format string
representation of the running kernel's build ID. This will be used in
the kdump and dump_stack code so that developers can easily locate the
vmlinux debug symbols for a crash/stacktrace.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: <kexec@lists.infradead.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/buildid.h |  2 ++
 lib/buildid.c           | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index ebce93f26d06..2ff6b1b7cc9b 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -10,4 +10,6 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
+const unsigned char *vmlinux_build_id(void);
+
 #endif
diff --git a/lib/buildid.c b/lib/buildid.c
index 010ab0674cb9..fa1b6466b4b8 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -4,6 +4,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/string.h>
 
 #define BUILD_ID 3
 
@@ -171,3 +172,21 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 {
 	return parse_build_id_buf(build_id, NULL, buf, buf_size);
 }
+
+/**
+ * vmlinux_build_id - Get the running kernel's build ID
+ *
+ * Return: Running kernel's build ID
+ */
+const unsigned char *vmlinux_build_id(void)
+{
+	extern const void __start_notes __weak;
+	extern const void __stop_notes __weak;
+	unsigned int size = &__stop_notes - &__start_notes;
+	static unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
+
+	if (!memchr_inv(vmlinux_build_id, 0, BUILD_ID_SIZE_MAX))
+		build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
+
+	return vmlinux_build_id;
+}
-- 
https://chromeos.dev


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
