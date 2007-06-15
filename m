Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86] helo=ruth.realtime.net)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HzEm9-0002Hn-Ty
	for kexec@lists.infradead.org; Fri, 15 Jun 2007 12:35:55 -0400
In-Reply-To: <20070612145157.GA7562@in.ibm.com>
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
	<20070612145157.GA7562@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <984f2f169b3e60daa032eb31147241b4@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Date: Fri, 15 Jun 2007 11:35:49 -0500
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
To: mohan@in.ibm.com
Cc: Michael Ellerman <michael@ellerman.id.au>, ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>, kexec@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


On Jun 12, 2007, at 9:51 AM, Mohan Kumar M wrote:
>
> Attached patch uses cpumask_scnprintf function.


> In some of the PPC970 based systems, interrupt would be distributed to
> offline cpus also even when booted with "maxcpus=1". So check whether
> cpu online map and cpu present map are equal or not. If they are equal
> default_distrib_server is used as interrupt server otherwise boot cpu
> (default_server) used as interrupt server.
>
> In addition to this, if an interrupt is assigned to a specific cpu (ie
> smp affinity) and if that cpu is not online, the earlier code used to
> return the default_distrib_server as interrupt server. This patch
> introduces an additional paramter to the get_irq function ie
> strict_check, based on this parameter, if the cpu is not online either
> default_distrib_server or -1 is returned.
>
> Cc: Milton Miller <miltonm@bga.com>,
>     Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
>

Acked-by: Milton Miller <miltonm@bga.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
