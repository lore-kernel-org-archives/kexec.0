Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JyhBV-0004TB-2A
	for kexec@lists.infradead.org; Wed, 21 May 2008 05:48:21 +0000
Received: from yukiko.shinjuku.tokyo.vergenet.net (unknown [202.128.116.96])
	by koto.vergenet.net (Postfix) with ESMTP id 038A93406E
	for <kexec@lists.infradead.org>; Wed, 21 May 2008 14:48:17 +0900 (JST)
Date: Wed, 21 May 2008 15:48:14 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Remove the 'bzImage' warning from manpage
Message-ID: <20080521054812.GB3714@verge.net.au>
References: <20080508160103.GA30762@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080508160103.GA30762@suse.de>
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

On Thu, May 08, 2008 at 06:01:03PM +0200, Bernhard Walle wrote:
> This patch removes the warning
> 
>    Compressed kernel images such as bzImage are not supported by kexec.
>    Use the uncompressed vmlinux.
> 
> from the manual page as this is wrong now. Contrary, the usage of bzImage for
> kdump is recommended because on x86_64 it's the only way to use a relocatable
> kernel for dumping.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Thanks, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
