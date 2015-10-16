Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zmu8n-0000kv-4E
 for kexec@lists.infradead.org; Fri, 16 Oct 2015 01:49:05 +0000
Date: Fri, 16 Oct 2015 10:48:38 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 3/3] ppc64: Add a flag to tell the kernel it's booting
 from kexec
Message-ID: <20151016014838.GG20667@verge.net.au>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
 <1444172150-29493-3-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1444172150-29493-3-git-send-email-scottwood@freescale.com>
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
To: Scott Wood <scottwood@freescale.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>

On Tue, Oct 06, 2015 at 05:55:50PM -0500, Scott Wood wrote:
> It needs to know this because the SMP release mechanism for Freescale
> book3e is different from when booting with normal hardware.  In theory
> we could simulate the normal spin table mechanism, but not (easily) at
> the addresses U-Boot put in the device tree -- so there'd need to be
> even more communication between the kernel and kexec to set that up.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> v2: Use a device tree property rather than setting a flag in the kernel
> image, as requested by Michael Ellerman.

I'd value a review of this from someone more familiar with ppc than I.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
