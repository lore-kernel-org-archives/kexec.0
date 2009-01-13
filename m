Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LMawi-0000rq-JJ
	for kexec@lists.infradead.org; Tue, 13 Jan 2009 04:32:23 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0D4Ujqb013688
	for <kexec@lists.infradead.org>; Mon, 12 Jan 2009 23:30:45 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0D4W7TN169044
	for <kexec@lists.infradead.org>; Mon, 12 Jan 2009 23:32:07 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0D4W72u014470
	for <kexec@lists.infradead.org>; Mon, 12 Jan 2009 23:32:07 -0500
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: newbie question: kexec linux-based bootstrap
Date: Tue, 13 Jan 2009 10:02:03 +0530
References: <F795765B112E7344AF36AA911279641508F6AFCB@xmb-sjc-212.amer.cisco.com>
	<496BCA08.4000901@oracle.com>
	<F795765B112E7344AF36AA911279641508F6B42E@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <F795765B112E7344AF36AA911279641508F6B42E@xmb-sjc-212.amer.cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200901131002.03658.mohan@in.ibm.com>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Sven Anders <anders@anduras.de>, "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>


> # ./kexec -e -append="root/dev/sdb2"
> Memory for crashkernel is not reserved
> Please reserve memory by passing "crashkernel=X@Y" parameter to the
> kernel
> Then try loading kdump kernel

kexec -e does not take any parameter. Just run "kexec -e" which should start 
booting the new kernel.

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
