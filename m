Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp01.in.ibm.com ([59.145.155.1] helo=e28esmtp01.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KOAM4-0003JO-Fq
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 12:00:33 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id m6UC0SIi003296
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 17:30:28 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6UC0QND1392748
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 17:30:26 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id m6UC0Qg7030262
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 17:30:27 +0530
Date: Wed, 30 Jul 2008 17:30:26 +0530
From: Ankita Garg <ankita@in.ibm.com>
Subject: RT-based kdump kernel hangs on multiple hardware
Message-ID: <20080730120026.GA30011@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Reply-To: Ankita Garg <ankita@in.ibm.com>
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
Cc: Darren Hart <dvhltc@us.ibm.com>, Sripathi Kodi <sripathik@in.ibm.com>, Chirag Jog <chirag@linux.vnet.ibm.com>, "Sachin P. Sant" <sachinp@in.ibm.com>, Maneesh Soni <maneesh@in.ibm.com>, Dinakar Guniguntala <dino@in.ibm.com>

Hi,

We have been facing a number of kdump issues on quite a few of our
hardware. These are with RT kernel as the kdump kernel. Inorder to keep
discussion about each hardware separate, sending separate mails for each
as part of the same thread.

Pl let me know if I need to provide more information. Any ideas on what
could be going wrong or how it can be fixed?

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
