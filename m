Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.18.172])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1LA1YN-00082p-Fv
	for kexec@lists.infradead.org; Tue, 09 Dec 2008 12:19:04 +0000
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id mB9CHZ71009764
	for <kexec@lists.infradead.org>; Tue, 9 Dec 2008 23:17:35 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9CCjTA232498
	for <kexec@lists.infradead.org>; Tue, 9 Dec 2008 23:12:45 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9CCinr020401
	for <kexec@lists.infradead.org>; Tue, 9 Dec 2008 23:12:45 +1100
From: Chandru <chandru@in.ibm.com>
Subject: Re: kdump: quad core Opteron
Date: Tue, 9 Dec 2008 17:42:45 +0530
References: <48EB5B68.8010401@in.ibm.com>
	<200812082126.16680.chandru@in.ibm.com>
	<20081208215432.GH4264@redhat.com>
In-Reply-To: <20081208215432.GH4264@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200812091742.45275.chandru@in.ibm.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: bob.montgomery@hp.com, kexec@lists.infradead.org

On Tuesday 09 December 2008 03:24:32 Vivek Goyal wrote:

> Hi Chandru,
>
> So this patch will solve the issue (at least for /proc/vmcore) even if
> we don't make any changes on kernel side?
>
> Thanks
> Vivek

Hi Vivek,

Yes, without any changes to the kernel and with this patch, we can boot into 
kdump kernel on these quad core Opteron machines and collect a dump. 

thanks,
Chandru

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
