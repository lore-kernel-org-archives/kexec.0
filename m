Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NsLwO-00072K-U2
	for kexec@lists.infradead.org; Thu, 18 Mar 2010 20:03:43 +0000
Received: by bwz7 with SMTP id 7so1840999bwz.4
	for <kexec@lists.infradead.org>; Thu, 18 Mar 2010 13:03:36 -0700 (PDT)
From: Ameya Palande <2ameya@gmail.com>
Subject: [PATCH 3/6] kexec-tools: Add missing include files in dist target
Date: Thu, 18 Mar 2010 22:03:21 +0200
Message-Id: <c2178185d63a334988fd0ad5eb3dd5a8afb45e41.1268942234.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1268942234.git.ameya.palande@nokia.com>
References: <cover.1268942234.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1268942234.git.ameya.palande@nokia.com>
References: <cover.1268942234.git.ameya.palande@nokia.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 include/Makefile |    1 +
 kexec/Makefile   |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/Makefile b/include/Makefile
index de5a3bb..12c1030 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -6,6 +6,7 @@ dist += include/Makefile		\
 	include/x86/mb_header.h		\
 	include/elf.h			\
 	include/image.h			\
+	include/unused.h		\
 	include/boot/linuxbios_tables.h	\
 	include/boot/beoboot.h		\
 	include/boot/elf_boot.h
diff --git a/kexec/Makefile b/kexec/Makefile
index 9a55af2..4e091ba 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -32,6 +32,7 @@ dist += kexec/Makefile $(KEXEC_SRCS) $(KEXEC_GENERATED_SRCS)	\
 	kexec/crashdump.h kexec/firmware_memmap.h		\
 	kexec/kexec-elf-boot.h					\
 	kexec/kexec-elf.h kexec/kexec-sha256.h			\
+	kexec/kexec-zlib.h kexec/kexec-lzma.h			\
 	kexec/kexec-syscall.h kexec/kexec.h kexec/kexec.8
 
 $(ARCH)_PROC_IOMEM		= kexec/proc_iomem.c
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
