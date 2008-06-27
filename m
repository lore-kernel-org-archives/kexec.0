Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KC3mg-0002aB-QE
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 02:33:59 +0000
Date: Fri, 27 Jun 2008 12:33:54 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] kexec/crashdump.c: improve the code a bit
Message-ID: <20080627023352.GA16140@verge.net.au>
References: <20080624210356.GA8177@hack.netcabo.pt>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080624210356.GA8177@hack.netcabo.pt>
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

On Tue, Jun 24, 2008 at 10:03:56PM +0100, WANG Cong wrote:
> 
> Add the missing fclose().
> Constify a char pointer.

Thanks, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
