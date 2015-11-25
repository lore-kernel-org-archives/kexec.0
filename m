Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1ZUX-000060-QC
 for kexec@lists.infradead.org; Wed, 25 Nov 2015 12:48:14 +0000
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 12:47:45 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B09C217D8062
 for <kexec@lists.infradead.org>; Wed, 25 Nov 2015 12:48:08 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAPClhHI51052566
 for <kexec@lists.infradead.org>; Wed, 25 Nov 2015 12:47:43 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAPClgQg009638
 for <kexec@lists.infradead.org>; Wed, 25 Nov 2015 05:47:43 -0700
Date: Wed, 25 Nov 2015 13:47:41 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH] kexec: fix mmap return code handling
Message-ID: <20151125134741.55c7e21c@holzheu>
Mime-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: stefan.roscher@de.ibm.com, kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>

Hi Simon,

I made a mistake in my mmap patch, sorry for that!

When mmap fails, MAP_FAILED (that is, (void *) -1) is returned. Currently
we assume that NULL is returned. Fix this and add the MAP_FAILED check.

Fixes: 95741713e790 ("kexec/s390x: use mmap instead of read for slurp_file")
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kexec/kexec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index cf6e03d..02285fb 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -568,6 +568,8 @@ static char *slurp_file_generic(const char *filename, off_t *r_size,
 		if (use_mmap) {
 			buf = mmap(NULL, size, PROT_READ|PROT_WRITE,
 				   MAP_PRIVATE, fd, 0);
+			if (buf == MAP_FAILED)
+				buf = NULL;
 			nread = size;
 		} else {
 			buf = slurp_fd(fd, filename, size, &nread);
-- 
2.3.9


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
