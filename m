Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnSGe-0007ri-2n
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 06:11:28 +0000
Date: Wed, 8 Oct 2008 17:11:25 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Relocatable kdump kernel support in kexec-tools
Message-ID: <20081008061123.GE22396@verge.net.au>
References: <20080930125621.GC1945@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080930125621.GC1945@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mohan Kumar M <mohan@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org, paulus@samba.org, Maneesh Soni <maneesh@in.ibm.com>

On Tue, Sep 30, 2008 at 06:26:21PM +0530, Mohan Kumar M wrote:
> Relocatable kdump kernel support in kexec-tools
> 
> This patch adds relocatable kernel support for kdump in the kexec-tools
> code. A signature (0xfeed1234) is passed in r6 from panic code to the
> purgatory code through kexec_sequence function. The signature is used to
> differentiate between relocatable kdump kernel and non-kdump kernels.
> 
> The purgatory code compares the signature and sets the __kdump_flag in
> head_64.S by using the offset with respect to next kernel load address.
> During the boot up, kernel code checks __kdump_flag and if it is set, the
> kernel will behave as relocatable kdump kernel.

Thanks Mohan, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
