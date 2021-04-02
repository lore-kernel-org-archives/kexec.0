Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSGbR-00CgNr-Su
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:00:44 +0000
Date: Fri, 2 Apr 2021 12:00:30 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: Fix description of --status exit code
Message-ID: <20210402100030.GD18086@vergenet.net>
References: <20210323174502.32673-1-raphning@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210323174502.32673-1-raphning@gmail.com>
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
To: Raphael Ning <raphning@gmail.com>
Cc: kexec@lists.infradead.org, Julien Grall <julien@xen.org>, Hongyan Xia <hx242@xen.org>, Raphael Ning <raphning@amazon.com>

On Tue, Mar 23, 2021 at 05:45:02PM +0000, Raphael Ning wrote:
> From: Raphael Ning <raphning@amazon.com>
> 
> On both Linux and Xen, an exit code of 0 from `kexec --status`
> indicates that the kexec image being queried is NOT loaded, which
> is contrary to what the man page and usage() say.
> 
> Signed-off-by: Raphael Ning <raphning@amazon.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
