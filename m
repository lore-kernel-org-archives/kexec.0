Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout1.samsung.com ([203.254.224.24])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IKw4P-0004AK-U7
	for kexec@lists.infradead.org; Tue, 14 Aug 2007 09:04:31 -0400
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0JMR007T7LMZ12@mailout1.samsung.com> for
	kexec@lists.infradead.org; Tue, 14 Aug 2007 22:04:12 +0900 (KST)
Received: from [107.108.71.71] by mmp1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTPA id <0JMR00KV4LN5L5@mmp1.samsung.com> for
	kexec@lists.infradead.org; Tue, 14 Aug 2007 22:04:18 +0900 (KST)
Date: Tue, 14 Aug 2007 18:41:54 +0530
From: Indraneel <indraneel.m@samsung.com>
Subject: Kdump for ARM (vmcore generation problem)
Message-id: <46C1AA1A.6050907@samsung.com>
MIME-version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,
I'm trying to make Kdump work for ARM. Till now i've managed to get the 
/dev/oldmem interface working for taking dumps. Now i want to get the 
/proc/vmcore interface working.
I'm unclear how to generate the elfcore headers required by routines in 
vmcore.c.

TIA,
Indro

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
