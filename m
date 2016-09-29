Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpWEF-0001lg-0E
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 07:58:03 +0000
Date: Thu, 29 Sep 2016 09:57:38 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: socket not released when error situation occur.
Message-ID: <20160929075738.GF14497@verge.net.au>
References: <20160825021524.41728-1-yooyoo.yoo@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160825021524.41728-1-yooyoo.yoo@samsung.com>
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
To: YoungHyun Yoo <yooyoo.yoo@samsung.com>
Cc: kexec@lists.infradead.org

On Thu, Aug 25, 2016 at 11:15:24AM +0900, YoungHyun Yoo wrote:
> Fix resourceleek in ifdown function when error occur.
> 
> Signed-off-by: YoungHyun Yoo <yooyoo.yoo@samsung.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
