Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDK0C-0000Fg-NM
 for kexec@lists.infradead.org; Wed, 15 Jun 2016 23:13:41 +0000
Date: Thu, 16 Jun 2016 00:13:03 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: kexec failures with DEBUG_RODATA
Message-ID: <20160615231303.GL1041@n2100.armlinux.org.uk>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
 <20160615211359.GJ1041@n2100.armlinux.org.uk>
 <CAGXu5jKRBA9b6gos+FG7iV2ppxtAERstNPschxA0z=aDL_y1YA@mail.gmail.com>
 <20160615224228.GK1041@n2100.armlinux.org.uk>
 <CAGXu5jLqNeYe_=7a5XC6UW4G3WiRQrrBvgernmugw_r2y0Nshg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGXu5jLqNeYe_=7a5XC6UW4G3WiRQrrBvgernmugw_r2y0Nshg@mail.gmail.com>
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
Cc: Pratyush Anand <panand@redhat.com>, Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Baoquan He <bhe@redhat.com>

On Wed, Jun 15, 2016 at 03:54:38PM -0700, Kees Cook wrote:
> On Wed, Jun 15, 2016 at 3:42 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > In fact, the apparent confusion over this reinforces my belief that we
> > should _not_ give the size of the uncompressed image at all.
> >
> > The boot environment must be setup such that there is room for the
> > uncompressed image (aligned currently to 256 bytes) followed by the
> > size of the compressed image, with any appended DTBs included.
> > Anything which is located below that is likely to get trampled by
> > the decompressor.
> 
> Okay, sounds reasonable to me. :)

I should point out that this method should work for a zImage without
an appended DTB, and we have no way to update this header block for
the appended DTB case.

So, an alternative standpoint is that we supply only the uncompressed
image size.  Then, the boot environment needs to understand that they
must allow for the compressed image and any appended DTB on top of that
(which it would see as one - the size of the combined image.)

However, while that may sound like a good idea, we're falling into the
same trap that we've fallen into at the beginning of this thread: the
boot environment has to understand how the decompressor currently works,
and if we were to change that, this we're back to the calculation which
the boot environment is using not matching reality.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
