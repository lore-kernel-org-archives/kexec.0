From: Eric DeVolder <eric.devolder@oracle.com>
Date: Fri,  1 Apr 2022 14:30:40 -0400
Subject: [PATCH v6 8/8] x86/crash: Add x86 crash hotplug support for kexec_load
In-Reply-To: <20220401183040.1624-1-eric.devolder@oracle.com>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
Message-ID: <20220401183040.1624-9-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

For kexec_file_load support, the loading of the crash kernel occurs
entirely within the kernel, and as such the elfcorehdr is readily
identified (so that it can be modified upon hotplug events).

This change enables support for kexec_load by identifying the
elfcorehdr segment in the arch_crash_hotplug_handler(), if it has
not already been identified.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 101c030ac038..682f130b83e3 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -486,6 +486,30 @@ void arch_crash_hotplug_handler(struct kimage *image,
 	void *elfbuf = NULL;
 	unsigned long mem, memsz;
 
+	/*
+	 * When the struct kimage is alloced, it is wiped to zero, so
+	 * the elfcorehdr_index_valid defaults to false. It is set on the
+	 * kexec_file_load path, or here for kexec_load, if not already
+	 * identified.
+	 */
+	if (!image->elfcorehdr_index_valid) {
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			memsz = image->segment[n].memsz;
+			ptr = map_crash_pages(mem, memsz);
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+					image->elfcorehdr_index = (int)n;
+					image->elfcorehdr_index_valid = true;
+				}
+			}
+			unmap_crash_pages((void **)&ptr);
+		}
+	}
+
 	if (!image->elfcorehdr_index_valid) {
 		pr_err("crash hp: unable to locate elfcorehdr segment");
 		goto out;
-- 
2.27.0


