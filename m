Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S3Omh-0001Me-Fq
 for kexec@lists.infradead.org; Fri, 02 Mar 2012 09:28:20 +0000
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hanpt@linux.vnet.ibm.com>;
 Fri, 2 Mar 2012 04:28:15 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2F6B738C8054
 for <kexec@lists.infradead.org>; Fri,  2 Mar 2012 04:28:02 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q229S2u8293936
 for <kexec@lists.infradead.org>; Fri, 2 Mar 2012 04:28:02 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q229S1Vs021065
 for <kexec@lists.infradead.org>; Fri, 2 Mar 2012 04:28:01 -0500
Date: Fri, 2 Mar 2012 17:28:39 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Subject: [PATCH] remove useless call to setup_memory_ranges() in ppc64
Message-ID: <20120302092839.GA25155@hpt.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, sharada@in.ibm.com

setup_memory_ranges() is being called twice in ppc64. First in my_load()
through get_memory_ranges(), then in elf_ppc64_load(). Looks like we can
remove the latter.
---
 kexec/arch/ppc64/kexec-elf-ppc64.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index ab6da7c..abd83dd 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -149,8 +149,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	if (ramdisk && reuse_initrd)
 		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
 
-	setup_memory_ranges(info->kexec_flags);
-
 	/* Need to append some command line parameters internally in case of
 	 * taking crash dumps.
 	 */
-- 
1.7.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
