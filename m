Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([59.145.155.2] helo=e28esmtp02.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KiStP-0004Vz-CB
	for kexec@lists.infradead.org; Wed, 24 Sep 2008 11:50:52 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id m8OBol5R020837
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 17:20:47 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8OBnlmh1716332
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 17:19:47 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m8OBnTMq031204
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 21:49:29 +1000
Received: from guara.in.ibm.com ([9.124.35.51])
	by d28av05.in.ibm.com (8.13.1/8.12.11) with ESMTP id m8OBnTpG030328
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 21:49:29 +1000
From: Chandru <chandru@in.ibm.com>
Subject: [PATCH 0/3] kdump: add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
Date: Wed, 24 Sep 2008 17:18:59 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200809241718.59719.chandru@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: kexec@lists.infradead.org

/proc/device-tree on power6 machines has ibm,dynamic-reconfiguration-memory 
node which stores in it the memory representation for most part of the system 
memory. This memory was earlier represented in 'memory@' nodes of the device 
tree.  Following patch series makes kexec-tools aware of this dynamic 
reconfiguration memory node. These patches were sent earlier for RFC. In 
addition to this, a change in the kernel was also required. The kernel change 
has been accepted in powerpc git tree. 
http://git.kernel.org/?p=linux/kernel/git/paulus/powerpc.git;a=commit;h=cf00085d8045cddd80a8aabad97de96fa8131793
Some part of the patch here is re-organization of the existing code to 
accommodate dynamic reconf memory. 

Chandru


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
