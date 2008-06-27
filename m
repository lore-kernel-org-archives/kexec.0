Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KCBsJ-0004YO-BS
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 11:12:19 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: x86: Add /sys/firmware/memmap
Date: Fri, 27 Jun 2008 13:12:53 +0200
Message-Id: <1214565175-21512-1-git-send-email-bwalle@suse.de>
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
Cc: gregkh@suse.de, kexec@lists.infradead.org, yhlu.kernel@gmail.com, vgoyal@redhat.com, linux-kernel@vger.kernel.org

This patch series adds a new interface /sys/firmware/memmap to export
the BIOS (Firmware) provided memory map via sysfs for usage with
kexec.

While the first patch adds the generic interface, the second patch
implements that interface for E820 on x86.

Change compared to previous commit:

 1. Comments from Greg KH.
 2. Documentation.

The patch has been tested on i386 and x86_64 with success.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
