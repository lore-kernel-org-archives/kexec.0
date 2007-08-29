Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.18.162])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IQL6f-0004rj-4z
	for kexec@lists.infradead.org; Wed, 29 Aug 2007 06:49:11 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id l7T8t6Jb030559
	for <kexec@lists.infradead.org>; Wed, 29 Aug 2007 18:55:06 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7T8wQJU146256
	for <kexec@lists.infradead.org>; Wed, 29 Aug 2007 18:58:27 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7T9sqNJ023272
	for <kexec@lists.infradead.org>; Wed, 29 Aug 2007 19:54:52 +1000
Message-ID: <46D532E6.2020708@linux.vnet.ibm.com>
Date: Wed, 29 Aug 2007 14:18:38 +0530
From: Subrata Modak <subrata@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: LTP-KDUMP Test Plan
Content-Type: multipart/mixed; boundary="------------010807080803080503040909"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: ltp-list@lists.sourceforge.net
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010807080803080503040909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please find attached the Tentative LTP-KDUMP Test case Plan, depicting 
the future work that will be done on LTP-KDUMP.
Regards--
Subrata

--------------010807080803080503040909
Content-Type: text/plain;
 name="TEST_PLAN.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="TEST_PLAN.txt"

Following is the Tentative plan for improving LTP-KDUMP Test-cases:

===========================================================================================================
||S.NO||                 ACTIVITY                                               ||  TENTATIVE-TIME       ||
===========================================================================================================
|| 1  ||      Test and integrate kdump's netdump patch to LTP                   ||   SEP/OCT-2007        ||
|| 2  ||      Modify ltp-kdump to automate all usecases of                      ||   SEP/OCT-2007        ||
||    ||        kdump-network dumping usecases                                  ||                       ||
|| 3  ||      Enhance error handler for kdump test                              ||   OCT/NOV-2007        ||
||    ||        automation script                                               ||                       ||
|| 4  ||      Enhance result analysis module of ltp-kdump                       ||   OCT/NOV-2007        ||
===========================================================================================================


--------------010807080803080503040909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------010807080803080503040909--

