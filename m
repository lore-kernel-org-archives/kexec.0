Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K9mao-0004uI-Em
	for kexec@lists.infradead.org; Fri, 20 Jun 2008 19:48:18 +0000
Date: Fri, 20 Jun 2008 15:42:00 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Introduce userspace interface for Firmware-provided memory map
Message-ID: <20080620194200.GC21235@redhat.com>
References: <1213977420-1555-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1213977420-1555-1-git-send-email-bwalle@suse.de>
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
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Jun 20, 2008 at 05:56:57PM +0200, Bernhard Walle wrote:
> This patch (as request for comments) introduces a new userspace interface
> /proc/firmware_mem that provides the unfiltered view of the BIOS on
> memory configuration. That's usable for two reasons:
> 

How about /proc/firmware_memmap. This is little longish but probably more
clear in intent.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
