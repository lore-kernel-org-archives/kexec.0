Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KCIZR-0007S0-3A
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 18:21:17 +0000
Date: Fri, 27 Jun 2008 11:18:33 -0700
From: Greg KH <gregkh@suse.de>
Subject: Re: x86: Add /sys/firmware/memmap
Message-ID: <20080627181833.GA7735@suse.de>
References: <1214565175-21512-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1214565175-21512-1-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, yhlu.kernel@gmail.com, vgoyal@redhat.com, linux-kernel@vger.kernel.org

On Fri, Jun 27, 2008 at 01:12:53PM +0200, Bernhard Walle wrote:
> This patch series adds a new interface /sys/firmware/memmap to export
> the BIOS (Firmware) provided memory map via sysfs for usage with
> kexec.
> 
> While the first patch adds the generic interface, the second patch
> implements that interface for E820 on x86.
> 
> Change compared to previous commit:
> 
>  1. Comments from Greg KH.
>  2. Documentation.
> 
> The patch has been tested on i386 and x86_64 with success.
> 

Looks good, want me to take this through my tree (due to the firmware
core change)?  If so, can you get an ack on the x86 portion from the
respective people as well?

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
