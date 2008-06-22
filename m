Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KAVjA-00063r-67
	for kexec@lists.infradead.org; Sun, 22 Jun 2008 19:59:56 +0000
Date: Sun, 22 Jun 2008 21:59:53 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Introduce userspace interface for Firmware-provided memory map
Message-ID: <20080622215953.214419b0@kopernikus.site>
In-Reply-To: <485C149E.1000807@kernel.org>
References: <1213977420-1555-1-git-send-email-bwalle@suse.de>
	<20080620194200.GC21235@redhat.com> <485C149E.1000807@kernel.org>
Mime-Version: 1.0
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
To: "H. Peter Anvin" <hpa@kernel.org>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

Hi,

* "H. Peter Anvin" <hpa@kernel.org> [2008-06-20 13:35]:
>
> Vivek Goyal wrote:
> > On Fri, Jun 20, 2008 at 05:56:57PM +0200, Bernhard Walle wrote:
> >> This patch (as request for comments) introduces a new userspace interface
> >> /proc/firmware_mem that provides the unfiltered view of the BIOS on
> >> memory configuration. That's usable for two reasons:
> > 
> > How about /proc/firmware_memmap. This is little longish but probably more
> > clear in intent.
> 
> Perhaps even /proc/firmware/memmap (or /sys/firmware/memmap/...).  I 
> realize introducing a new directory is annoying, but it's a namespace 
> that is likely to have other users.

Since /sys/firmware is already used by ACPI and EDD, I think that's
quite a good idea! Maybe we should also export the raw E820 or EFI
memory map there. Just like EDD.

I'll send a new patch.




Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
