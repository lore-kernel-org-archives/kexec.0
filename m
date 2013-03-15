Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGWw6-0004A0-Os
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 15:52:51 +0000
Date: Fri, 15 Mar 2013 16:52:44 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 04/13] kexec: use _ALIGN* to make the logic clear
Message-ID: <20130315155243.GD16561@verge.net.au>
References: <5140B511.7020109@gmail.com> <5140B6E0.1080202@gmail.com>
 <20130314090805.GH11196@verge.net.au>
 <20130314094950.GR11196@verge.net.au>
 <20130314095852.GY11196@verge.net.au> <5141B3DA.2030004@gmail.com>
 <20130315083544.GE1846@verge.net.au>
 <5142EDFB.80601@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5142EDFB.80601@cn.fujitsu.com>
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

On Fri, Mar 15, 2013 at 05:46:35PM +0800, Zhang Yanfei wrote:
> By replacing all the explicit align opertion with marco _ALIGN*,
> the code logic could more clear.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
