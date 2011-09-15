Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R47tD-0007d2-C1
	for kexec@lists.infradead.org; Thu, 15 Sep 2011 09:05:48 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8F95jKs021918
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 09:05:45 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8F95igI2228294
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 10:05:44 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8F95hJ6026404
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 03:05:44 -0600
Message-Id: <20110915090440.063421605@linux.vnet.ibm.com>
Date: Thu, 15 Sep 2011 11:04:40 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v3 0/2] kdump: Allow removal of page tables for crashkernel
	memory
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com, akpm@linux-foundation.org
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek, Andrew, Martin

Here the version 3 patch series for the removal of page tables for the
crashkernel memory:

[1] kdump: Add infrastructure for unmapping crashkernel memory
[2] s390: Add architecture code for unmapping crashkernel memory

Changes to version 2: Use resource_size()

The patches apply on top of the last kdump patch series that I sent.

I would suggest that Martin sends the patches together with the other s390
kdump patches in the next merge window.

Michael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
