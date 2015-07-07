Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZCHIX-0006BE-U3
 for kexec@lists.infradead.org; Tue, 07 Jul 2015 01:03:46 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6711fZO010685
 for <kexec@lists.infradead.org>; Tue, 7 Jul 2015 09:01:41 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v2] makedumpfile: Add description of pages lost by ENOSPACE in
 IMPLEMENTATION
Date: Tue, 7 Jul 2015 08:59:31 +0800
Message-ID: <1436230771-5670-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: kexec@lists.infradead.org

Currently, there is no obvious description in IMPLEMENTATION for
distinguishing the lost pages resulted by ENOSPACE errors or others.
So, it is added.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 IMPLEMENTATION |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/IMPLEMENTATION b/IMPLEMENTATION
index 72df5d5..589c5bf 100644
--- a/IMPLEMENTATION
+++ b/IMPLEMENTATION
@@ -240,6 +240,10 @@
     The page header and page data are written in pairs. When writing page data
     (pfn N+1), if ENOSPACE error happens, the page headers after N won't be
     written either.
+    Since the data lost is filled with zero when it is read, the page_desc->offset
+    will also be zero. And zero page has its own offset not equal 0. So when reading
+    page from incomplete core, only the page lost by ENOSPACE errors has 0 in its
+    corresponding page descriptor's member offset.
 
     If there is no page data dumped into the DUMPFILE, the DUMPFILE can't be
     analysed by crash.
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
