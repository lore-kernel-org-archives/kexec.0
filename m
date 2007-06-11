Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from over.ny.us.ibm.com ([32.97.182.150])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HxoZt-0006kM-AA
	for kexec@lists.infradead.org; Mon, 11 Jun 2007 14:25:31 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l5BI7Z3i011175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Mon, 11 Jun 2007 14:07:36 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5BI7Hlf002338
	for <kexec@lists.infradead.org>; Mon, 11 Jun 2007 14:07:17 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5BI7BdT134084
	for <kexec@lists.infradead.org>; Mon, 11 Jun 2007 12:07:13 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5BI7AsF020080
	for <kexec@lists.infradead.org>; Mon, 11 Jun 2007 12:07:10 -0600
Date: Mon, 11 Jun 2007 23:37:01 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070611180701.GA4466@in.ibm.com>
References: <20070419115233.GA4172@in.ibm.com>
	<080126626f9bea228426c0c3d7bf1730@bga.com>
	<20070426092455.GA4144@in.ibm.com>
	<4cb567d635b4ac3333e6b4b2c27c12f2@bga.com>
	<20070503144721.GA28460@in.ibm.com>
	<ca045e7e6fde9345b3461214777d8102@bga.com>
	<20070604105455.GA4916@in.ibm.com>
	<c1b8d82c8241fc3750c1339c34ecc799@bga.com>
	<20070606113134.GC4916@in.ibm.com>
	<ac119a2f080a47cf41f7c916010eaccd@bga.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac119a2f080a47cf41f7c916010eaccd@bga.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Milton Miller <miltonm@bga.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>, kexec@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Sun, Jun 10, 2007 at 08:58:10PM -0500, Milton Miller wrote:
> The code is structured cleanly.  However, when testing this patch, I 
> found (1) you printed the mask as a cpulist instead of a cpumask.  
> Since the user writes a cpumask to /proc/irq/xx/smp_affinity, it would 
> make more sense to print a mask in the error message.
>

I can change it to use cpumask print instead of cpulist print.
 
> However, this is all mute because (2) the common in /kenrel/irq/proc.c 
> checks that a cpu in the mask is online and returns -EINVAL to the user 
> without calling the ->set_affinity hook (we have no select_smp_affinity 
> hook arch code).   Unless there is another path to call ->set_affinity, 
> we can only trigger the case of no online cpu by racing between setting 
> the affinity and taking a cpu offline.
>

As you said, we can remove the extra check in get_irq_server function.

Any other thoughts?

 
> Does anyone know of another path to set the affinity?  If not I would 
> remove this extra logic and change the behavior from ignore to set to 
> default server.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
