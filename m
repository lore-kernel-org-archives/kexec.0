Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <3552a3e85a910688d932535549b35354a54927ad.1476134309.git.geoff@infradead.org>
In-Reply-To: <cover.1476134309.git.geoff@infradead.org>
References: <cover.1476134309.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 2/2] arm64: Add missing kexec dist files
Date: Mon, 10 Oct 2016 21:22:59 +0000
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 kexec/arch/arm64/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index d729df8..74b677f 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -20,7 +20,9 @@ arm64_VIRT_TO_PHYS =
 arm64_PHYS_TO_VIRT =
 
 dist += $(arm64_KEXEC_SRCS) \
+	kexec/arch/arm64/include/arch/options.h \
 	kexec/arch/arm64/crashdump-arm64.h \
+	kexec/arch/arm64/image-header.h \
 	kexec/arch/arm64/kexec-arm64.h \
 	kexec/arch/arm64/Makefile
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
