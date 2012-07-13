Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SpZRC-0004yp-Mw
 for kexec@lists.infradead.org; Fri, 13 Jul 2012 06:33:23 +0000
Date: Fri, 13 Jul 2012 15:33:10 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] [ppc] Do not reserve cpu spin-table for crash kernel
Message-ID: <20120713063309.GF19512@verge.net.au>
References: <CAEsOVNeg2aogCwCy-v3ez4cC4VPF79A4PWRaO2ohDj_ypqCWmg@mail.gmail.com>
 <20120524060933.14035.42732.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120524060933.14035.42732.stgit@suzukikp.in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: B29882@freescale.com, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On Thu, May 24, 2012 at 11:39:45AM +0530, Suzuki K. Poulose wrote:
> As of now, the kexec reserves the spin-table for all the CPUs
> on an SMP machine. The spin-table is pointed to by the 
> cpu-release-addr property in the device-tree. Reserving the
> spin-table in the crash kernel will cause a BUG(), if the table
> lies outside the memory reserved for the crashkernel.
> 
> Disable reserving the spin-table regions and use maxcpus=1 to 
> use only the crashing CPU to boot the crash kernel.
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>

Thanks, applied.

Sorry for not seeing this (much) earlier.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
