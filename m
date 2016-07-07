Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bL6QF-0002cA-0b
 for kexec@lists.infradead.org; Thu, 07 Jul 2016 10:20:45 +0000
Date: Thu, 7 Jul 2016 11:20:04 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: kexec failures with DEBUG_RODATA
Message-ID: <20160707102003.GO1041@n2100.armlinux.org.uk>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
 <20160615211359.GJ1041@n2100.armlinux.org.uk>
 <CAGXu5jKRBA9b6gos+FG7iV2ppxtAERstNPschxA0z=aDL_y1YA@mail.gmail.com>
 <20160615224228.GK1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160615224228.GK1041@n2100.armlinux.org.uk>
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
To: Kees Cook <keescook@google.com>
Cc: Pratyush Anand <panand@redhat.com>, Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jun 15, 2016 at 11:42:28PM +0100, Russell King - ARM Linux wrote:
> The boot environment must be setup such that there is room for the
> uncompressed image (aligned currently to 256 bytes) followed by the
> size of the compressed image, with any appended DTBs included.
> Anything which is located below that is likely to get trampled by
> the decompressor.

There's a question that's been lingering, which hasn't been brought up
by anyone yet: should we even support zImage files with an appended
DTB for kexec?

When kexec is operating in DTB mode, it will provide the DTB to the
kernel from the host environment, possibly with some modifications (eg,
to change the command line arguments.)  Since an appended DTB would
override the kexec-provided DTB, this would wipe out those changes,
some of which are necessary for things like crashdump to work.

So, I'm thinking that kexec should not support a zImage with appended
DTB - in fact, I think it should truncate the zImage to be loaded, and
ensure that the word following the zImage does not contain a DTB magic
number, in case the zImage has been built with CONFIG_ARM_APPENDED_DTB
enabled.

Thoughts?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
