Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fYucR-0004B1-Th
 for kexec@lists.infradead.org; Fri, 29 Jun 2018 14:43:29 +0000
Date: Fri, 29 Jun 2018 16:43:12 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] arm64: increase command line size to 2048
Message-ID: <20180629144308.2qynb7ek3wunvcwa@verge.net.au>
References: <1530042449-19329-1-git-send-email-kamatam@amazon.com>
 <20180627064946.65pfbswtjpytqteh@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180627064946.65pfbswtjpytqteh@verge.net.au>
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
To: Munehisa Kamata <kamatam@amazon.com>
Cc: kexec@lists.infradead.org

On Wed, Jun 27, 2018 at 08:49:47AM +0200, Simon Horman wrote:
> On Tue, Jun 26, 2018 at 12:47:28PM -0700, Munehisa Kamata wrote:
> > Otherwise, we can hit the current 512 chars limit before hitting the
> > Linux kernel's one, where allows 2048 chars in arm64.
> > 
> > Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> 
> Hi,
> 
> This looks fine to me but I will wait to see if there are other reviews
> before applying.
> 
> Reviewed-by: Simon Horman <horms@verge.net.au>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
