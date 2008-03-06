Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JXE0c-00008F-Bm
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 11:11:34 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m26BBVvF006311
	for <kexec@lists.infradead.org>; Thu, 6 Mar 2008 06:11:31 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m26BBVml190902
	for <kexec@lists.infradead.org>; Thu, 6 Mar 2008 04:11:31 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m26BBVTA022894
	for <kexec@lists.infradead.org>; Thu, 6 Mar 2008 04:11:31 -0700
Date: Thu, 6 Mar 2008 16:41:23 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: Kexec support for PS3 (ppc64)
Message-ID: <20080306111122.GN32366@in.ibm.com>
References: <C5065F118AFB3D478B052FC1E9810D9CA9033F@tec-mail.ttec.soc-soft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <C5065F118AFB3D478B052FC1E9810D9CA9033F@tec-mail.ttec.soc-soft.com>
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

On Thu, Mar 06, 2008 at 04:28:32PM +0530, Rajasekaran Periyasamy wrote:
> Hi All,
> Is KEXEC fully support ppc64 platform? 

Hi Rajasekaran,

Kexec/kdump is fully supported on PPC64 platform.

> 
> I am working on Kdump for ppc64 (PS3) platform, running 2.6.23 kernel
> built with KEXEC support. But when I try to boot kernel with
> "crashkernel=128M@32M", the kernel is not booting up. 
> I put some printk's in the function early_parse_crashk() (in
> arch/powerpc/kernel/machine_kexec.c), but no output. 

Are you sure that kernel hangs in early_parse_crashk function? Can you
attach .config file and dmesg output?

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
