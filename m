Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z82Uk-0005Ae-AW
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 08:26:51 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5P8OlmP017706
 for <kexec@lists.infradead.org>; Thu, 25 Jun 2015 16:24:47 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] makedumpfile: Add description of pages lost by ENOSPACE
 in IMPLEMENTATION
Date: Thu, 25 Jun 2015 16:22:55 +0800
Message-ID: <1435220576-32595-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
 IMPLEMENTATION |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/IMPLEMENTATION b/IMPLEMENTATION
index 72df5d5..70a3f7c 100644
--- a/IMPLEMENTATION
+++ b/IMPLEMENTATION
@@ -240,6 +240,8 @@
     The page header and page data are written in pairs. When writing page data
     (pfn N+1), if ENOSPACE error happens, the page headers after N won't be
     written either.
+    When reading page from incomplete core, only the page lost by ENOSPACE errors
+    has 0 in its corresponding page descriptor's member offset.
 
     If there is no page data dumped into the DUMPFILE, the DUMPFILE can't be
     analysed by crash.
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
