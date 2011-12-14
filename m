Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:4e20:1eda::1] (helo=caramon.arm.linux.org.uk)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rajt8-0001sA-2x
 for kexec@lists.infradead.org; Wed, 14 Dec 2011 08:08:31 +0000
Date: Wed, 14 Dec 2011 08:08:02 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Fix kexec reboot on ARM
Message-ID: <20111214080802.GD14542@n2100.arm.linux.org.uk>
References: <w4fwgnhkcd.wl%peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <w4fwgnhkcd.wl%peter@chubb.wattle.id.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Peter Chubb <peter.chubb@nicta.com.au>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, Dec 14, 2011 at 03:02:10PM +1100, Peter Chubb wrote:
> 
> When kexec() runs, it eventually sets up a 1-to-1 memory map, then
> invokes cpu_reset(). When it invokes cpu_reset (which turns
> off the MMU), it does so at its virtual address.  Across the code that
> disables the MMU, virtual and physical addresses have to be the same,
> otherwise after disabling the MMU, the PC is invalid.
> 
> The simplest fix is to invoke cpu_reset() at its one-to-one mapped
> address.
> 
> I've tested on KZM (arm v6) and Beagleboard (omap)

NAK.

Three reasons:

1. You've not signed-off the patch (please read
   Documentation/SubmittingPatches)
2. pre-ARMv6 do not expect this, and it will break where
   PHYS_OFFSET >= PAGE_OFFSET
3. Have you seen what's already queued for the next merge window?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
