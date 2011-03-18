Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate4.uk.ibm.com ([194.196.100.164])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q0Wep-0006Oy-CL
	for kexec@lists.infradead.org; Fri, 18 Mar 2011 10:11:48 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate4.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p2IABcMU008941
	for <kexec@lists.infradead.org>; Fri, 18 Mar 2011 10:11:38 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p2IAC0AN1953824
	for <kexec@lists.infradead.org>; Fri, 18 Mar 2011 10:12:00 GMT
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p2IABbGw016074
	for <kexec@lists.infradead.org>; Fri, 18 Mar 2011 04:11:38 -0600
Subject: Re: [PATCH] makedumpfile: s390x: Fix KVBASE to correct value for
	s390x arcitecture.
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110317153912.de4162a9.oomichi@mxs.nes.nec.co.jp>
References: <20110315170902.32471.52757.stgit@mars.in.ibm.com>
	<20110317153912.de4162a9.oomichi@mxs.nes.nec.co.jp>
Date: Fri, 18 Mar 2011 11:11:37 +0100
Message-ID: <1300443097.1981.16.camel@holzheu-laptop>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec-ml <kexec@lists.infradead.org>, Michael Holzheu <holzheu@de.ibm.com>, Sachin P Sant <sachinp@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hello Ken'inchi,

On Thu, 2011-03-17 at 15:39 +0900, Ken'ichi Ohmichi wrote:
> Hi Mahesh,
> 
> On Tue, 15 Mar 2011 22:39:23 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > While excluding free pages from s390x dumps taken on LPAR, makedumpfile
> > fails to convert page address to pfn. The reason is, the memory for
> > mem_section structure is allocated below '_stext' and since KVBASE is
> > set to SYMBOL(_stext), the function is_kvaddr() fails and return NULL
> > address.
> 
> Why do we need this patch ?
> to support the latest kernel version of s390 ?
> or to support LPAR of s390 ?

The problem is that on s390 depending on the kernel configuration it can
happen that memory below _stext is available for buffer allocation.
Therefore the mem_section structure has been allocated below _stext. On
s390 the kernel page tables have a 1:1 mapping from 0 to memory_end
(memory holes are possible). Therefore I think the check "> 0" is ok for
s390.

> 
> I'd like to know whether we need a similar change for the other architecture.
> I will appreciate if getting a hint.

Not sure, if other architectures use memory below _stext for buffer
allocation.

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
