Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgUfS-0001bL-Ty
 for kexec@lists.infradead.org; Sun, 26 May 2013 06:43:00 +0000
Received: by mail-pd0-f170.google.com with SMTP id x10so5450938pdj.15
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 23:42:35 -0700 (PDT)
Message-ID: <51A1AECE.9040105@gmail.com>
Date: Sun, 26 May 2013 14:42:22 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH v2 5/7] powerpc: Remove savemaxmem parameter setup
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Simon Horman <horms@verge.net.au>, Paul Mackerras <paulus@samba.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

saved_max_pfn is used to know the amount of memory that the previous
kernel used. And for powerpc, we set saved_max_pfn by passing the
kernel commandline parameter "savemaxmem=".

The only user of saved_max_pfn in powerpc is read_oldmem interface.
Since we have removed read_oldmem, we don't need this parameter anymore.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/crash_dump.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 9ec3fe1..779a78c 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -69,16 +69,6 @@ void __init setup_kdump_trampoline(void)
 }
 #endif /* CONFIG_NONSTATIC_KERNEL */
 
-static int __init parse_savemaxmem(char *p)
-{
-	if (p)
-		saved_max_pfn = (memparse(p, &p) >> PAGE_SHIFT) - 1;
-
-	return 1;
-}
-__setup("savemaxmem=", parse_savemaxmem);
-
-
 static size_t copy_oldmem_vaddr(void *vaddr, char *buf, size_t csize,
                                unsigned long offset, int userbuf)
 {
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
