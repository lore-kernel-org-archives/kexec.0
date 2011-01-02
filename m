Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.windriver.com ([147.11.1.11])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PZIJs-0006OX-BE
	for kexec@lists.infradead.org; Sun, 02 Jan 2011 07:25:37 +0000
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [34-longterm 232/260] x86,
	kdump: Change copy_oldmem_page() to use cached addressing
Date: Sun,  2 Jan 2011 02:18:48 -0500
Message-Id: <1293952756-15010-233-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1293952756-15010-1-git-send-email-paul.gortmaker@windriver.com>
References: <1293952756-15010-1-git-send-email-paul.gortmaker@windriver.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: stable@kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@elte.hu>, kexec@lists.infradead.org, stable-review@kernel.org, Cliff Wickman <cpw@sgi.com>

From: Cliff Wickman <cpw@sgi.com>

commit 37a2f9f30a360fb03522d15c85c78265ccd80287 upstream.

The copy of /proc/vmcore to a user buffer proceeds much faster
if the kernel addresses memory as cached.

With this patch we have seen an increase in transfer rate from
less than 15MB/s to 80-460MB/s, depending on size of the
transfer. This makes a big difference in time needed to save a
system dump.

Signed-off-by: Cliff Wickman <cpw@sgi.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
LKML-Reference: <E1OtMLz-0001yp-Ia@eag09.americas.sgi.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/x86/kernel/crash_dump_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index ce96a6b..9948288 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -34,7 +34,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!csize)
 		return 0;
 
-	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
+	vaddr = ioremap_cache(pfn << PAGE_SHIFT, PAGE_SIZE);
 	if (!vaddr)
 		return -ENOMEM;
 
-- 
1.7.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
