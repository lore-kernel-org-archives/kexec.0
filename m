Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i18KU-0007l1-Bv
 for kexec@lists.infradead.org; Fri, 23 Aug 2019 12:06:07 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 1/4 v2] Cleanup: remove the read_elf_kcore()
Date: Fri, 23 Aug 2019 20:05:36 +0800
Message-Id: <20190823120539.18330-2-lijiang@redhat.com>
In-Reply-To: <20190823120539.18330-1-lijiang@redhat.com>
References: <20190823120539.18330-1-lijiang@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kasong@redhat.com, bhe@redhat.com, piliu@redhat.com, bhsharma@redhat.com, junw99@yahoo.com, horms@verge.net.au, dyoung@redhat.com

Here, no need to wrap the read_elf() again, lets invoke it directly.
So remove the read_elf_kcore() and clean up redundant code.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c |  2 +-
 util_lib/elf_info.c            | 15 ++-------------
 util_lib/include/elf_info.h    |  2 +-
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index eb3a3a37307c..6ad3b0a134b3 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -889,7 +889,7 @@ int get_phys_base_from_pt_load(unsigned long *phys_offset)
 		return EFAILED;
 	}
 
-	read_elf_kcore(fd);
+	read_elf(fd);
 
 	for (i = 0; get_pt_load(i,
 		    &phys_start, NULL, &virt_start, NULL);
diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 90a3b21662e7..d9397ecd8626 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -764,7 +764,7 @@ static void dump_dmesg(int fd)
 		dump_dmesg_legacy(fd);
 }
 
-static int read_elf(int fd)
+int read_elf(int fd)
 {
 	int ret;
 
@@ -824,24 +824,13 @@ int read_elf_vmcore(int fd)
 	return 0;
 }
 
-int read_elf_kcore(int fd)
-{
-	int ret;
-
-	ret = read_elf(fd);
-	if (ret != 0)
-		return ret;
-
-	return 0;
-}
-
 int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off)
 {
 	int ret;
 
 	*phys_off = UINT64_MAX;
 
-	ret = read_elf_kcore(fd);
+	ret = read_elf(fd);
 	if (!ret) {
 		/* If we have a valid 'PHYS_OFFSET' by now,
 		 * return it to the caller now.
diff --git a/util_lib/include/elf_info.h b/util_lib/include/elf_info.h
index 1a4debd2d4ba..c328a1b0ecf2 100644
--- a/util_lib/include/elf_info.h
+++ b/util_lib/include/elf_info.h
@@ -29,7 +29,7 @@ int get_pt_load(int idx,
 	unsigned long long *virt_start,
 	unsigned long long *virt_end);
 int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off);
-int read_elf_kcore(int fd);
+int read_elf(int fd);
 int read_elf_vmcore(int fd);
 
 #endif /* ELF_INFO_H */
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
