Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSGc4-00CgS4-MM
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:01:18 +0000
Date: Fri, 2 Apr 2021 12:01:08 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: Make --status work with normal kexec images
Message-ID: <20210402100108.GE18086@vergenet.net>
References: <20210323175007.3069-1-raphning@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210323175007.3069-1-raphning@gmail.com>
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

On Tue, Mar 23, 2021 at 05:50:07PM +0000, Raphael Ning wrote:
> From: Raphael Ning <raphning@amazon.com>
> 
> According to kexec(8) manpage, --status (-S) works with both
> normal kexec (loaded by -l) and crash kernel (loaded by -p) image
> types, and defaults to the latter. However, the implementation does
> not match the description: `kexec -l -S` queries the -p image type
> as if -l were not specified. This is because there is no internal
> flag defined for the normal kexec type, and -S treats the zero flag
> as the trigger for the default behaviour (-p).
> 
> Fix that by making sure the default behaviour for -S is not applied
> when the -l option is present.
> 
> Signed-off-by: Raphael Ning <raphning@amazon.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
