Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R8Avw-0000MQ-P8
	for kexec@lists.infradead.org; Mon, 26 Sep 2011 13:09:21 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8QD9Aws024653
	for <kexec@lists.infradead.org>; Mon, 26 Sep 2011 13:09:10 GMT
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8QD99GV2355452
	for <kexec@lists.infradead.org>; Mon, 26 Sep 2011 14:09:09 +0100
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8QD99FX004034
	for <kexec@lists.infradead.org>; Mon, 26 Sep 2011 14:09:09 +0100
Subject: kexec: load-preserve-context option on s390
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Mon, 26 Sep 2011 15:09:09 +0200
Message-ID: <1317042549.3157.9.camel@br98xy6r>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, ying.huang@intel.com

Hello Simon,

I think the --load-preserve-context and --load-jump-back-helper kexec
options are not working on s390 because we do not support
CONFIG_KEXEC_JUMP. I assume the same is true also on other
architectures. Correct me, if I am wrong. Unfortunately I did not find
much documentation for that feature.

Wouldn't it be better to print an error message when the options are
used on those architectures?

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
