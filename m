Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([59.145.155.3] helo=e28esmtp03.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JFjLY-00051O-9R
	for kexec@lists.infradead.org; Fri, 18 Jan 2008 05:01:00 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m0I50jID000597
	for <kexec@lists.infradead.org>; Fri, 18 Jan 2008 10:30:45 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0I50jsp1081550
	for <kexec@lists.infradead.org>; Fri, 18 Jan 2008 10:30:45 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m0I50lxv008871
	for <kexec@lists.infradead.org>; Fri, 18 Jan 2008 05:00:47 GMT
Message-ID: <47903281.5020508@in.ibm.com>
Date: Fri, 18 Jan 2008 10:30:49 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: Build failure with latest kexec tools git code.
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
Cc: horms@verge.net.au

I came across a build failure with the latest kexec tools git code.
Not sure if something is wrong with my build setup.

[ kexec-tools-git-stable]$ autoconf
[ kexec-tools-git-stable]$ ./configure
checking build system type... i686-pc-linux-gnu
checking host system type... i686-pc-linux-gnu
.......
.......
config.status: creating Makefile
config.status: creating include/config.h
config.status: error: cannot find input file: include/config.h.in

Observed this build failure on i386 as well as ppc64 box.

Thanks
-Sachin




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
