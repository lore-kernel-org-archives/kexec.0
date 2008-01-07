Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp01.in.ibm.com ([59.145.155.1])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JBooH-0005hL-5I
	for kexec@lists.infradead.org; Mon, 07 Jan 2008 10:02:39 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id m07A26Yw028618
	for <kexec@lists.infradead.org>; Mon, 7 Jan 2008 15:32:06 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m07A26SE807120
	for <kexec@lists.infradead.org>; Mon, 7 Jan 2008 15:32:06 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id m07A25rE001200
	for <kexec@lists.infradead.org>; Mon, 7 Jan 2008 10:02:06 GMT
Date: Mon, 7 Jan 2008 15:32:02 +0530
From: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Subject: Re: kexec refuses to boot latest -mm
Message-ID: <20080107100202.GB30865@linux.vnet.ibm.com>
References: <20071228124532.GB32643@linux.vnet.ibm.com>
	<20071231150843.GB27060@redhat.com>
	<20080103195201.GC6392@linux.vnet.ibm.com>
	<200801032242.01425.rjw@sisk.pl>
	<20080104122816.GF4514@linux.vnet.ibm.com>
	<20080104155415.GC6007@linux.vnet.ibm.com>
	<20080106133729.GB2481@elte.hu>
	<20080107091838.GA30865@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080107091838.GA30865@linux.vnet.ibm.com>
Reply-To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: maneesh@linux.vnet.ibm.com, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, hbabu@us.ibm.com, hpa@zytor.com, Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

> commit 7dd838ea7afa42a8840cf0e262d5892346ecf379
> Author: H. Peter Anvin <hpa@zytor.com>
> Date:   Sat Jan 5 13:27:04 2008 +0100
> 

sorry, forgot the subject, it is

	i386: handle an initrd in highmem

-- 
regards,
Dhaval

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
