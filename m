From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Tue, 15 Mar 2022 04:17:26 +0530
Subject: [RFC v2 PATCH 3/5] powrepc/crash hp: update kimage struct
In-Reply-To: <20220314224728.79990-1-sourabhjain@linux.ibm.com>
References: <20220314224728.79990-1-sourabhjain@linux.ibm.com>
Message-ID: <20220314224728.79990-4-sourabhjain@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Two new members fdt_index and fdt_index_valid are added in kimage struct
to track the FDT kexec segment. These new members of kimage struct will
help the crash hotplug handler to easily access the FDT segment from the
kexec segment array. Otherwise, we have to loop through all kexec segments
to find the FDT segments.

Note: It is possible that we might need to update multiple kexec segments
for a hotplug event then tracking each segment with an individual variable
in kimage struct is not efficient. How about an array to track all the
hotplug kexec segments?

struct hp_segment{
	int index;
	bool is_valid;
}

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 include/linux/kexec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e00c373c4095..e9038f2c75ee 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -306,6 +306,8 @@ struct kimage {
 	int offlinecpu;
 	bool elf_index_valid;
 	int elf_index;
+	int fdt_index;
+	bool fdt_index_valid;
 #endif
 #endif
 
-- 
2.35.1


