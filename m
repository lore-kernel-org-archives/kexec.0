Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1e9o7C-0002s5-8r
 for kexec@lists.infradead.org; Wed, 01 Nov 2017 08:11:12 +0000
Date: Wed, 1 Nov 2017 09:10:36 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] ARM: read kernel size from zImage
Message-ID: <20171101081036.57ahx2bymugl5s37@verge.net.au>
References: <20171023100834.GA5462@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171023100834.GA5462@n2100.armlinux.org.uk>
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
To: Russell King <rmk@armlinux.org.uk>
Cc: kexec@lists.infradead.org

On Mon, Oct 23, 2017 at 11:08:34AM +0100, Russell King wrote:
> Read the new extension data which tells the boot agent about the
> requirements for booting the kernel image, such as how much RAM
> will be consumed by the kernel through decompression and booting.
> This is necessary to control the placement of the DTB and
> compressed RAM disk to avoid these objects being corrupted.
> 
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Russell King <rmk@armlinux.org.uk>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
