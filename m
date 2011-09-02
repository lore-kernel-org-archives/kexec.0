Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QzL65-0001L0-9l
	for kexec@lists.infradead.org; Fri, 02 Sep 2011 04:11:18 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] [RFC] sh: kexec: Register crashk_res
Date: Fri,  2 Sep 2011 12:47:12 +0900
Message-Id: <1314935232-1545-1-git-send-email-horms@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-sh@vger.kernel.org

Register crashk_res so that it can be used by kexec-tools
via /proc/iomem.

On x86 the registration occurs using
insert_resource(&iomem_resource, &crashk_res).
However that approach seems to result in the boot hanging on SH.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/sh/kernel/setup.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 58bff45..6d566bb 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -211,13 +211,16 @@ void __init __add_active_range(unsigned int nid, unsigned long start_pfn,
 	}
 
 	/*
-	 *  We don't know which RAM region contains kernel data,
-	 *  so we try it repeatedly and let the resource manager
-	 *  test it.
+	 *  We don't know which RAM region contains kernel data or
+	 *  the reserved crashkernel region, so try it repeatedly
+	 *  and let the resource manager test it.
 	 */
 	request_resource(res, &code_resource);
 	request_resource(res, &data_resource);
 	request_resource(res, &bss_resource);
+#ifdef CONFIG_KEXEC
+	request_resource(res, &crashk_res);
+#endif
 
 	/*
 	 * Also make sure that there is a PMB mapping that covers this
-- 
1.7.5.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
