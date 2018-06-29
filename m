Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fYuch-0004Cr-9X
 for kexec@lists.infradead.org; Fri, 29 Jun 2018 14:43:45 +0000
Date: Fri, 29 Jun 2018 16:43:30 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] arm64: error out if kernel command line is too long
Message-ID: <20180629144329.6v4ta3dbcswhyzhu@verge.net.au>
References: <1530042449-19329-1-git-send-email-kamatam@amazon.com>
 <1530042449-19329-2-git-send-email-kamatam@amazon.com>
 <20180627065125.swbswslhi7ry4uyx@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180627065125.swbswslhi7ry4uyx@verge.net.au>
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

On Wed, Jun 27, 2018 at 08:51:25AM +0200, Simon Horman wrote:
> On Tue, Jun 26, 2018 at 12:47:29PM -0700, Munehisa Kamata wrote:
> > Currently, in arm64, kexec silently truncates kernel command line longer
> > than COMMAND_LINE_SIZE - 1. Error out in that case as some other
> > architectures already do that. The error message is copied from x86_64.
> > 
> > Suggested-by: Tom Kirchner <tjk@amazon.com>
> > Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> > ---
> >  kexec/arch/arm64/kexec-arm64.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
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
