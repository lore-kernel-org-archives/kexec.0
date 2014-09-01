Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XOFxW-0000qe-BS
 for kexec@lists.infradead.org; Mon, 01 Sep 2014 00:59:02 +0000
Date: Mon, 1 Sep 2014 09:58:39 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ppc64/kdump: Fix ELF header endianess
Message-ID: <20140901005839.GA32075@verge.net.au>
References: <20140725150749.17944.26746.stgit@nimbus>
 <53FF288F.80009@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53FF288F.80009@linux.vnet.ibm.com>
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
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On Thu, Aug 28, 2014 at 03:03:11PM +0200, Laurent Dufour wrote:
> On 25/07/2014 17:07, Laurent Dufour wrote:
> > The ELF header created among the loading of the kdump kernel should be
> > flagged using the current endianess and not always as big endian.
> > 
> > Without this patch the data exposed in /proc/vmcore are not readable when
> > running in LE mode.
> 
> Hi Simon,
> 
> Do you have any concerns with this patch ?
> If not, would you please consider it for merge since it fixes a major
> issue with dump analysis.

Thanks, I have applied this patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
