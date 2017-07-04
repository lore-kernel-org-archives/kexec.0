Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dSCrU-0008Hk-SA
 for kexec@lists.infradead.org; Tue, 04 Jul 2017 01:42:46 +0000
Date: Tue, 4 Jul 2017 09:41:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec:arm: support zImage with appended device tree
Message-ID: <20170704014145.GA8657@dhcp-128-65.nay.redhat.com>
References: <1498208138-19283-1-git-send-email-hoeun.ryu@gmail.com>
 <20170626091412.GE837@flint.armlinux.org.uk>
 <1498531003.1734.13.camel@gmail.com>
 <20170627085359.GH837@flint.armlinux.org.uk>
 <BA3D72AC-402C-4148-B49A-560720267961@gmail.com>
 <20170703164109.GJ22756@flint.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170703164109.GJ22756@flint.armlinux.org.uk>
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
To: Russell King <rmk@armlinux.org.uk>
Cc: Matthew Leach <matthew.leach@arm.com>, Hoeun Ryu <hoeun.ryu@gmail.com>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Wang Nan <wangnan0@huawei.com>

On 07/03/17 at 05:41pm, Russell King wrote:
> On Tue, Jun 27, 2017 at 06:51:50PM +0900, Hoeun Ryu wrote:
> > > What about the initrd?  Do you want to append that as well?
> > 
> > I have thought of it.
> > I think It would be better to have it.
> > But I think this is the first step to do so.
> 
> That is something we don't support with the kernel, and would be insane
> to do so - it would mean that the very dumb decompressor would have
> to relocate not only the dtb image, but also the initrd image to
> some other part of memory.  It moves the appended dtb image along with
> the rest of the zImage as one complete blob, but that doesn't work
> so well for an appended initrd.  It will also be rather slow.
> 
> So I'd like to continue my discouragement of this entire approach and
> say that kexec-tools should *not* add support for an appended DTB nor
> an appended initrd.

I also agree that we'd better not adding this in kexec-tools, --dtb
works well, the appended dtb does not gain much but it introduces more
code to maintain.

> 
> The kernel build process gives you the kernel image and dtb file.
> The appended-dtb image support that we have in the kernel is for
> backwards compatibility with non-DT aware boot loaders that only
> know how to deal with one or two images at boot time.
> 
> -- 
> Russell King

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
