Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R9Gox-0001va-GP
	for kexec@lists.infradead.org; Thu, 29 Sep 2011 13:38:40 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8TDcXRB018438
	for <kexec@lists.infradead.org>; Thu, 29 Sep 2011 13:38:33 GMT
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
	[9.149.37.229])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8TDcXQe2281626
	for <kexec@lists.infradead.org>; Thu, 29 Sep 2011 14:38:33 +0100
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8TDcWZV029699
	for <kexec@lists.infradead.org>; Thu, 29 Sep 2011 07:38:32 -0600
Subject: Re: kexec: load-preserve-context option on s390
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110929133209.GA25760@redhat.com>
References: <1317042549.3157.9.camel@br98xy6r>
	<20110928235101.GB13684@verge.net.au>
	<20110929133209.GA25760@redhat.com>
Date: Thu, 29 Sep 2011 15:38:31 +0200
Message-ID: <1317303511.3494.2.camel@br98xy6r>
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
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, ying.huang@intel.com

Hello Vivec,

On Thu, 2011-09-29 at 09:32 -0400, Vivek Goyal wrote:
> On Thu, Sep 29, 2011 at 08:51:02AM +0900, Simon Horman wrote:
> > On Mon, Sep 26, 2011 at 03:09:09PM +0200, Michael Holzheu wrote:
> > > Hello Simon,
> > > 
> > > I think the --load-preserve-context and --load-jump-back-helper kexec
> > > options are not working on s390 because we do not support
> > > CONFIG_KEXEC_JUMP. I assume the same is true also on other
> > > architectures. Correct me, if I am wrong. Unfortunately I did not find
> > > much documentation for that feature.
> > > 
> > > Wouldn't it be better to print an error message when the options are
> > > used on those architectures?
> > 
> > Ideally it would be nice if kexec-tools could ask the kernel
> > if KEXEC_JUMP is supported (or enabled?) or not rather than
> > hardcoding this information into kexec-tools on a per-architecture basis.
> 
> Shouldn't kexec system call return error if KEXEC_JUMP is not supported
> and user asked for it?

I think currently not. I assume that we should check the
KEXEC_PRESERVE_CONTEXT flag in the kexec_load system call.

What about the following:
---
 kernel/kexec.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -949,6 +949,10 @@ SYSCALL_DEFINE4(kexec_load, unsigned lon
 	if (!capable(CAP_SYS_BOOT))
 		return -EPERM;
 
+#ifndef CONFIG_KEXEC_JUMP
+	if (flags & KEXEC_PRESERVE_CONTEXT)
+		return -EOPNOTSUPP;
+#endif
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
