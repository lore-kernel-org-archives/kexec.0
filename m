Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JyhYw-0005ku-Bw
	for kexec@lists.infradead.org; Wed, 21 May 2008 06:12:34 +0000
Received: from yukiko.shinjuku.tokyo.vergenet.net (unknown [202.128.116.96])
	by koto.vergenet.net (Postfix) with ESMTP id 6231534086
	for <kexec@lists.infradead.org>; Wed, 21 May 2008 15:12:30 +0900 (JST)
Date: Wed, 21 May 2008 16:12:27 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Update 32 bit boot protocol
Message-ID: <20080521061225.GG3714@verge.net.au>
References: <20080509164355.GA16830@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080509164355.GA16830@suse.de>
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

On Fri, May 09, 2008 at 06:43:55PM +0200, Bernhard Walle wrote:
> This patch updates the boot protocol to match with the kernel. See
> Documentation/i386/zero-page.txt in kernel.
> 
> The number of E820 map entries have been increased from 32 to 128. The update
> is necessary for the next patch that implements EDD support for kexec.
> when using the default 32 bit mode.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Thanks, I have applied this change, though I
am a little confused about the relationship between
the information in (kernel/)Documentation/i386/zero-page.txt and
(kexec-tools-testing/)doc/linux-i386-zero-page.txt.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
