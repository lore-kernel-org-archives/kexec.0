Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ja7zp-0006uX-Gv
	for kexec@lists.infradead.org; Fri, 14 Mar 2008 11:22:46 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2EBMiDZ017581
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 07:22:44 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2EBMiTe392804
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 07:22:44 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2EBMhTc027165
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 07:22:44 -0400
Date: Fri, 14 Mar 2008 16:52:41 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
Message-ID: <20080314112241.GC9643@in.ibm.com>
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>
	<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>
	<47D19114.1090700@am.sony.com>
	<4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>
	<47D6B92D.2020205@am.sony.com> <47D6D406.8050209@am.sony.com>
	<4574cb3d0803140336g59236cf2w7e14405b2dc795a5@mail.gmail.com>
	<20080314110212.GA9643@in.ibm.com>
	<4574cb3d0803140418t41a84b93g9e25694b4c919e74@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4574cb3d0803140418t41a84b93g9e25694b4c919e74@mail.gmail.com>
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
To: Rajasekaran P <rajasekaran83@gmail.com>
Cc: kexec@lists.infradead.org, Geoff Levand <geoffrey.levand@am.sony.com>

On Fri, Mar 14, 2008 at 04:18:52AM -0700, Rajasekaran P wrote:
> Yes,I built this kernel with CRASH_DUMP and VMCORE file system  enabled.
> Moreover, I disabled SMP as well.
> My system kernel is (First kernel) is SMP enabled, does it matter?

It should not matter.

> 
> I dont get any message from dump capture kernel.
> 
> I trigger crash dump using :
> 
> echo c > /proc/sysrq-trigger

While triggering the dump, don't you get any message, like sending IPI
to cpu?

> Initially capture kernel was loaded into 32MB only, but still it was not
> booting. So I tweaked the KDUMP_KERNELBASE macro to load capture kernel to
> 64MB ( My idea is, first 64MB for system kernel and second 64MB for capture
> kernel). Should it be 32MB only?

You can't do that. It should be at 32MB only.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
