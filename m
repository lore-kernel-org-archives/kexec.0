Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glRwm-0005Ui-FB
 for kexec@lists.infradead.org; Mon, 21 Jan 2019 05:16:34 +0000
Received: by mail-pf1-x444.google.com with SMTP id c123so9573425pfb.0
 for <kexec@lists.infradead.org>; Sun, 20 Jan 2019 21:16:31 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCHv7] x86/kdump: bugfix,
 make the behavior of crashkernel=X consistent with kaslr
Date: Mon, 21 Jan 2019 13:16:08 +0800
Message-Id: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
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
To: kexec@lists.infradead.org
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com

People reported crashkernel=384M reservation failed on a high end server
with KASLR enabled.  In that case there is enough free memory under 896M
but crashkernel reservation still fails intermittently.

The situation is crashkernel reservation code only finds free region under
896 MB with 128M aligned in case no ',high' being used.  And KASLR could
break the first 896M into several parts randomly thus the failure happens.
User has no way to predict and make sure crashkernel=xM working unless
he/she use 'crashkernel=xM,high'.  Since 'crashkernel=xM' is the most
common use case this issue is a serious bug.

And we can't answer questions raised from customer:
1) why it doesn't succeed to reserve 896 MB;
2) what's wrong with memory region under 4G;
3) why I have to add ',high', I only require 384 MB, not 3840 MB.

This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
finally above 4G.

Dave Young sent the original post, and I just re-post it with commit log
improvement as his requirement.
http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
There was an old discussion below (previously posted by Chao Wang):
https://lkml.org/lkml/2013/10/15/601

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: yinghai@kernel.org,
Cc: vgoyal@redhat.com
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
v6 -> v7: commit log improvement
 arch/x86/kernel/setup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a5..fa62c81 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -551,6 +551,22 @@ static void __init reserve_crashkernel(void)
 						    high ? CRASH_ADDR_HIGH_MAX
 							 : CRASH_ADDR_LOW_MAX,
 						    crash_size, CRASH_ALIGN);
+#ifdef CONFIG_X86_64
+		/*
+		 * crashkernel=X reserve below 896M fails? Try below 4G
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						(1ULL << 32),
+						crash_size, CRASH_ALIGN);
+		/*
+		 * crashkernel=X reserve below 4G fails? Try MAXMEM
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						CRASH_ADDR_HIGH_MAX,
+						crash_size, CRASH_ALIGN);
+#endif
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
