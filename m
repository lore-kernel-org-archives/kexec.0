Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNZbs-0004BT-1J
 for kexec@lists.infradead.org; Wed, 12 Mar 2014 03:13:37 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2C3DEjL001393
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Tue, 11 Mar 2014 23:13:14 -0400
Date: Wed, 12 Mar 2014 11:13:09 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: [kexec-tools PATCH] x86: extend kernel text size up to 1GB
Message-ID: <20140312031309.GA14477@dhcp-17-89.nay.redhat.com>
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

Currently kexec hard code X86_64_KERNEL_TEXT_SIZE to 512M. With kASLR
enabled (CONFIG_RANDOMIZED_BASE=y), kernel image base offset could be
randomized from 0 to 1GB and kexec-tools fails to get kernel virtual
address from /proc/kcore when the offset is >512M.

Now extend X86_64_KERNEL_TEXT_SIZE to 1GB to adapt kASLR.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
index e68b626..a5b2dfd 100644
--- a/kexec/arch/i386/crashdump-x86.h
+++ b/kexec/arch/i386/crashdump-x86.h
@@ -18,7 +18,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 #define X86_64_MAXMEM        		0x3fffffffffffUL
 
 /* Kernel text size */
-#define X86_64_KERNEL_TEXT_SIZE  (512UL*1024*1024)
+#define X86_64_KERNEL_TEXT_SIZE  (1UL*1024*1024*1024)
 
 #define CRASH_MAX_MEMMAP_NR	CRASH_MAX_MEMORY_RANGES
 #define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
