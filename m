Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W6eLb-0002xn-Ei
 for kexec@lists.infradead.org; Fri, 24 Jan 2014 10:50:52 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 24 Jan 2014 10:50:26 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0C45F1B08070
 for <kexec@lists.infradead.org>; Fri, 24 Jan 2014 10:49:51 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0OAoC1t66715822
 for <kexec@lists.infradead.org>; Fri, 24 Jan 2014 10:50:12 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0OAoO8P026563
 for <kexec@lists.infradead.org>; Fri, 24 Jan 2014 03:50:24 -0700
Subject: [PATCH] kexec/ppc64 fix device tree endianess issues for memory
 attributes
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 24 Jan 2014 11:50:22 +0100
Message-ID: <20140124105022.3624.88815.stgit@nimbus>
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
To: horms@verge.net.au, kexec@lists.infradead.org

The memory configuration and initrd values exposed in the device tree are in
big endian format and should be swapped when running in little endian mode.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c |    5 +++--
 kexec/arch/ppc64/kexec-ppc64.c     |   10 ++++++----
 kexec/fs2dt.c                      |    7 ++++---
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index e31dd6d..65ad65a 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -252,8 +252,9 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 				goto err;
 			}
 
-			start = ((unsigned long long *)buf)[0];
-			end = start + ((unsigned long long *)buf)[1];
+			start = be64_to_cpu(((unsigned long long *)buf)[0]);
+			end = start +
+				be64_to_cpu(((unsigned long long *)buf)[1]);
 			if (start == 0 && end >= (BACKUP_SRC_END + 1))
 				start = BACKUP_SRC_END + 1;
 
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index af9112b..5ead9c5 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -278,8 +278,8 @@ static int get_base_ranges(void)
 				if (realloc_memory_ranges() < 0)
 					break;
 			}
-			start = ((uint64_t *)buf)[0];
-			end = start + ((uint64_t *)buf)[1];
+			start =  be64_to_cpu(((uint64_t *)buf)[0]);
+			end = start + be64_to_cpu(((uint64_t *)buf)[1]);
 			add_base_memory_range(start, end);
 			fclose(file);
 		}
@@ -492,6 +492,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 					perror(fname);
 					goto error_openfile;
 				}
+				initrd_start = be64_to_cpu(initrd_start);
 				fclose(file);
 
 				memset(fname, 0, sizeof(fname));
@@ -511,6 +512,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 					perror(fname);
 					goto error_openfile;
 				}
+				initrd_end = be64_to_cpu(initrd_end);
 				fclose(file);
 
 				/* Add initrd address to exclude_range */
@@ -568,8 +570,8 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_openfile;
 			}
-			rmo_base = ((uint64_t *)buf)[0];
-			rmo_top = rmo_base + ((uint64_t *)buf)[1];
+			rmo_base = be64_to_cpu(((uint64_t *)buf)[0]);
+			rmo_top = rmo_base + be64_to_cpu(((uint64_t *)buf)[1]);
 			if (rmo_top > 0x30000000UL)
 				rmo_top = 0x30000000UL;
 
diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 7202dc1..80d41fa 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -309,10 +309,11 @@ static void add_usable_mem_property(int fd, size_t len)
 		die("unrecoverable error: error reading \"%s\": %s\n",
 		    pathname, strerror(errno));
 
-	if (~0ULL - buf[0] < buf[1])
-		die("unrecoverable error: mem property overflow\n");
 	base = be64_to_cpu(buf[0]);
-	end = base + be64_to_cpu(buf[1]);
+	end = be64_to_cpu(buf[1]);
+	if (~0ULL - base < end)
+		die("unrecoverable error: mem property overflow\n");
+	end += base;
 
 	ranges = malloc(ranges_size * sizeof(*ranges));
 	if (!ranges)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
