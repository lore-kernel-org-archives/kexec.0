Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBxvF-0001S7-LX
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 20:18:25 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: x86: Add /sys/firmware/memmap
Date: Thu, 26 Jun 2008 22:19:00 +0200
Message-Id: <1214511542-28458-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: x86@kernel.org
Cc: Bernhard Walle <bwalle@suse.de>, gregkh@suse.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com, vgoyal@redhat.com

This patch series adds a new interface /sys/firmware/memmap to export
the BIOS (Firmware) provided memory map via sysfs for usage with
kexec.

While the first patch adds the generic interface, the second patch
implements that interface for E820 on x86.

Change compared to previous commit:

 1. Added Greg KH to Cc as suggested by H. Peter Anvin to review sysfs
    structure.
 
 2. Display the configuration option only if CONFIG_EMBEDDED is set.
    If not, default to including the code in any case as it is not only
    useful for kexec.

Please review!


Signed-off-by: Bernhard Walle <bwalle@suse.de>




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
