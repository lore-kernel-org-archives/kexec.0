Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [2002:4e20:1eda::1] (helo=caramon.arm.linux.org.uk)
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R6935-00074g-Gy
	for kexec@lists.infradead.org; Tue, 20 Sep 2011 22:44:21 +0000
Date: Tue, 20 Sep 2011 23:43:49 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2] ARM: kdump: copy kernel relocation code at the
	kexec prepare stage
Message-ID: <20110920224349.GC17169@n2100.arm.linux.org.uk>
References: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
	<1316520043-14619-1-git-send-email-leiwen@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1316520043-14619-1-git-send-email-leiwen@marvell.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Lei Wen <leiwen@marvell.com>
Cc: Yu Tang <ytang5@marvell.com>, Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chao Xie <cxie4@marvell.com>

On Tue, Sep 20, 2011 at 08:00:43PM +0800, Lei Wen wrote:
> This copy really don't need to do at the very second before the kernel
> would crash.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> Acked-by: Simon Horman <horms@verge.net.au>
> ---
> Changelog:
> V2: move the flush_icache_range after the memcpy operation to ensure I/D cache
>     coherency for the relocation code

Much better, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
