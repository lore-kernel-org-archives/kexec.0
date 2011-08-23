Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QvkCf-0002Db-UT
	for kexec@lists.infradead.org; Tue, 23 Aug 2011 06:11:17 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7N647IA029782
	for <kexec@lists.infradead.org>; Tue, 23 Aug 2011 16:04:07 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7N69QL2716842
	for <kexec@lists.infradead.org>; Tue, 23 Aug 2011 16:09:26 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7N6AhNm023090
	for <kexec@lists.infradead.org>; Tue, 23 Aug 2011 16:10:43 +1000
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH] kexec:ppc: Fix compilation failure
Date: Tue, 23 Aug 2011 11:40:40 +0530
Message-ID: <20110823061020.14928.83952.stgit@suzukikp.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Suzuki Poulose <suzuki@in.ibm.com>, Josh Boyer <jwboyer@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

commit 1ea7cfd435aba0e095886db367e9616271f56c28 broke the ppc build as it removes
the declaration for two variables in use by the elf_ppc_load(). This patch reverts
the particular hunk.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Reported-by: Josh Boyer <jwboyer@gmail.com>
---

 kexec/arch/ppc/kexec-elf-ppc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 39f1833..314eb1e 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -187,6 +187,8 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 	char *fixup_nodes[FIXUP_ENTRYS + 1];
 	int cur_fixup = 0;
 	int opt;
+	char *blob_buf = NULL;
+	off_t blob_size = 0;
 
 	command_line = NULL;
 	dtb = NULL;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
