Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PxIJ3-0003Ue-H0
	for kexec@lists.infradead.org; Wed, 09 Mar 2011 12:15:58 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p29CFo2V028735
	for <kexec@lists.infradead.org>; Wed, 9 Mar 2011 23:15:50 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p29CFo382539678
	for <kexec@lists.infradead.org>; Wed, 9 Mar 2011 23:15:50 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p29CFolp024125
	for <kexec@lists.infradead.org>; Wed, 9 Mar 2011 23:15:50 +1100
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH] makedumpfile: Copy correct nr_cpus info to dumpfile during
	re-filtering
Date: Wed, 09 Mar 2011 17:45:48 +0530
Message-ID: <20110309121506.13403.73845.stgit@mars.in.ibm.com>
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
To: kexec@lists.infradead.org, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Dave Anderson <anderson@redhat.com>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

During re-filtering nr_cpus is to 0 in the o/p dumpfile and hence crash
utility fails to open the re-filtered dumpfile.

This patch fixes this issue by copying nr_cpus info from kdump-compressed
dumpfile to info->nr_cpus which then get's correctly copied to o/p
dumpfile.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---

 makedumpfile.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index a0fad6a..7d0c663 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -924,6 +924,7 @@ get_kdump_compressed_header_info(char *filename)
 		goto error;
 	}
 	memcpy(info->kh_memory, &kh, sizeof(kh));
+	info->nr_cpus = dh.nr_cpus;
 
 	if (dh.header_version >= 3) {
 		/* A dumpfile contains vmcoreinfo data. */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
