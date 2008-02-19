Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JRLvs-0002to-NS
	for kexec@lists.infradead.org; Tue, 19 Feb 2008 06:26:25 +0000
Date: Tue, 19 Feb 2008 15:26:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch] kexec: Use target linker for purgatory
Message-ID: <20080219062619.GE8917@verge.net.au>
References: <47B522B7.5060308@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47B522B7.5060308@am.sony.com>
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
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org, Jeremy Kerr <jk@ozlabs.org>

On Thu, Feb 14, 2008 at 09:27:19PM -0800, Geoff Levand wrote:
> 
> Pugatory files need to be linked with the target linker,
> not the build linker.

Thanks Geoff, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
