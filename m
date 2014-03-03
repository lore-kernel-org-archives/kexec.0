Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WKPQM-0000iM-Ad
 for kexec@lists.infradead.org; Mon, 03 Mar 2014 09:44:39 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 3 Mar 2014 09:44:13 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id AC40F2190069
 for <kexec@lists.infradead.org>; Mon,  3 Mar 2014 09:44:07 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s239hxeN31785042
 for <kexec@lists.infradead.org>; Mon, 3 Mar 2014 09:43:59 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s239iAhx032766
 for <kexec@lists.infradead.org>; Mon, 3 Mar 2014 04:44:10 -0500
Date: Mon, 3 Mar 2014 10:44:08 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: makedumpfile: get_max_mapnr() from ELF header problem
Message-ID: <20140303104408.7031a457@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971EFABE@BPXM01GP.gisp.nec.co.jp>
References: <20140228134148.15b60ceb@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971EFABE@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Mon, 3 Mar 2014 03:11:23 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello Michael,
> 
> >Hello Atsushi,
> >
> >On s390 we have the following little problem:
> >
> >We use hypervisor or stand-alone dump tools to create Linux system
> >dumps. These tools do not know the kernel parameter line and dump the
> >full physical memory.
> >
> >We use makedumpfile to filter those dumps.
> >
> >If a Linux system has specified the "mem=" parameter, the dump tools
> >still dump the whole phypsical memory.
> 
> I guess this is a problem of the tools, it sounds that the tools ignore
> the actual memory map and just make wrong ELF headers.
> How do the tools decide the range of System RAM to create ELF headers ?

The tools do a physical memory detection and that defines the range
of memory to be dumped and also defines the memory chunks for the
ELF header.

And I think we are not the only ones that have this problem. For example,
the KVM virsh dump probably also has that problem.

> 
> At least, if the tools respect the actual memory map like /proc/vmcore, it
> can create correct ELF headers and makedumpfile will work normally.

As I said, the tools do not know the Linux memory map. They only know
the physical available memory.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
