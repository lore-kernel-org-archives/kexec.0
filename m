Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JXEaU-0003wH-KV
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 11:48:39 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m26Bob3p019326
	for <kexec@lists.infradead.org>; Thu, 6 Mar 2008 06:50:37 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m26Bmbuq250976
	for <kexec@lists.infradead.org>; Thu, 6 Mar 2008 06:48:37 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m26BmbY2022554
	for <kexec@lists.infradead.org>; Thu, 6 Mar 2008 06:48:37 -0500
Date: Thu, 6 Mar 2008 17:18:34 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: Kexec support for PS3 (ppc64)
Message-ID: <20080306114834.GO32366@in.ibm.com>
References: <20080306111122.GN32366@in.ibm.com>
	<C5065F118AFB3D478B052FC1E9810D9CA9035D@tec-mail.ttec.soc-soft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <C5065F118AFB3D478B052FC1E9810D9CA9035D@tec-mail.ttec.soc-soft.com>
Reply-To: mohan@in.ibm.com
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
To: Rajasekaran Periyasamy <rajasekaran.periyasamy@toshiba-tesi.com>
Cc: kexec@lists.infradead.org

On Thu, Mar 06, 2008 at 04:55:04PM +0530, Rajasekaran Periyasamy wrote:
> Hi,
> I put a printk() in the early lines of early_parse_crashk() with
> KERN_EMERG, but not able to see that on the boot screen. I think the
> control is not transferred to early_parse_crashk() at all. With out this
> "crashkernel" argument, the same kernel boots up properly. 

Looks strange.

Could you please include more debug printks in the function
do_early_param in init/main.c to check whether early_parse_crashk is
called or not?

How do you boot the kernel, by yaboot or kboot?

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
