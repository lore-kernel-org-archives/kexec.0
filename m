Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.18.174])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KFvhF-0001Id-BW
	for kexec@lists.infradead.org; Mon, 07 Jul 2008 18:44:22 +0000
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id m67Ihb0x028275
	for <kexec@lists.infradead.org>; Tue, 8 Jul 2008 04:43:37 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67IiHL4266690
	for <kexec@lists.infradead.org>; Tue, 8 Jul 2008 04:44:17 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67IiHis024489
	for <kexec@lists.infradead.org>; Tue, 8 Jul 2008 04:44:17 +1000
From: Chandru <chandru@in.ibm.com>
Subject: [PATCH 0/4] kdump : add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
Date: Tue, 8 Jul 2008 00:14:15 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200807080014.15648.chandru@in.ibm.com>
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
To: kexec@lists.infradead.org, linuxppc-dev@ozlabs.org
Cc: maneesh@in.ibm.com

Following is a patch series that contains changes for kexec/kdump on Power6 
machines. Power6 machines have most of their memory represented 
in /proc/device-tree/ibm,dynamic-reconfiguration-memory node. kexec-tools 
currently read only memory@ nodes of device-tree.  Patch 1/4 contains changes 
in the kernel. Patch {2,3,4}/4 are changes for kexec-tools.  The kernel 
changes are similar to what was earlier present for memory@ nodes 
for 'linux,usable-memory' property.  Unlike memory@ nodes, since now there is 
one node under which most of the memory ranges are represented ( 
ibm,dynamic-memory) , I have appended the lmb entry number to 
the 'linux,usable-memory' string so as to identify usable-memory ranges in 
the device-tree. 

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
