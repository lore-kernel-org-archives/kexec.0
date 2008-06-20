Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by casper.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1K9nZj-0006u1-Bv
	for kexec@lists.infradead.org; Fri, 20 Jun 2008 20:51:18 +0000
Message-ID: <485C149E.1000807@kernel.org>
Date: Fri, 20 Jun 2008 13:35:42 -0700
From: "H. Peter Anvin" <hpa@kernel.org>
MIME-Version: 1.0
Subject: Re: Introduce userspace interface for Firmware-provided memory map
References: <1213977420-1555-1-git-send-email-bwalle@suse.de>
	<20080620194200.GC21235@redhat.com>
In-Reply-To: <20080620194200.GC21235@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> On Fri, Jun 20, 2008 at 05:56:57PM +0200, Bernhard Walle wrote:
>> This patch (as request for comments) introduces a new userspace interface
>> /proc/firmware_mem that provides the unfiltered view of the BIOS on
>> memory configuration. That's usable for two reasons:
> 
> How about /proc/firmware_memmap. This is little longish but probably more
> clear in intent.

Perhaps even /proc/firmware/memmap (or /sys/firmware/memmap/...).  I 
realize introducing a new directory is annoying, but it's a namespace 
that is likely to have other users.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
