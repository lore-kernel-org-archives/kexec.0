Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]
	helo=VA3EHSOBE003.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OZFxx-0001Ej-T9
	for kexec@lists.infradead.org; Thu, 15 Jul 2010 04:22:35 +0000
Subject: Re: [PATCH] Fix case where phys_addr_t != unsigned long when
	reading proc entries
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <20100715030748.GA11508@verge.net.au>
References: <1279121556-8069-1-git-send-email-msm@freescale.com>
	<1279121958.13098.1.camel@localhost>
	<20100715030748.GA11508@verge.net.au>
Date: Wed, 14 Jul 2010 23:22:45 -0500
Message-ID: <1279167765.26744.1.camel@localhost>
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On Thu, 2010-07-15 at 12:07 +0900, Simon Horman wrote:
> The list below is sufficient, but could you cc the patches to
> linuxppc-dev@lists.ozlabs.org?
> 

Yes of course, I'm also trying to find some people to review/test these
as well.

-M



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
