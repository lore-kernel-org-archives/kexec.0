Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IGITI-0008A4-SC
	for kexec@lists.infradead.org; Wed, 01 Aug 2007 13:58:59 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l71HwtiE022728
	for <kexec@lists.infradead.org>; Wed, 1 Aug 2007 13:58:56 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id
	l71HwtIu028329
	for <kexec@lists.infradead.org>; Wed, 1 Aug 2007 13:58:55 -0400
Received: from redhat.com (crash.boston.redhat.com [172.16.80.17])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l71HwslP018210
	for <kexec@lists.infradead.org>; Wed, 1 Aug 2007 13:58:54 -0400
Message-ID: <46B0CAFF.50703@redhat.com>
Date: Wed, 01 Aug 2007 14:03:43 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Question re: mem= usage and resultant vmcore
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


> The /proc/vmcore shows 4GB:
> 
>   # ls -l /proc/vmcore
>   -r-------- 1 root root 4164192032 Aug  1 10:57 /proc/vmcore
>   #

I forgot to mention that the resultant, usable, vmcore-incomplete
files are consistently the same size, reflecting the mem=2000m
kernel option:

   # ls -l
   total 435020
   -r-------- 1 root root 1967558656 Aug  1 11:47 vmcore-incomplete
   #

So, is this a bug or a feature?

Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
