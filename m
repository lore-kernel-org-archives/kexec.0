Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QXKcj-0007Kr-Ce
	for kexec@lists.infradead.org; Thu, 16 Jun 2011 22:01:14 +0000
Date: Fri, 17 Jun 2011 07:00:43 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec-tools: powerpc: Use the #address-cells
	information to parsememory/reg
Message-ID: <20110616220043.GA2434@verge.net.au>
References: <20110616104441.8065.46187.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110616104441.8065.46187.stgit@suzukikp.in.ibm.com>
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
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, David Laight <David.Laight@ACULAB.COM>, linux ppc dev <linuxppc-dev@lists.ozlabs.org>

On Thu, Jun 16, 2011 at 04:15:13PM +0530, Suzuki K. Poulose wrote:
> The format of memory/reg is based on the #address-cells,#size-cells. Currently,
> the kexec-tools doesn't use the above values in parsing the memory/reg values.
> Hence the kexec cannot handle cases where #address-cells, #size-cells are
> different, (for e.g, PPC440X ).
> 
> This patch introduces a read_memory_region_limits(), which parses the
> memory/reg contents based on the values of #address-cells and #size-cells.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
