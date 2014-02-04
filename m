Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WAbtI-0000Q9-1R
 for kexec@lists.infradead.org; Tue, 04 Feb 2014 09:02:00 +0000
Date: Tue, 4 Feb 2014 18:01:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc64 Enable early kernel's OPAL calls
Message-ID: <20140204090136.GB8144@verge.net.au>
References: <20140124141614.6404.37733.stgit@nimbus>
 <52EB105D.2060907@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52EB105D.2060907@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Laurent Dufour <ldufour@linux.vnet.ibm.com>, kexec@lists.infradead.org

On Fri, Jan 31, 2014 at 08:24:21AM +0530, Mahesh Jagannath Salgaonkar wrote:
> On 01/24/2014 07:46 PM, Laurent Dufour wrote:
> > When the kernel is built with CONFIG_PPC_EARLY_DEBUG_OPAL set, it is
> > expecting to get r8 and r9 filled respectively with OPAL base address and
> > OPAL entry address (arc/power/head_64.S).
> > 
> > On the new powernv platform, having these 2 registers set allows the kernel
> > to perform OPAL calls before it parse the device tree.
> > 
> > Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> 
> Tested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
