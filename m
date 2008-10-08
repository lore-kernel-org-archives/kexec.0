Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnSNQ-0005rQ-Ui
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 06:18:29 +0000
Date: Wed, 8 Oct 2008 17:18:27 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] cris: add kexc_load syscall
Message-ID: <20081008061826.GH22396@verge.net.au>
References: <20080904140850.GC14660@edgar.se.axis.com>
	<20080905004244.GA22365@verge.net.au>
	<20080905092557.GA12335@edgar.se.axis.com>
	<20081008061541.GF22396@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081008061541.GF22396@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
Cc: "Edgar E. Iglesias" <edgar@axis.com>, kexec@lists.infradead.org, jespern@axis.com

From: Edgar E. Iglesias <edgar.iglesias@axis.com>

The released toolchain had an old list of syscalls (kexec_load was missing)
so I had to add a fallback definition:

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/kexec-syscall.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

I have applied this patch to the kexec-tools git tree.

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 2b9345f..4535716 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -28,6 +28,11 @@
 #ifdef __sh__
 #define __NR_kexec_load		283
 #endif
+#ifdef __cris__
+#ifndef __NR_kexec_load
+#define __NR_kexec_load		283
+#endif
+#endif
 #ifdef __ia64__
 #define __NR_kexec_load		1268
 #endif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
