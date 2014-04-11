Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYYQN-0002BR-05
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 10:11:08 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 11 Apr 2014 11:10:36 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3631417D8047
 for <kexec@lists.infradead.org>; Fri, 11 Apr 2014 11:11:27 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3BAAWkL51642378
 for <kexec@lists.infradead.org>; Fri, 11 Apr 2014 10:10:32 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3BAAWtt007656
 for <kexec@lists.infradead.org>; Fri, 11 Apr 2014 04:10:33 -0600
Subject: [PATCH] kexec/fs2dt : Fix endianess issue with initrd base and size
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 11 Apr 2014 12:10:30 +0200
Message-ID: <20140411101030.8033.95615.stgit@nimbus>
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
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

The initrd values exposed in the device tree of the kexeced kernel must be
encoded in Big Endian format.

Without this patch, kexeced LE kernel are expected to panic when dealing
with the initrd image.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 kexec/fs2dt.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 5e6b98d..2a90979 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -531,7 +531,7 @@ static void putnode(void)
 	/* Add initrd entries to the second kernel */
 	if (initrd_base && initrd_size && !strcmp(basename,"chosen/")) {
 		int len = 8;
-		unsigned long long initrd_end;
+		uint64_t bevalue;
 
 		dt_reserve(&dt, 12); /* both props, of 6 words ea. */
 		*dt++ = cpu_to_be32(3);
@@ -539,7 +539,8 @@ static void putnode(void)
 		*dt++ = cpu_to_be32(propnum("linux,initrd-start"));
 		pad_structure_block(len);
 
-		memcpy(dt,&initrd_base,len);
+		bevalue = cpu_to_be64(initrd_base);
+		memcpy(dt, &bevalue, len);
 		dt += (len + 3)/4;
 
 		len = 8;
@@ -547,10 +548,10 @@ static void putnode(void)
 		*dt++ = cpu_to_be32(len);
 		*dt++ = cpu_to_be32(propnum("linux,initrd-end"));
 
-		initrd_end = initrd_base + initrd_size;
+		bevalue = cpu_to_be64(initrd_base + initrd_size);
 		pad_structure_block(len);
 
-		memcpy(dt,&initrd_end,len);
+		memcpy(dt, &bevalue, len);
 		dt += (len + 3)/4;
 
 		reserve(initrd_base, initrd_size);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
