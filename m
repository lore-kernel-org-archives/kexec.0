Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqnT8-0005zV-7H
 for kexec@lists.infradead.org; Thu, 14 Apr 2016 20:02:27 +0000
In-Reply-To: <20160414195938.GV19428@n2100.arm.linux.org.uk>
References: <20160414195938.GV19428@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 1/3] kexec: don't invoke OOM-killer for control page allocation
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1aqnQo-0001Tu-Ch@rmk-PC.arm.linux.org.uk>
Date: Thu, 14 Apr 2016 21:00:02 +0100
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org

If we are unable to find a suitable page when allocating the control
page, do not invoke the OOM-killer: killing processes probably isn't
going to help.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/kexec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 2cc643c6e870..1b32ab587f66 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -41,7 +41,7 @@
 #endif
 
 #ifndef KEXEC_CONTROL_MEMORY_GFP
-#define KEXEC_CONTROL_MEMORY_GFP GFP_KERNEL
+#define KEXEC_CONTROL_MEMORY_GFP (GFP_KERNEL | __GFP_NORETRY)
 #endif
 
 #ifndef KEXEC_CONTROL_PAGE_SIZE
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
