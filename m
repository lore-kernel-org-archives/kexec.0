Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KnyTN-0005R5-0K
	for kexec@lists.infradead.org; Thu, 09 Oct 2008 16:34:45 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id m99GVsDl003645
	for <kexec@lists.infradead.org>; Thu, 9 Oct 2008 12:31:54 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m99GYSCh1863778
	for <kexec@lists.infradead.org>; Thu, 9 Oct 2008 12:34:28 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m99GYP9b014773
	for <kexec@lists.infradead.org>; Thu, 9 Oct 2008 10:34:25 -0600
Message-ID: <48EE3288.7080105@in.ibm.com>
Date: Thu, 09 Oct 2008 22:04:16 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix kdump kernel hang issue with relocatable kernel
	patches
References: <20081001182501.GA20319@in.ibm.com>
	<18669.38794.476429.103254@cargo.ozlabs.ibm.com>
In-Reply-To: <18669.38794.476429.103254@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org

Paul Mackerras wrote:

> 
> Hmmm.  Is there any reason to continue to support non-relocatable
> 64-bit kernels being kdump kernels?  In other words, for 64-bit,
> couldn't we make CONFIG_CRASH_DUMP depend on CONFIG_RELOCATABLE?

We wanted to support legacy kdump feature on 64 bit kernels for some 
time. But if nobody needs the legacy kdump, we can make kdump depend on 
relocatable

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
