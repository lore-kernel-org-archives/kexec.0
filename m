Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R9fc5-0006Yg-0g
	for kexec@lists.infradead.org; Fri, 30 Sep 2011 16:07:01 +0000
Date: Fri, 30 Sep 2011 12:06:55 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec: load-preserve-context option on s390
Message-ID: <20110930160655.GD25891@redhat.com>
References: <1317042549.3157.9.camel@br98xy6r>
	<20110928235101.GB13684@verge.net.au>
	<20110929133209.GA25760@redhat.com>
	<1317303511.3494.2.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1317303511.3494.2.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, ying.huang@intel.com

On Thu, Sep 29, 2011 at 03:38:31PM +0200, Michael Holzheu wrote:
> Hello Vivec,

Right spelling is "Vivek" and not "Vivec" :-)

[..]
> > Shouldn't kexec system call return error if KEXEC_JUMP is not supported
> > and user asked for it?
> 
> I think currently not. I assume that we should check the
> KEXEC_PRESERVE_CONTEXT flag in the kexec_load system call.
> 

Shouldn't following existing code take care of this already?

        /*
         * Verify we have a legal set of flags
         * This leaves us room for future extensions.
         */
        if ((flags & KEXEC_FLAGS) != (flags & ~KEXEC_ARCH_MASK))
                return -EINVAL;

In include/linux/kexec.h, we have following.

/* List of defined/legal kexec flags */
#ifndef CONFIG_KEXEC_JUMP
#define KEXEC_FLAGS    KEXEC_ON_CRASH
#else
#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
#endif

Not sure why it is not working.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
