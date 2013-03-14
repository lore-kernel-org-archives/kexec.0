Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG515-0002I5-6b
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 10:04:07 +0000
Date: Thu, 14 Mar 2013 11:04:02 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 10/13] kexec: ppc64: use _ALIGN* to make the logic clear
Message-ID: <20130314100401.GD11196@verge.net.au>
References: <5140B511.7020109@gmail.com> <5140B853.2050906@gmail.com>
 <51419A7A.3000503@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51419A7A.3000503@cn.fujitsu.com>
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Thu, Mar 14, 2013 at 05:38:02PM +0800, Zhang Yanfei wrote:
> By replacing all the explicit align opertion with marco _ALIGN*,
> the code logic could be more clear.
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
