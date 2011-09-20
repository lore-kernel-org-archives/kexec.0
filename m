Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R61PF-000754-IW
	for kexec@lists.infradead.org; Tue, 20 Sep 2011 14:34:42 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8KEYbFh022479
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 14:34:37 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8KEYbME2510918
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 15:34:37 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8KEYauI001870
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 08:34:37 -0600
Message-Id: <20110920143400.776127689@linux.vnet.ibm.com>
Date: Tue, 20 Sep 2011 16:34:00 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 0/2] kdump: Initialize vmcoreinfo note at startup
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
To: akpm@linux-foundation.org
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org, vgoyal@redhat.com

Hello Andrew,

Another common code patch that we would like to have upstream is the vmcoreinfo
note initialization at Linux startup time. We need that for our traditional
stand-alone and hypervisor dump tools.

[1] kdump: Initialize vmcoreinfo note at startup
[2] s390: Export vmcoreinfo note

I already have discussed this with Vivek and he has acked the common code
patch [1].

Do you agree that Martin sends these patches together with the kdump page
table patches (see https://lkml.org/lkml/2011/9/15/55) in the next merge
window?

Michael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
