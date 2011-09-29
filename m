Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R9Giv-0001rZ-M5
	for kexec@lists.infradead.org; Thu, 29 Sep 2011 13:32:26 +0000
Date: Thu, 29 Sep 2011 09:32:09 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec: load-preserve-context option on s390
Message-ID: <20110929133209.GA25760@redhat.com>
References: <1317042549.3157.9.camel@br98xy6r>
	<20110928235101.GB13684@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110928235101.GB13684@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec@lists.infradead.org, ying.huang@intel.com

On Thu, Sep 29, 2011 at 08:51:02AM +0900, Simon Horman wrote:
> On Mon, Sep 26, 2011 at 03:09:09PM +0200, Michael Holzheu wrote:
> > Hello Simon,
> > 
> > I think the --load-preserve-context and --load-jump-back-helper kexec
> > options are not working on s390 because we do not support
> > CONFIG_KEXEC_JUMP. I assume the same is true also on other
> > architectures. Correct me, if I am wrong. Unfortunately I did not find
> > much documentation for that feature.
> > 
> > Wouldn't it be better to print an error message when the options are
> > used on those architectures?
> 
> Ideally it would be nice if kexec-tools could ask the kernel
> if KEXEC_JUMP is supported (or enabled?) or not rather than
> hardcoding this information into kexec-tools on a per-architecture basis.

Shouldn't kexec system call return error if KEXEC_JUMP is not supported
and user asked for it?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
