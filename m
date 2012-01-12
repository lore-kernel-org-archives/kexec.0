Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RlMKc-0001zU-T3
 for kexec@lists.infradead.org; Thu, 12 Jan 2012 15:12:47 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 12 Jan 2012 15:12:38 -0000
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0CFCYrV2412582
 for <kexec@lists.infradead.org>; Thu, 12 Jan 2012 15:12:34 GMT
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0CFCYH6012611
 for <kexec@lists.infradead.org>; Thu, 12 Jan 2012 08:12:34 -0700
Received: from [9.152.212.23] (dyn-9-152-212-23.boeblingen.de.ibm.com
 [9.152.212.23])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 q0CFCYcs012593
 for <kexec@lists.infradead.org>; Thu, 12 Jan 2012 08:12:34 -0700
Message-ID: <1326381154.2729.1.camel@br98xy6r>
Subject: [PATCH] makedumpfile: Compile fix
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2012 16:12:34 +0100
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

When compiling makedumpfile git head or 1.4.1 on s390x, I get the following
gcc error:

 # gcc -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
 -D_LARGEFILE64_SOURCE -DVERSION='"1.4.1"' -DRELEASE_DATE='"6 January 2012"'
 -D__s390__  print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o
 arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o arch/ppc64.o arch/s390x.o -o
 makedumpfile makedumpfile.c -static -ldw -lbz2 -lebl -ldl -lelf -lz
 In file included from makedumpfile.c:21:0:
 sadump_info.h:86:1: error: expected identifier or '(' before '{' token
 sadump_info.h:85:19: warning: 'sadump_num_online_cpus' used but never defined

The attached patch fixes this problem.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 sadump_info.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sadump_info.h
+++ b/sadump_info.h
@@ -82,7 +82,7 @@ static inline int sadump_initialize_bitm
 	return FALSE;
 }
 
-static inline int sadump_num_online_cpus(void);
+static inline int sadump_num_online_cpus(void)
 {
 	return 0;
 }



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
