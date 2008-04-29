Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([59.145.155.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Jqnmj-0005gH-Tu
	for kexec@lists.infradead.org; Tue, 29 Apr 2008 11:14:24 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id m3TBDUcH005584
	for <kexec@lists.infradead.org>; Tue, 29 Apr 2008 16:43:30 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3TBDOj81089710
	for <kexec@lists.infradead.org>; Tue, 29 Apr 2008 16:43:24 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m3TBDcJ1006448
	for <kexec@lists.infradead.org>; Tue, 29 Apr 2008 11:13:39 GMT
Message-ID: <481702DA.3000009@in.ibm.com>
Date: Tue, 29 Apr 2008 16:43:30 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: Re: kexec/ kdump setup problem
References: <c62583fb0804282045w757bba55v5515bdbb37d5f18c@mail.gmail.com>
In-Reply-To: <c62583fb0804282045w757bba55v5515bdbb37d5f18c@mail.gmail.com>
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
To: Mrunal Gawade <mrunal.gawade@gmail.com>
Cc: kexec@lists.infradead.org

Mrunal Gawade wrote:
> After I execute this command. Should I expect any prompt that kernel 
> loaded successfully?
Check the /sys/kernel/kexec_crash_loaded file. Value "1" means success.

Thanks
-Sachin


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
