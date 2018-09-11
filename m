Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fzhll-0006cJ-PR
 for kexec@lists.infradead.org; Tue, 11 Sep 2018 12:27:55 +0000
Date: Tue, 11 Sep 2018 14:27:35 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] multiboot-x86: pass framebuffer information when requested
Message-ID: <20180911122735.eib55j7sew47hgeo@verge.net.au>
References: <69E6683EA6F9200C6AE6CDD7F567E6D0@felloff.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69E6683EA6F9200C6AE6CDD7F567E6D0@felloff.net>
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
To: cinap_lenrek@felloff.net
Cc: kexec@lists.infradead.org

On Thu, Aug 02, 2018 at 04:05:30PM +0200, cinap_lenrek@felloff.net wrote:
> When the kernel requests video information, pass it the
> framebuffer information in the multiboot header from
> the linux framebuffer ioctl's.
> 
> With the arch specific --reset-vga or --consolve-vga
> options, purgatory will reset the framebuffer so pass
> information for standard ega text mode.
> 
> Signed-off-by: Friedemann Gerold <cinap_lenrek@felloff.net>

This seems reasonable to me, but I would value a third-party review
of this change.

Reviewed-by: Simon Horman <horms@verge.net.au>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
