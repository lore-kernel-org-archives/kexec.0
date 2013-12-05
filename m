Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VoeZc-0003AG-EI
 for kexec@lists.infradead.org; Thu, 05 Dec 2013 19:26:57 +0000
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 6 Dec 2013 05:26:25 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9405C3578054
 for <kexec@lists.infradead.org>; Fri,  6 Dec 2013 06:25:38 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB5JPPsC6881722
 for <kexec@lists.infradead.org>; Fri, 6 Dec 2013 06:25:26 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB5JPbQt002820
 for <kexec@lists.infradead.org>; Fri, 6 Dec 2013 06:25:37 +1100
Subject: [PATCH] kexec: Fix add_usable_memory to use buf of type uint64_t.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 06 Dec 2013 00:55:30 +0530
Message-ID: <20131205192530.1961.78838.stgit@mars>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Kexec-ml <kexec@lists.infradead.org>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

A switchover from /kexec/arch/ppc64/fs2dt.c to common code under
/kexec/fs2dt.c broke the kdump on ppc64. The function add_usable_memory()
assumes that 'memory@*' node exports two 32bit values and fails
to populate mem ranges correctly. On ppc64, 'memory@*' exports two 64bit
values as below:

# hexdump /proc/device-tree/memory\@0/reg
0000000 0000 0000 0000 0000 0000 0000 0800 0000
0000010
#

This patch fixes add_usable_memory() to use buf[2] of type uint64_t.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 kexec/fs2dt.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 5d774ae..7202dc1 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -285,8 +285,8 @@ static void add_dyn_reconf_usable_mem_property(struct dirent *dp, int fd) {}
 static void add_usable_mem_property(int fd, size_t len)
 {
 	char fname[MAXPATH], *bname;
-	uint32_t buf[2];
-	uint32_t *ranges;
+	uint64_t buf[2];
+	uint64_t *ranges;
 	int ranges_size = MEM_RANGE_CHUNK_SZ;
 	uint64_t base, end, loc_base, loc_end;
 	size_t range;
@@ -311,8 +311,8 @@ static void add_usable_mem_property(int fd, size_t len)
 
 	if (~0ULL - buf[0] < buf[1])
 		die("unrecoverable error: mem property overflow\n");
-	base = be32_to_cpu(buf[0]);
-	end = base + be32_to_cpu(buf[1]);
+	base = be64_to_cpu(buf[0]);
+	end = base + be64_to_cpu(buf[1]);
 
 	ranges = malloc(ranges_size * sizeof(*ranges));
 	if (!ranges)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
