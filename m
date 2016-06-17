Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDzj8-0006T4-C5
 for kexec@lists.infradead.org; Fri, 17 Jun 2016 19:46:51 +0000
Date: Fri, 17 Jun 2016 20:44:05 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [PATCH 0/2] Simple fix to the ARM kexec tools implementation
Message-ID: <20160617194405.GN1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Kees Cook <keescook@google.com>, Simon Horman <horms@verge.net.au>, Baoquan He <bhe@redhat.com>, Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

This is the "simple" fix for the ARM kexec tools code, which makes
the code actually do what the comments describe.

There are two problems:

1. When placing the initrd, we do not take account of the 32k offset
   that is required for the kernel image.

2. The code claims to allow the zImage decompressor to expand by a
   factor of 4, but only allows space for a factor of 3, since the
   decompressor itself has to fit in this memory space as well.

Changing the code to follow the comments allows Keystone II to kexec
with DEBUG_RODATA enabled, at least with the kernel I've been testing
with.

This is a stop-gap solution until a better solution can be implemented.

 kexec/arch/arm/kexec-zImage-arm.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
