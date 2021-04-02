Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSGcE-00CgT3-AF
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:01:25 +0000
Date: Fri, 2 Apr 2021 12:01:18 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-xen: Use correct image type for Live Update
Message-ID: <20210402100118.GF18086@vergenet.net>
References: <20210323175923.7342-1-raphning@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210323175923.7342-1-raphning@gmail.com>
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
Cc: kexec@lists.infradead.org, Julien Grall <julien@xen.org>, Hongyan Xia <hx242@xen.org>, xen-devel@lists.xenproject.org, Raphael Ning <raphning@amazon.com>

On Tue, Mar 23, 2021 at 05:59:23PM +0000, Raphael Ning wrote:
> From: Raphael Ning <raphning@amazon.com>
> 
> Unlike xen_kexec_load(), xen_kexec_unload() and xen_kexec_status()
> fail to distinguish between normal kexec and Xen Live Update image
> types.
> 
> Fix that by introducing a new helper function that maps internal
> flags to KEXEC_TYPE_*, and using it throughout kexec-xen.c.
> 
> Signed-off-by: Raphael Ning <raphning@amazon.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
