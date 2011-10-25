Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RIkcs-0003xh-Vv
	for kexec@lists.infradead.org; Tue, 25 Oct 2011 17:17:24 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9PHHIqD027446
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 17:17:18 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9PHHHDO2363562
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 18:17:17 +0100
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain
	[127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9PHHHp8018382
	for <kexec@lists.infradead.org>; Tue, 25 Oct 2011 11:17:17 -0600
Message-ID: <1319563037.3056.30.camel@br98xy6r>
Subject: kdump: A memory hotplug issue on s390
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Tue, 25 Oct 2011 19:17:17 +0200
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org

Hello Simon and Vivek,

For s390 we currently use /proc/iomem for defining the memory layout in
the kexec elfcore header. Unfortunately this is not correct, when using
memory hotplug. When a memory chunk is set offline (e.g. with "echo
offline > /sys/devices/system/memory/memoryX/state") this is not
reflected in /proc/iomem.

To fix this I could parse /sys/devices/system/memory and exclude each
memory chunk that in not online from the /proc/iomem info. Do you think
that this approach is fine or is there a better solution?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
