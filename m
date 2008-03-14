Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([59.145.155.2] helo=e28esmtp02.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ja62O-0007az-OF
	for kexec@lists.infradead.org; Fri, 14 Mar 2008 09:17:20 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id m2E9H0Gn016965
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 14:47:00 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2E9H0HW1171662
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 14:47:00 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m2E9H0dl013119
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 09:17:00 GMT
Message-ID: <47DA428C.3040608@in.ibm.com>
Date: Fri, 14 Mar 2008 14:47:00 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: [PATCH] x86_64 purgatory Makefile typo fix.
Content-Type: multipart/mixed; boundary="------------070802080300050605000309"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

This is a multi-part message in MIME format.
--------------070802080300050605000309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

While trying to test latest kexec tools git code on a x86_64
box i ran into following issue. Kexec refused to load both
kexec and kdump kernels.

# ./build/sbin/kexec -l /boot/vmlinuz-2.6.25-rc5 --initrd=/boot/initrd-2.6.25-rc5 
Symbol: entry32_regs not found cannot get

#
# ./build/kexec -p /boot/vmlinux-kdump --initrd=/boot/initrd-kdump
 --append="...."
Symbol: entry64_regs not found cannot get

#

It turns out that entry64.S file under purgatory/arch/x86_64 was not
compiled. The original x86_64_PURGATORY_SRCS were being overwritten
in the Makefile.

Here is a patch to fix this issue. 

Thanks
-Sachin


--------------070802080300050605000309
Content-Type: text/x-patch;
	name="kexec-tools-x86_64_purgatory_makefile_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="kexec-tools-x86_64_purgatory_makefile_fix.patch"

* This patch fixes a typo in x86_64 purgatory makefile

Signed Off By : Sachin Sant (sachinp@in.ibm.com)
---


diff -Naurp old/purgatory/arch/x86_64/Makefile new/purgatory/arch/x86_64/Makefile
--- old/purgatory/arch/x86_64/Makefile	2008-03-07 11:18:10.000000000 +0530
+++ new/purgatory/arch/x86_64/Makefile	2008-03-14 14:24:50.000000000 +0530
@@ -14,7 +14,7 @@ dist += purgatory/arch/x86_64/Makefile $
 	purgatory/arch/x86_64/purgatory-x86_64.h
 
 # Done add sources in i386/ to dist, as i386/Makefile adds them
-x86_64_PURGATORY_SRCS =  purgatory/arch/i386/entry32-16.S
+x86_64_PURGATORY_SRCS +=  purgatory/arch/i386/entry32-16.S
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/entry32-16-debug.S
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/crashdump_backup.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/console-x86.c

--------------070802080300050605000309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------070802080300050605000309--

