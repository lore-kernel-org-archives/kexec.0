Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wg2wk-0007di-Ca
 for kexec@lists.infradead.org; Fri, 02 May 2014 02:11:31 +0000
Date: Fri, 2 May 2014 11:11:05 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] zImage-arm: get rid of static offset
Message-ID: <20140502021105.GF2265@verge.net.au>
References: <1398940925-11769-1-git-send-email-zonque@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398940925-11769-1-git-send-email-zonque@gmail.com>
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
To: Daniel Mack <zonque@gmail.com>
Cc: s.neumann@raumfeld.com, kexec@lists.infradead.org

On Thu, May 01, 2014 at 12:42:05PM +0200, Daniel Mack wrote:
> The code in arch/arm/kexec-zImage-arm.c currently enforces a hard limit
> on the maximum size a dtb blob can occupy. This limit is set to 32k,
> which is quite low for device tree blobs nowadays.
> 
> Get rid of this assumption, and calculate the added size dynamically.
> For this, we need to slurp in the dtb file earlier in order to
> determine its size, because the memory hole allocation for 'base'
> takes this size into account.
> 
> For ATAGs, we keep the current value of 32k, which should in fact be
> enough.
> 
> With this change in place, the 'DTB too large!' error message can go
> away. Successfully tested on a AM335x board.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> [s.neumann@raumfeld.com: Fix ATAGs case]
> Reported-and-tested-by: Sven Neumann <s.neumann@raumfeld.com>
> ---
> v2 includes a fixup from Sven Neumann for ATAGs driven boards.
> The patch is in tested on a larger number of machines by now.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
