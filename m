Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBTh4-0003OX-NP
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 12:01:47 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: Limit E820 map when specifying mem parameter
Date: Wed, 25 Jun 2008 14:02:19 +0200
Message-Id: <1214395342-20375-1-git-send-email-bwalle@suse.de>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, yhlu.kernel@gmail.com

This patch modifies the E820 map when specifying the mem kernel command line
parameter. That's the behaviour i386 had before the merging work in the
current "tip" tree.

As Yinghai Lu pointed out in email discussion, e820_update_range() should be
used for the updating instead of an own function. Two modifications in
e820_update_range() are necessary:

 1. Fix a small bug that prevented the partically covered entry from
    being stripped (size is not updated).
 
 2. Small API extension to be able to specify size == ULLONG_MAX to 
    update the whole map from size to the end.

The modification is necessary that kexec can build the ELF core headers only
for the used memory. Once the exporting of the real, unmodified memory map is
in the kernel, kexec can use the raw map and still reboot with full memory
size.

The patch is against 2.6.26-rc7-tip and has been successfully tested on i386
and x86-64, with and without "mem" parameter.




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
