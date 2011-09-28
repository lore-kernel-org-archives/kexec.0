Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R93u9-0001VT-6R
	for kexec@lists.infradead.org; Wed, 28 Sep 2011 23:51:09 +0000
Date: Thu, 29 Sep 2011 08:51:02 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec: load-preserve-context option on s390
Message-ID: <20110928235101.GB13684@verge.net.au>
References: <1317042549.3157.9.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1317042549.3157.9.camel@br98xy6r>
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
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, ying.huang@intel.com

On Mon, Sep 26, 2011 at 03:09:09PM +0200, Michael Holzheu wrote:
> Hello Simon,
> 
> I think the --load-preserve-context and --load-jump-back-helper kexec
> options are not working on s390 because we do not support
> CONFIG_KEXEC_JUMP. I assume the same is true also on other
> architectures. Correct me, if I am wrong. Unfortunately I did not find
> much documentation for that feature.
> 
> Wouldn't it be better to print an error message when the options are
> used on those architectures?

Ideally it would be nice if kexec-tools could ask the kernel
if KEXEC_JUMP is supported (or enabled?) or not rather than
hardcoding this information into kexec-tools on a per-architecture basis.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
