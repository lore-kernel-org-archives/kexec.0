Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LW7jk-0007a0-1e
	for kexec@lists.infradead.org; Sun, 08 Feb 2009 11:22:10 +0000
Date: Sun, 8 Feb 2009 20:20:25 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] powerpc: initialize drconf variables
Message-ID: <20090208112023.GA6069@verge.net.au>
References: <200902042146.28854.chandru@in.ibm.com>
	<200902041748.56793.bwalle@suse.de>
	<200902061207.17451.chandru@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200902061207.17451.chandru@in.ibm.com>
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
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

On Fri, Feb 06, 2009 at 12:07:17PM +0530, Chandru wrote:
> The initialization of lmb_size and num_of_lmbs got removed as part of the
> 'kexec memory ranges dynamic allocation' patch to kexec-tools (which added
> realloc_memory_ranges() code to kexec-tools). These variables are pertinent
> to ppc64 systems with ibm,dynamic-reconfiguration-memory node in device-tree,
> i.e systems with /proc/device-tree/ibm,dynamic-reconfiguration-memory. The
> following patch adds code to initialize the variables back again in kexec-tools.
> Without this patch kexec-tools will think that it needs to save only the memory
> represented in memory@ nodes and will skip the memory in
> /proc/device-tree/ibm,dynamic-reconfiguration-memory node of the device-tree.

Thanks, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
