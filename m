Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QMWVJ-0005WH-T9
	for kexec@lists.infradead.org; Wed, 18 May 2011 02:28:54 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1QMWVF-0006DJ-Q8
	for kexec@lists.infradead.org; Wed, 18 May 2011 04:28:49 +0200
Received: from 60.247.97.98 ([60.247.97.98])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 04:28:49 +0200
Received: from xiyou.wangcong by 60.247.97.98 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Wed, 18 May 2011 04:28:49 +0200
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: kdump with /proc/oldproc
Date: Wed, 18 May 2011 02:28:38 +0000 (UTC)
Message-ID: <iqvasm$ctv$1@dough.gmane.org>
References: <OFC164F955.6ED93986-ON86257893.00589FE8-86257893.006037E5@us.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Tue, 17 May 2011 12:30:58 -0500, Nathan D Miller wrote:

> Hello-
> 
> Has anyone tried reconstituting a portion of the old kernel's /proc
> while in the capture kernel?
> 
> I had the idea while digging through the kexec/kdump code and it seemed
> intriguing.
> 
> It might be a means by which user-space dump applications running under
> the capture kernel could interrogate the old system, and identify bad
> processes that instigated the panic.  In particular, I'm thinking of Out
> Of Memory scenarios.   We've modified our kernel to panic instead of
> invoking the kernel's OOM killer, but we still have the problem of
> identifying the "bad" process while running in the capture kernel.
> 
> Perhaps everything could be accomplished using some sort of FUSE
> file-system around /proc/oldmem and /proc/vmcore.  Not all the
> proc/<pid>/ files would need to be implemented, of course.  In addition,
> each old process could have its own 'vmcore' file for getting a core
> dump of the original process.
> 

Well, actually you don't need to bother the old /proc
to find which process is the killer. The old dmesg contains
the PID/comm of the killer process, and we have a tool named
vmcore-dmesg to read out the dmesg from the vmcore.

With the utility 'crash', you can query any info of any process
in the old kernel, so why do you need a per-process vmcore anyway?

Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
