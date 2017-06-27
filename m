Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dPmGk-0006VK-FX
 for kexec@lists.infradead.org; Tue, 27 Jun 2017 08:54:48 +0000
Date: Tue, 27 Jun 2017 09:53:59 +0100
From: Russell King <rmk@armlinux.org.uk>
Subject: Re: [PATCH] kexec:arm: support zImage with appended device tree
Message-ID: <20170627085359.GH837@flint.armlinux.org.uk>
References: <1498208138-19283-1-git-send-email-hoeun.ryu@gmail.com>
 <20170626091412.GE837@flint.armlinux.org.uk>
 <1498531003.1734.13.camel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1498531003.1734.13.camel@gmail.com>
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
To: Hoeun Ryu <hoeun.ryu@gmail.com>
Cc: Matthew Leach <matthew.leach@arm.com>, Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Wang Nan <wangnan0@huawei.com>

On Tue, Jun 27, 2017 at 11:36:43AM +0900, Hoeun Ryu wrote:
> We have some cases when we would like to use different dtb from the
> running system when using kexec and I think that's why kexec-tools
> supports --dtb command line option.
> 
> For example, I have the second kernel for the crash dump with different
> kernel configuration and the different dtb from the running system. I'd
> like to exclude some nodes/properties from dtb like memory reservations
> or unnecessary devices to keep the second kernel/dtb minimal.
> 
> The concatenated zImage for arm has a benefit (whether it's intended or
> not) to make it possible for users to merge multiple boot images into a
> simple single file.
> What I'd like to do is just to support the concatenated zImage so that
> users can use --load(-panic) zImage_with_dtb_from_the_running_system
> instead of --load(-panic) zImage --dtb
> different_dtb_from_the_running_system.

Don't you mean --load(-panic) zImage_with_different_dtb_from_the_running_system
?

So, what you seem to be saying is that you think it's easier for the user
to do this:

# cat zImage some-other-dtb > zImage.dtb
# kexec --load-panic zImage.dtb

rather than:

# kexec --load-panic zImage --dtb some-other-dtb

?

What about the initrd?  Do you want to append that as well?

-- 
Russell King

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
