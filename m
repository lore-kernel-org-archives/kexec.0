Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1UAHYV-0001c6-Ho
 for kexec@lists.infradead.org; Tue, 26 Feb 2013 10:14:40 +0000
Message-ID: <512C8AA6.2020503@cn.fujitsu.com>
Date: Tue, 26 Feb 2013 18:12:54 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: kexec,x86: Use macro CRASH_MAX_MEMMAP_NR for clarification
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

For the allocation, using CRASH_MAX_MEMMAP_NR instead of KEXEC_MAX_SEGMENTS + 1 
seems more understandable.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/crashdump-x86.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 245402c..e4b8be3 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -975,7 +975,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
                return -1; 
 
        /* Memory regions which panic kernel can safely use to boot into */
-       sz = (sizeof(struct memory_range) * (KEXEC_MAX_SEGMENTS + 1));
+       sz = (sizeof(struct memory_range) * CRASH_MAX_MEMMAP_NR);
        memmap_p = xmalloc(sz);
        memset(memmap_p, 0, sz);
        add_memmap(memmap_p, info->backup_src_start, info->backup_src_size);
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
