Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QX0Cz-0008NZ-HI
	for kexec@lists.infradead.org; Thu, 16 Jun 2011 00:13:19 +0000
Date: Thu, 16 Jun 2011 09:12:45 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC][PATCH] kexec-tools: powerpc: Use the #address-cells
	information to parsememory/reg - V2
Message-ID: <20110616001244.GJ28947@verge.net.au>
References: <4DEF18FF.6070206@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4DEF18FF.6070206@in.ibm.com>
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
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, David Laight <David.Laight@ACULAB.COM>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, Jun 08, 2011 at 12:08:55PM +0530, Suzuki Poulose wrote:
> Hi,
> 
> This is version 2 of the patch
> 
> Changes from Version 1 :
>  : Changed the interface for read_memory_region_limits to use 'int fd'
> 	instead of FILE*.
>  : Use sizeof(variable) for read(, instead of sizeof(type).
> 
> 
> ---
> 
> Fix parsing of the memory region information from the device-tree.
> 
> The format of memory/reg is based on the #address-cells,#size-cells. Currently,
> the kexec-tools doesn't use the above values in parsing the memory/reg values.
> Hence the kexec cannot handle cases where #address-cells, #size-cells are
> different, (for e.g, PPC440X ).
> 
> This patch introduces a read_memory_region_limits(), which parses the
> memory/reg contents based on the values of #address-cells and #size-cells.
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>

Hi,

this does not seem to apply to the master branch of
git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
