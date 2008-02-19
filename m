Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JRKal-0003ke-Bq
	for kexec@lists.infradead.org; Tue, 19 Feb 2008 05:00:31 +0000
From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: Use zlib if present
Date: Tue, 19 Feb 2008 15:59:41 +1100
References: <20080219044208.278434FB0B@tabatha.lab.ultramonkey.org>
In-Reply-To: <20080219044208.278434FB0B@tabatha.lab.ultramonkey.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200802191559.42445.jk@ozlabs.org>
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

Hi Simon,

> This fixes a minor regression that occured with Jeremy's recent
> reworking of the build system. I guess he wasn't dealing with
> compressed images and thus didn't notice that zlib support had
> been disabled.

eep, sorry about that. I wasn't using compressed images.

> The fix involves updating an #ifdef to use the new symbol,
> and ensuring that -lz is passed to the linker as neccessary.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
