Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QuPvD-0000KI-Hg
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 14:19:44 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7JEJfSv000614
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 14:19:41 GMT
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7JEJfnI1499284
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 15:19:41 +0100
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7JEJe9r017200
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 08:19:40 -0600
Message-Id: <20110819141857.052232873@linux.vnet.ibm.com>
Date: Fri, 19 Aug 2011 16:18:57 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 0/2] kdump: Common code changes for s390 kdump support
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org, vgoyal@redhat.com

Hello Andrew,

I had a long discussion with Vivek Goyal on the s390 kdump support (thanks
Vivek for all the time!). As a result of this, here are two common code
patches that are required for the s390 port. Could you please integrate them
upstream in the next merge window? The s390 specific part will be integrated
by our s390 maintainer Martin Schwidefsky.

I will be on vacation for the next two weeks. Therefore if you have comments
or questions, please contact also Martin Schwidefsky and Heiko Carstens.

Thanks

   Michael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
