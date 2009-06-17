Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MGtPv-0003Ga-Kg
	for kexec@lists.infradead.org; Wed, 17 Jun 2009 11:35:06 +0000
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5HLWFZ3003828
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 07:32:15 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5HBYpQl499956
	for <kexec@lists.infradead.org>; Wed, 17 Jun 2009 21:34:51 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5HBYpIv026672
	for <kexec@lists.infradead.org>; Wed, 17 Jun 2009 21:34:51 +1000
Date: Wed, 17 Jun 2009 17:04:56 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: [PATCH] Do not inline putprops function
Message-ID: <20090617113456.GC31595@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Reply-To: mohan@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linuxppc-dev@ozlabs.org
Cc: horms@verge.net.au, miltonm@bga.com

Do not inline putprops function

With the recent kexec-tools git tree, both kexec and kdump kernels hang (i.e
kexec -l and kexec -p respectively). This happened after the patch "ppc64:
cleanups" commit b43a84a31a4be6ed025c1bdef3bb1c3c12e01b16. I tried
reverting each hunk and then found out that retaining following lines in
fs2dt.c makes kexec/kdump work.

-static unsigned *dt_len; /* changed len of modified cmdline
-                           in flat device-tree */

[....]

-               dt_len = dt;

I don't have any clue why removing a unused variable would cause the kexec
kernel to hang. After further investigation, I observed that if the putprops
function is not inlined, kexec/kdump kernel would work even after removing
the above lines.

This patch directs gcc to not inline the putprops function. Now we could
invoke kexec and kdump kernels.
---
 kexec/arch/ppc64/fs2dt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index 1f551fd..1e01f74 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -259,7 +259,7 @@ static void add_usable_mem_property(int fd, int len)
 }
 
 /* put all properties (files) in the property structure */
-static void putprops(char *fn, struct dirent **nlist, int numlist)
+__attribute__ ((noinline)) static void putprops(char *fn, struct dirent **nlist, int numlist)
 {
 	struct dirent *dp;
 	int i = 0, fd, len;
-- 
1.6.0.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
