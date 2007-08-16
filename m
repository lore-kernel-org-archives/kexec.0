Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1ILVdG-0000aI-Vk
	for kexec@lists.infradead.org; Wed, 15 Aug 2007 23:02:48 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7G32cE1031074
	for <kexec@lists.infradead.org>; Wed, 15 Aug 2007 23:02:38 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7G32c1T522052
	for <kexec@lists.infradead.org>; Wed, 15 Aug 2007 23:02:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7G32cub024954
	for <kexec@lists.infradead.org>; Wed, 15 Aug 2007 23:02:38 -0400
Date: Thu, 16 Aug 2007 08:32:51 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Kdump for ARM (vmcore generation problem)
Message-ID: <20070816030251.GA20860@in.ibm.com>
References: <46C1AA1A.6050907@samsung.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46C1AA1A.6050907@samsung.com>
Reply-To: vgoyal@in.ibm.com
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
To: Indraneel <indraneel.m@samsung.com>
Cc: kexec@lists.infradead.org

On Tue, Aug 14, 2007 at 06:41:54PM +0530, Indraneel wrote:
> Hi,
> I'm trying to make Kdump work for ARM. Till now i've managed to get the 
> /dev/oldmem interface working for taking dumps. Now i want to get the 
> /proc/vmcore interface working.
> I'm unclear how to generate the elfcore headers required by routines in 
> vmcore.c.
> 

Hi Indraneel,

kexec-tools in user space generates those headers. Have a loot at
kexec-tools code.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
