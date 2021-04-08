Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout02.posteo.de ([185.67.36.66])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUavd-009A5V-Mu
 for kexec@lists.infradead.org; Thu, 08 Apr 2021 20:07:03 +0000
Received: from submission (posteo.de [89.146.220.130]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 48CC6240199
 for <kexec@lists.infradead.org>; Thu,  8 Apr 2021 22:06:57 +0200 (CEST)
From: Alexander Egorenkov <egorenar-dev@posteo.net>
Subject: [PATCH 1/1] arm: do not copy magic 4 bytes of appended DTB in zImage
Date: Thu,  8 Apr 2021 22:06:44 +0200
Message-Id: <20210408200644.19724-1-egorenar-dev@posteo.net>
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
To: rmk@armlinux.org.uk
Cc: kexec@lists.infradead.org, Alexander Egorenkov <egorenar-dev@posteo.net>

If the passed zImage happens to have a DTB appended, then the magic 4 bytes
of the DTB are copied together with the kernel image. This leads to
failed kexec boots because the decompressor finds the aforementioned
DTB magic and falsely tries to replace the DTB passed in the register r2
with the non-existent appended one.

Signed-off-by: Alexander Egorenkov <egorenar-dev@posteo.net>
---
 kexec/arch/arm/kexec-zImage-arm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 925a9be..8ec289d 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -382,6 +382,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
 	unsigned int extra_size = 0x8000; /* TEXT_OFFSET */
 	const struct zimage_tag *tag;
+	size_t kernel_buf_size;
 	size_t kernel_mem_size;
 	const char *command_line;
 	char *modified_cmdline = NULL;
@@ -537,6 +538,8 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		}
 	}
 
+	kernel_buf_size = len;
+
 	/*
 	 * Always extend the zImage by four bytes to ensure that an appended
 	 * DTB image always sees an initialised value after _edata.
@@ -759,7 +762,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		add_segment(info, dtb_buf, dtb_length, dtb_offset, dtb_length);
 	}
 
-	add_segment(info, buf, len, kernel_base, kernel_mem_size);
+	add_segment(info, buf, kernel_buf_size, kernel_base, kernel_mem_size);
 
 	info->entry = (void*)kernel_base;
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
