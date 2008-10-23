Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ksnpn-0005zH-Ge
	for kexec@lists.infradead.org; Thu, 23 Oct 2008 00:13:51 +0000
Date: Thu, 23 Oct 2008 11:13:49 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kdump : check flags field from drconf memory
Message-ID: <20081023001347.GB22521@verge.net.au>
References: <200810172325.54932.chandru@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200810172325.54932.chandru@in.ibm.com>
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
To: Chandru <chandru@in.ibm.com>
Cc: kexec@lists.infradead.org

On Fri, Oct 17, 2008 at 11:25:54PM +0530, Chandru wrote:
> On a powerpc machine when memory is dynamically removed/added from an lpar, the 
> corresponding flags field in the drconf memory reflects the same with the bits 
> unset/set accordingly. The kernel does a check on these flags while booting. 
> Following are the similar changes brought in to kexec-tools.  This makes 
> kexec-tools to skip those memory regions that do not belong or are not 
> assigned to the current partition ( but are available to dynamically add them 
> back ). Without this patch (and with memory remove operation) copying vmcore 
> fails with error as
> 
> Copying data                       : [ 84 %] readmem: Can't read the dump 
> memory(/proc/vmcore). Bad address
> read_pfn: Can't get the page data.
> 
> 
> Signed-off-by : Chandru S <chandru@in.ibm.com>


Thanks, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
