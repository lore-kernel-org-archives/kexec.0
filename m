Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QJk4D-0000lh-8m
	for kexec@lists.infradead.org; Tue, 10 May 2011 10:21:26 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1QJk4A-0006w0-HM
	for kexec@lists.infradead.org; Tue, 10 May 2011 12:21:22 +0200
Received: from 60.247.97.98 ([60.247.97.98])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 12:21:22 +0200
Received: from xiyou.wangcong by 60.247.97.98 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 12:21:22 +0200
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [Bug] Kdump does not work when panic triggered due to MCE
Date: Tue, 10 May 2011 10:21:08 +0000 (UTC)
Message-ID: <iqb3ij$e10$2@dough.gmane.org>
References: <20110506165412.GB2719@in.ibm.com>
	<20110509123902.GA5975@redhat.com> <4DC80662.9000703@canonical.com>
	<20110509170336.GC1963@in.ibm.com>
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

On Mon, 09 May 2011 22:33:36 +0530, K.Prasad wrote:

> That's interesting! Assuming that these are not software induced MCEs
> but panic() calls invoked due to unrecoverable memory errors in a
> physical machine, did you experience any situation where the kdump
> kernel hung/rebooted due to a second MCE (triggered while reading the
> faulty memory location belonging to the first kernel)?


Someone discussed this with me inside RH, is disabling MCE
checking in the second kernel an acceptable solution?

> We're contemplating a solution on the similar lines (refer the
> description of 'slim' kdump at https://lkml.org/lkml/2011/5/4/396) to
> create a 'crash tool readable coredump containing a message that
> indicates the cause of the crash as MCE (and not any data from the old
> memory).
> 

You might want to try use other way instead of memory to store
the log of the first kernel, for example, mtdoops.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
