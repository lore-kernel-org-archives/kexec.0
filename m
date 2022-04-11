From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 11 Apr 2022 14:13:55 +0530
Subject: [RFC v4 PATCH 3/5] powrepc/crash hp: update kimage_arch struct
In-Reply-To: <20220411084357.157308-1-sourabhjain@linux.ibm.com>
References: <20220411084357.157308-1-sourabhjain@linux.ibm.com>
Message-ID: <20220411084357.157308-4-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Two new members fdt_index and fdt_index_valid are added in kimage_arch
struct to track the FDT kexec segment. These new members of kimage_arch
struct will help the crash hotplug handler to easily access the FDT
segment from the kexec segment array. Otherwise, we have to loop through
all kexec segments to find the FDT segments.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index e1288826e22e..19c2cab6a880 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -104,6 +104,8 @@ extern const struct kexec_file_ops kexec_elf64_ops;
 struct kimage_arch {
 	struct crash_mem *exclude_ranges;
 
+	int fdt_index;
+	bool fdt_index_valid;
 	unsigned long backup_start;
 	void *backup_buf;
 	void *fdt;
-- 
2.35.1


