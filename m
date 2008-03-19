Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JbrnR-0006nk-CW
	for kexec@lists.infradead.org; Wed, 19 Mar 2008 06:29:09 +0000
MIME-Version: 1.0
Subject: [PATCH 2/3] Use separate LDFLAGS for bin-to-hex
Message-Id: <1205908147.932697.715535782921.2.gpush@pokey>
In-Reply-To: <1205908147.931964.895312651655.1.gpush@pokey>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 19 Mar 2008 17:29:07 +1100
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
To: kexec@lists.infradead.org

We don't need the general -L and -l flags for the bin-to-hex util.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 util/Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/util/Makefile b/util/Makefile
index 89732a1..11d82fd 100644
--- a/util/Makefile
+++ b/util/Makefile
@@ -6,6 +6,7 @@ $(BIN_TO_HEX): $(srcdir)/util/bin-to-hex.c
 
 $(BIN_TO_HEX): CC=$(BUILD_CC)
 $(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
+$(BIN_TO_HEX): LDFLAGS=
 
 dist += util/Makefile util/bin-to-hex.c
 clean += util/bin-to-hex.o $(BIN_TO_HEX)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
