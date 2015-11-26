Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp09.uk.ibm.com ([195.75.94.105])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a20Pj-0007ru-Jp
 for kexec@lists.infradead.org; Thu, 26 Nov 2015 17:33:00 +0000
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 17:32:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 35CEA1B0805F
 for <kexec@lists.infradead.org>; Thu, 26 Nov 2015 17:32:57 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAQHWXVY9765212
 for <kexec@lists.infradead.org>; Thu, 26 Nov 2015 17:32:33 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAQHWXHa014254
 for <kexec@lists.infradead.org>; Thu, 26 Nov 2015 10:32:33 -0700
Date: Thu, 26 Nov 2015 18:32:31 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH v2] kexec: fix mmap return code handling
Message-ID: <20151126183231.33da064b@holzheu>
In-Reply-To: <20151125134741.55c7e21c@holzheu>
References: <20151125134741.55c7e21c@holzheu>
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
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, stefan.roscher@de.ibm.com

Hi Simon again,

After a bit more thinking: In theory mmap() could also return NULL.
Therefore the following fix is probably the better one ...
---
Subject: [PATCH] kexec: fix mmap return code handling

When mmap fails, MAP_FAILED (that is, (void *) -1) is returned. Currently
we assume that NULL is returned. Fix this and add the MAP_FAILED check.

Fixes: 95741713e790 ("kexec/s390x: use mmap instead of read for slurp_file")
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

diff --git a/kexec/kexec.c b/kexec/kexec.c
index cf6e03d..f0bd527 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -573,7 +573,7 @@ static char *slurp_file_generic(const char *filename, off_t *r_size,
 			buf = slurp_fd(fd, filename, size, &nread);
 		}
 	}
-	if (!buf)
+	if ((use_mmap && (buf == MAP_FAILED)) || (!use_mmap && (buf == NULL)))
 		die("Cannot read %s", filename);
 
 	if (nread != size)
-- 
2.3.9


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
