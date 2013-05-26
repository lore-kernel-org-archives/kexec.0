Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgUhE-0001cu-O1
 for kexec@lists.infradead.org; Sun, 26 May 2013 06:44:49 +0000
Received: by mail-pa0-f45.google.com with SMTP id tj12so797916pac.32
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 23:44:25 -0700 (PDT)
Message-ID: <51A1AF3E.6000707@gmail.com>
Date: Sun, 26 May 2013 14:44:14 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH v2 6/7] ia64: Remove setting for saved_max_pfn
References: <51A1AC4A.60506@gmail.com>
In-Reply-To: <51A1AC4A.60506@gmail.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt.fleming@intel.com>, Simon Horman <horms@verge.net.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

The only user of saved_max_pfn in ia64 is read_oldmem interface but we
have removed that interface, so saved_max_pfn is now unneeded in ia64,
and we needn't set it anymore.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matt Fleming <matt.fleming@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/ia64/kernel/efi.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index f034563..51bce59 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -1116,11 +1116,6 @@ efi_memmap_init(u64 *s, u64 *e)
 		if (!is_memory_available(md))
 			continue;
 
-#ifdef CONFIG_CRASH_DUMP
-		/* saved_max_pfn should ignore max_addr= command line arg */
-		if (saved_max_pfn < (efi_md_end(md) >> PAGE_SHIFT))
-			saved_max_pfn = (efi_md_end(md) >> PAGE_SHIFT);
-#endif
 		/*
 		 * Round ends inward to granule boundaries
 		 * Give trimmings to uncached allocator
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
