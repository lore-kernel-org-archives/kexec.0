Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1ddaW4-00059H-5a
 for kexec@lists.infradead.org; Fri, 04 Aug 2017 11:11:41 +0000
Date: Fri, 4 Aug 2017 13:11:11 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: ppc64: fix how RMA top is deduced
Message-ID: <20170804111111.GA13074@verge.net.au>
References: <150108958197.31071.13359341334422395062.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <150108958197.31071.13359341334422395062.stgit@hbathini.in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Ankit Kumar <ankit@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>

On Wed, Jul 26, 2017 at 10:49:41PM +0530, Hari Bathini wrote:
> Hang was observed, in purgatory, on a machine configured with
> single LPAR. This was because one of the segments was loaded
> outside the actual Real Memory Area (RMA) due to wrongly
> deduced RMA top value.
> 
> Currently, top of real memory area, which is crucial for loading
> kexec/kdump kernel, is obtained by iterating through mem nodes
> and setting its value based on the base and size values of the
> last mem node in the iteration. That can't always be correct as
> the order of iteration may not be same and RMA base & size are
> always based on the first memory property. Fix this by setting
> RMA top value based on the base and size values of the memory
> node that has the smallest base value (first memory property)
> among all the memory nodes.
> 
> Also, correct the misnomers rmo_base and rmo_top to rma_base
> and rma_top respectively.
> 
> While how RMA top is deduced was broken for sometime, the issue
> may not have been seen so far, for couple of possible reasons:
> 
>     1. Only one mem node was available.
>     2. First memory property has been the last node in
>        iteration when multiple mem nodes were present.
> 
> Fixes: 02f4088ffded ("kexec fix ppc64 device-tree mem node")
> Reported-by: Ankit Kumar <ankit@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Geoff Levand <geoff@infradead.org>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
