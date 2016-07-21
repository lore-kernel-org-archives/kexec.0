Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 21 Jul 2016 00:00:36 -0700
From: Tony Lindgren <tony@atomide.com>
Subject: Re: kexec failures with DEBUG_RODATA
Message-ID: <20160721070035.GV28140@atomide.com>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
 <20160615211359.GJ1041@n2100.armlinux.org.uk>
 <CAGXu5jKRBA9b6gos+FG7iV2ppxtAERstNPschxA0z=aDL_y1YA@mail.gmail.com>
 <20160615224228.GK1041@n2100.armlinux.org.uk>
 <20160707102003.GO1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160707102003.GO1041@n2100.armlinux.org.uk>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, Kees Cook <keescook@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Russell King - ARM Linux <linux@armlinux.org.uk> [160707 03:25]:
> On Wed, Jun 15, 2016 at 11:42:28PM +0100, Russell King - ARM Linux wrote:
> > The boot environment must be setup such that there is room for the
> > uncompressed image (aligned currently to 256 bytes) followed by the
> > size of the compressed image, with any appended DTBs included.
> > Anything which is located below that is likely to get trampled by
> > the decompressor.
> 
> There's a question that's been lingering, which hasn't been brought up
> by anyone yet: should we even support zImage files with an appended
> DTB for kexec?
> 
> When kexec is operating in DTB mode, it will provide the DTB to the
> kernel from the host environment, possibly with some modifications (eg,
> to change the command line arguments.)  Since an appended DTB would
> override the kexec-provided DTB, this would wipe out those changes,
> some of which are necessary for things like crashdump to work.
> 
> So, I'm thinking that kexec should not support a zImage with appended
> DTB - in fact, I think it should truncate the zImage to be loaded, and
> ensure that the word following the zImage does not contain a DTB magic
> number, in case the zImage has been built with CONFIG_ARM_APPENDED_DTB
> enabled.
> 
> Thoughts?

Sorry for a late reply, I've been offline.

Sounds like a good idea to me as this as we can properly error out
with appendd dtb before anything nasty happens making new kernel
fail. And if somebody really needs it, we can add an option for
--force-appended-dtb.

Regards,

Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
