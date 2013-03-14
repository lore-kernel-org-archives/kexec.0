Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG4nM-00006V-3g
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 09:50:00 +0000
Date: Thu, 14 Mar 2013 10:49:51 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 04/13] kexec: use _ALIGN* to make the logic clear
Message-ID: <20130314094950.GR11196@verge.net.au>
References: <5140B511.7020109@gmail.com> <5140B6E0.1080202@gmail.com>
 <20130314090805.GH11196@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130314090805.GH11196@verge.net.au>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Mar 14, 2013 at 10:08:06AM +0100, Simon Horman wrote:
> On Thu, Mar 14, 2013 at 01:26:56AM +0800, Zhang Yanfei wrote:
> > From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> > 
> > By replacing all the explicit align opertions with marco _ALIGN*,
> > the code logic could be more clear.
> 
> Not a big deal, but I believe this patch needs to come after
> the arm changes in the series in order to avoid breaking the build
> on that architecture.

I have applied this as the last patch of this series that I have applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
