Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPzVm-00466O-Cj
 for kexec@lists.infradead.org; Tue, 14 Sep 2021 03:53:35 +0000
From: Zhaofeng Li <hello@zhaofeng.li>
Subject: [PATCH v2 4/5] multiboot2: Avoid first 0x500 bytes
Date: Mon, 13 Sep 2021 20:51:41 -0700
Message-Id: <20210914035142.251818-5-hello@zhaofeng.li>
In-Reply-To: <20210914035142.251818-1-hello@zhaofeng.li>
References: <20210914035142.251818-1-hello@zhaofeng.li>
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
Cc: Zhaofeng Li <hello@zhaofeng.li>, Simon Horman <horms@verge.net.au>

In some cases, add_buffer will actually try to allocate the buffer
at 0x0, which may not be acceptable by some kernels. Let's avoid
the first 0x500 bytes so we don't screw up the IVT and BDA.

Signed-off-by: Zhaofeng Li <hello@zhaofeng.li>
---
 kexec/arch/i386/kexec-mb2-x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x86.c
index f3c6438..f3e6b38 100644
--- a/kexec/arch/i386/kexec-mb2-x86.c
+++ b/kexec/arch/i386/kexec-mb2-x86.c
@@ -526,7 +526,7 @@ int multiboot2_x86_load(int argc, char **argv, const char *buf, off_t len,
 		rel_min = lu_start + 4096;
 		rel_max = lu_end;
 	} else {
-		rel_min = 0;
+		rel_min = 0x500;
 		rel_max = ULONG_MAX;
 	}
 
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
