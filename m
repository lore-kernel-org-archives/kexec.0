Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KCDam-0005WG-8G
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 13:02:20 +0000
Date: Fri, 27 Jun 2008 09:01:41 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: x86: Add /sys/firmware/memmap
Message-ID: <20080627130141.GA5801@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, gregkh@suse.de, yhlu.kernel@gmail.com

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

This patchset looks good to me. We do need this functionality for doing
the right thing for kexec and kdump users.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
