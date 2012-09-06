Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9kE0-0003EV-Ia
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 22:07:01 +0000
Date: Fri, 7 Sep 2012 07:06:53 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: Fix the purgatory Makefile to build arch specific
 purgatory code.
Message-ID: <20120906220653.GC10174@verge.net.au>
References: <20120906091332.11848.70361.stgit@mars>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120906091332.11848.70361.stgit@mars>
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
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Kexec-ml <kexec@lists.infradead.org>

On Thu, Sep 06, 2012 at 02:43:55PM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The latest commit 5e48916 has removed a line from purgatory/Makefile that was
> responsible for building arch specific purgatory code. This causes kexec -p
> (loading of panic kernel) to fail. This patch reverts the deleted line.
> 
> Verified this fix on x86_64 and ppc64.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
