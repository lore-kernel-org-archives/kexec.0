Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KH5We-0001ev-J3
	for kexec@lists.infradead.org; Thu, 10 Jul 2008 23:26:13 +0000
Date: Fri, 11 Jul 2008 09:26:10 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] kexec/crashdump.c: remove useless code
Message-ID: <20080710232609.GF11227@verge.net.au>
References: <20080710104823.GA10478@hack.voiplan.pt>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080710104823.GA10478@hack.voiplan.pt>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

On Thu, Jul 10, 2008 at 11:48:23AM +0100, WANG Cong wrote:
> 
> I think we don't need to print fopen errors when stat fails.
> 
> Signed-off-by: WANG Cong <wangcong@zeuux.org>
> Cc: Simon Horman <horms@verge.net.au>

Thanks, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
