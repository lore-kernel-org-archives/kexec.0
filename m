Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qo9yq-0007Q4-LU
	for kexec@lists.infradead.org; Tue, 02 Aug 2011 08:05:38 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7285JPj027481
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 08:05:19 GMT
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7285IrS2011224
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 09:05:18 +0100
Received: from d06av07.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7285Hk6014892
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 02:05:17 -0600
Subject: Re: [patch v2 05/10] s390: Add PSW restart shutdown trigger
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110801205402.GK3805@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125808.172069159@linux.vnet.ibm.com>
	<20110801205402.GK3805@redhat.com>
Date: Tue, 02 Aug 2011 10:05:16 +0200
Message-ID: <1312272316.4881.4.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

On Mon, 2011-08-01 at 16:54 -0400, Vivek Goyal wrote:
> On Wed, Jul 27, 2011 at 02:55:09PM +0200, Michael Holzheu wrote:
> > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > With this patch a new S390 shutdown trigger "restart" is added. If under
> > z/VM "systerm restart" is entered or under the HMC the "PSW restart" button
> > is pressed, the PSW located at 0 (31 bit) or 0x1a0 (64 bit) bit is loaded.
> > Now we execute do_restart() that processes the restart action that is
> > defined under /sys/firmware/shutdown_actions/on_restart. Currently the
> > following actions are possible: reipl (default), stop, vmcmd, dump, and
> > dump_reipl.
> 
> i know nothing about s390 but this sounds like a independent
> functionality? I mean defining a restart trigger and associated actions
> could be done even in current framework without kdump. IIUC, additional
> kdump series only adds the ability to use kdump for second kernel instead
> of using dump tools in case of "dump" or "dump_reipl" ?
> 
> If yes, then this patch probably does not have to be part of this series
> and pushed in independetly?

Yes, this is correct. We implemented the PSW restart functionality for
kdump, but it can be used independently.

We will integrate this patch upstream independently from this series.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
