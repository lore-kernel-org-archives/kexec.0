Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAO-00056S-LL
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:16 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 841BA2460B
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121321.505252137@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:02 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 06/27] ia64: Remove unused info parameter from {move,
	update}_loaded_segments()
References: <20100201121156.252909695@vergenet.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1870434287=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>

--===============1870434287==
Content-Disposition: inline; filename=ia64-move_loaded_segments-removed-unused-parameter.patch

Signed-off-by: Simon Horman <horms@verge.net.au>


/bin/bash: 0001-add-kexec-tools-support-for-armv7l-processors.patch: ������������������������������������
���������������������������������������������������
Index: kexec-tools/kexec/arch/ia64/kexec-elf-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/kexec-elf-ia64.c	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/kexec-elf-ia64.c	2010-02-01 23:07:17.000000000 +1100
@@ -96,8 +96,7 @@ void elf_ia64_usage(void)
 
 /* Move the crash kerenl physical offset to reserved region
  */
-void move_loaded_segments(struct kexec_info *info, struct mem_ehdr *ehdr,
-			  unsigned long addr)
+void move_loaded_segments(struct mem_ehdr *ehdr, unsigned long addr)
 {
 	int i;
 	long offset;
@@ -198,8 +197,8 @@ int elf_ia64_load(int argc, char **argv,
 			free_elf_info(&ehdr);
 			return -1;
 		}
-		move_loaded_segments(info, &ehdr, mem_min);
-	} else if (update_loaded_segments(info, &ehdr) < 0) {
+		move_loaded_segments(&ehdr, mem_min);
+	} else if (update_loaded_segments(&ehdr) < 0) {
 		fprintf(stderr, "Failed to place kernel\n");
 		return -1;
 	}
Index: kexec-tools/kexec/arch/ia64/kexec-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/kexec-ia64.c	2010-02-01 23:07:16.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/kexec-ia64.c	2010-02-01 23:07:17.000000000 +1100
@@ -216,7 +216,7 @@ int arch_compat_trampoline(struct kexec_
 	return 0;
 }
 
-int update_loaded_segments(struct kexec_info *info, struct mem_ehdr *ehdr)
+int update_loaded_segments(struct mem_ehdr *ehdr)
 {
 	int i;
 	struct mem_phdr *phdr;
@@ -247,7 +247,7 @@ int update_loaded_segments(struct kexec_
 		start = (memory_range[i].start + align - 1) & ~(align - 1);
 		end = memory_range[i].end;
 		if (end > start && (end - start) > (end_addr - start_addr)) {
-		    move_loaded_segments(info, ehdr, start);
+		    move_loaded_segments(ehdr, start);
 			return 0;
 		}
 	}
Index: kexec-tools/kexec/arch/ia64/kexec-ia64.h
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/kexec-ia64.h	2010-02-01 23:06:40.000000000 +1100
+++ kexec-tools/kexec/arch/ia64/kexec-ia64.h	2010-02-01 23:07:17.000000000 +1100
@@ -6,9 +6,8 @@ int elf_ia64_probe(const char *buf, off_
 int elf_ia64_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_ia64_usage(void);
-int update_loaded_segments(struct kexec_info *info, struct mem_ehdr *ehdr);
-void move_loaded_segments(struct kexec_info *info, struct mem_ehdr *ehdr,
-			  unsigned long addr);
+int update_loaded_segments(struct mem_ehdr *ehdr);
+void move_loaded_segments(struct mem_ehdr *ehdr, unsigned long addr);
 
 #define EFI_PAGE_SIZE	  (1UL<<12)
 #define ELF_PAGE_SIZE	  (1UL<<16)



--===============1870434287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1870434287==--
