Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dfhv8-0005UM-R5
 for kexec@lists.infradead.org; Thu, 10 Aug 2017 07:30:24 +0000
Date: Thu, 10 Aug 2017 09:29:25 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: powerpc: fix command line overflow error
Message-ID: <20170810072925.GA16647@verge.net.au>
References: <150230264648.32402.10255272562582526980.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <150230264648.32402.10255272562582526980.stgit@hbathini.in.ibm.com>
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
Cc: Kexec-ml <kexec@lists.infradead.org>

On Wed, Aug 09, 2017 at 11:47:42PM +0530, Hari Bathini wrote:
> Since kernel commit a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
> to 2048"), powerpc bumped command line size to 2048 but the size
> used here is still the default value of 512. Bump it to 2048 to
> fix command line overflow errors observed when command line length
> is above 512 bytes. Also, get rid of the multiple definitions of
> COMMAND_LINE_SIZE macro in ppc architecture.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
