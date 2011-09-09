Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R1yJ8-0007rA-PJ
	for kexec@lists.infradead.org; Fri, 09 Sep 2011 10:27:41 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p89ARYkh001382
	for <kexec@lists.infradead.org>; Fri, 9 Sep 2011 10:27:34 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p89ARXTY1298454
	for <kexec@lists.infradead.org>; Fri, 9 Sep 2011 11:27:34 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p89ARX7G026206
	for <kexec@lists.infradead.org>; Fri, 9 Sep 2011 04:27:33 -0600
Message-Id: <20110909102659.320220628@linux.vnet.ibm.com>
Date: Fri, 09 Sep 2011 12:26:59 +0200
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
To: vgoyal@redhat.com
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

Another patch that we would like to have upstream is the vmcoreinfo
note intitialization. This is independent from the s390 kdump port.
We need that for our traditional stand-alone and hypervisor dump
tools. You already have agreed that the patch looks ok:
https://lkml.org/lkml/2011/7/20/296

So could we get an ACK from you for the patch?

[1] kdump: Initialize vmcoreinfo note at startup
[2] s390: Export vmcoreinfo note

Thanks!

Michael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
