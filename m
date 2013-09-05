Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VHVl5-0004bC-Sf
 for kexec@lists.infradead.org; Thu, 05 Sep 2013 09:21:48 +0000
Date: Thu, 5 Sep 2013 17:21:21 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH] Remove PACKED macro and use __attribute__((packed)) directly
Message-ID: <20130905092121.GA8560@dhcp12-158.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

People are not always aware of PACKED macro and tend to
__attribute__((packed)) more directly. So let's remove PACKED to unify
things.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 include/x86/x86-linux.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index 0949dc2..c41e5f2 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -12,8 +12,6 @@
 
 #ifndef ASSEMBLY
 
-#define PACKED __attribute__((packed))
-
 #ifndef E820_RAM
 struct e820entry {
 	uint64_t addr;	/* start of memory segment */
@@ -23,7 +21,7 @@ struct e820entry {
 #define E820_RESERVED	2
 #define E820_ACPI	3 /* usable as RAM once ACPI tables have been read */
 #define E820_NVS	4
-} PACKED;
+} __attribute__((packed));
 #endif
 
 /* FIXME expand on drive_info_)struct... */
@@ -255,7 +253,7 @@ struct x86_linux_header {
 	uint64_t pref_address;			/* 0x258 */
 	uint32_t init_size;			/* 0x260 */
 	uint32_t handover_offset;		/* 0x264 */
-} PACKED;
+} __attribute__((packed));
 
 #endif /* ASSEMBLY */
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
