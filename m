Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail.fujitsu.co.jp ([164.71.1.133])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsPy2-0004sI-2X
 for kexec@lists.infradead.org; Thu, 05 Jun 2014 05:11:59 +0000
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
 by fgwmail.fujitsu.co.jp (Postfix) with ESMTP id 553893EE0B6
 for <kexec@lists.infradead.org>; Thu,  5 Jun 2014 14:11:09 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 6596EAC1123
 for <kexec@lists.infradead.org>; Thu,  5 Jun 2014 14:11:08 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 19D701DB802C
 for <kexec@lists.infradead.org>; Thu,  5 Jun 2014 14:11:08 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [PATCH 1/2] Enumerate all /sys/devices/system/cpu/cpuN when they are
 discontiguous
Date: Thu,  5 Jun 2014 14:10:54 +0900
Message-Id: <1401945055-2820-2-git-send-email-indou.takao@jp.fujitsu.com>
In-Reply-To: <1401945055-2820-1-git-send-email-indou.takao@jp.fujitsu.com>
References: <1401945055-2820-1-git-send-email-indou.takao@jp.fujitsu.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org

There is a case that the number of /sys/devices/system/cpu/cpuN is not
contiguous, for example after cpu hot removing. This patch fixes so that
all /sys/devices/system/cpu/cpuN is handled when they are discontiguous.

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 kexec/crashdump-elf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index 2baa357..c869347 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -41,6 +41,7 @@ int FUNC(struct kexec_info *info,
 	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
 	int has_vmcoreinfo = 0;
 	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
+	long int count_cpu;
 
 	if (xen_present())
 		nr_cpus = xen_get_nr_phys_cpus();
@@ -138,11 +139,13 @@ int FUNC(struct kexec_info *info,
 
 	/* PT_NOTE program headers. One per cpu */
 
-	for (i = 0; i < nr_cpus; i++) {
+	count_cpu = nr_cpus;
+	for (i = 0; count_cpu > 0; i++) {
 		if (get_note_info(i, &notes_addr, &notes_len) < 0) {
 			/* This cpu is not present. Skip it. */
 			continue;
 		}
+		count_cpu--;
 
 		phdr = (PHDR *) bufp;
 		bufp += sizeof(PHDR);
-- 
1.9.3



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
