Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qm3gk-0006TX-Ol
	for kexec@lists.infradead.org; Wed, 27 Jul 2011 12:58:16 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6RCw8tT025134
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 12:58:08 GMT
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
	[9.149.37.229])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6RCw8oQ2449626
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 13:58:08 +0100
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6RCw713001558
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 06:58:08 -0600
Message-Id: <20110727125504.491183728@linux.vnet.ibm.com>
Date: Wed, 27 Jul 2011 14:55:04 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v2 00/10] kdump: Patch series for s390 support (version 2)
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

To make progress and for getting at least the "standard" kdump port upstream
soon, I send you now the updated patch series that contain the s390 kdump port
without stand-alone dump support. The support for stand-alone dump tools
can be added later.

Main changes compared to version 1:
1. We use purgatory code
2. We use pre-allocated ELF core header
3. Registers are saved in old kernel
4. Removed meminfo

The following patches are most interesting for you:
[1-4] Common code changes
[9]   S390 kdump kernel backend
[10]  S390 kdump kexec-tools backend

Patches 5-8 are s390 specific preparation patches for the kdump port.

I hope we will make progress.
Thanks!

Michael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
