Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnSOW-0000J9-Bd
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 06:19:36 +0000
Date: Wed, 8 Oct 2008 17:19:35 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch] cris: add cris architecture to configure
Message-ID: <20081008061933.GI22396@verge.net.au>
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

# PATH=$PATH:/usr/local/cris/bin/ CC=crisv32-axis-linux-gnu-gcc \
	./configure --host=crisv32-axis-linux-gnu
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking build system type... i686-pc-linux-gnu
checking host system type... cris-axis-linux-gnu
checking target system type... cris-axis-linux-gnu
configure: error: unsupported architecture cris

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

I have added this patch to the kexec-tools git tree.

diff --git a/configure.ac b/configure.ac
index ff3b304..c9793b6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -42,7 +42,7 @@ case $target_cpu in
 	mips|mipsel )
 		ARCH="mips"
 		;;
-	crisv32 )
+	cris|crisv32 )
 		ARCH="cris"
 		;;
 	ia64|x86_64|alpha )

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
