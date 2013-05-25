Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ug5HZ-0003ny-CV
 for kexec@lists.infradead.org; Sat, 25 May 2013 03:36:37 +0000
Received: by mail-pd0-f176.google.com with SMTP id r11so4763681pdi.7
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 20:36:16 -0700 (PDT)
Message-ID: <51A031A6.4060406@gmail.com>
Date: Sat, 25 May 2013 11:36:06 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 7/7] s390: Remove setting for saved_max_pfn
References: <51A02E50.5020507@gmail.com>
In-Reply-To: <51A02E50.5020507@gmail.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Simon Horman <horms@verge.net.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

The only user of saved_max_pfn in s390 is read_oldmem interface but we
have removed that interface, so saved_max_pfn is now unneeded in s390,
and we needn't set it anymore.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/kernel/setup.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 0a49095..497451e 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -719,10 +719,6 @@ static void reserve_oldmem(void)
 	}
 	create_mem_hole(memory_chunk, OLDMEM_BASE, OLDMEM_SIZE);
 	create_mem_hole(memory_chunk, OLDMEM_SIZE, real_size - OLDMEM_SIZE);
-	if (OLDMEM_BASE + OLDMEM_SIZE == real_size)
-		saved_max_pfn = PFN_DOWN(OLDMEM_BASE) - 1;
-	else
-		saved_max_pfn = PFN_DOWN(real_size) - 1;
 #endif
 }
 
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
