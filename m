Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QoBcx-0001bd-Hr
	for kexec@lists.infradead.org; Tue, 02 Aug 2011 09:51:08 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p729p5xW022365
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 09:51:05 GMT
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p729p51Q2347166
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 10:51:05 +0100
Received: from d06av07.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p729p4sw011288
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 03:51:05 -0600
Subject: Re: [patch v2 01/10] kdump: Add KEXEC_CRASH_CONTROL_MEMORY_LIMIT
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110801201644.GG3805@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125807.529303146@linux.vnet.ibm.com>
	<20110801201644.GG3805@redhat.com>
Date: Tue, 02 Aug 2011 11:51:04 +0200
Message-ID: <1312278664.4881.35.camel@br98xy6r>
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

On Mon, 2011-08-01 at 16:16 -0400, Vivek Goyal wrote:
> On Wed, Jul 27, 2011 at 02:55:05PM +0200, Michael Holzheu wrote:
> > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > On s390 there is a different KEXEC_CONTROL_MEMORY_LIMIT for the normal and
> > the kdump kexec case. Therefore this patch introduces a new macro
> > KEXEC_CRASH_CONTROL_MEMORY_LIMIT. This is set to
> > KEXEC_CONTROL_MEMORY_LIMIT for all architectures that do not define
> > KEXEC_CRASH_CONTROL_MEMORY_LIMIT.
> 
> Hi Michael,
> 
> Curious that why limit is different for kexec and kdump cases on s390
> only.

The standard kexec relocate_kernel code calls a machine instruction that
must run below 2 GiB. For kdump we currently do not use the control page
at all because no segments have to be moved in that case. Perhaps I am
still missing something here?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
