From: Eric DeVolder <eric.devolder@oracle.com>
Date: Wed,  9 Feb 2022 14:57:06 -0500
Subject: [PATCH v4 10/10] crash hp: Add x86 crash hotplug support for
 kexec_load
In-Reply-To: <20220209195706.51522-1-eric.devolder@oracle.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
Message-ID: <20220209195706.51522-11-eric.devolder@oracle.com>
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

In general, support for kexec_load requires corresponding changes
to the userspace kexec-tools utility. It is the responsibility of
the userspace kexec utility to ensure that:
 - the elfcorehdr segment is sufficiently large enough to accommodate
   hotplug changes, ala CRASH_HOTPLUG_ELFCOREHDR_SZ.
 - provides a purgatory that excludes the elfcorehdr from its list of
   run-time segments to check.
These changes to the userspace kexec utility are available, but not
yet accepted upstream.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 6215c51919db..1b3e5e4fb965 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -458,6 +458,32 @@ void arch_crash_hotplug_handler(struct kimage *image,
 	void *elfbuf = NULL;
 	unsigned long mem, memsz;
 
+	/*
+	 * When the struct kimage is alloced, it is wiped to zero, so
+	 * the elf_index_valid defaults to false. It is set on the
+	 * kexec_file_load path, or here for kexec_load.
+	 */
+	if (!image->elf_index_valid) {
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			memsz = image->segment[n].memsz;
+			ptr = map_crash_pages(mem, memsz);
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if ((ptr[0] == 0x7F) &&
+					(ptr[1] == 'E') &&
+					(ptr[2] == 'L') &&
+					(ptr[3] == 'F')) {
+					image->elf_index = (int)n;
+					image->elf_index_valid = true;
+				}
+			}
+			unmap_crash_pages((void **)&ptr);
+		}
+	}
+
 	/* Must have valid elfcorehdr index */
 	if (!image->elf_index_valid) {
 		pr_err("crash hp: unable to locate elfcorehdr segment");
-- 
2.27.0


