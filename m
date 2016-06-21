Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 21 Jun 2016 03:38:11 -0700
From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: fix kernel image size
Message-ID: <20160621103810.GI22406@atomide.com>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
 <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
 <20160621074319.GH22406@atomide.com>
 <20160621094737.GA5783@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160621094737.GA5783@n2100.arm.linux.org.uk>
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
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Kees Cook <keescook@google.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [160621 02:50]:
> On Tue, Jun 21, 2016 at 12:43:21AM -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > * Russell King <rmk@armlinux.org.uk> [160617 12:52]:
> > > If we want to assume that the compressed image will expand by a maximum
> > > of 4x, we actually need to reserve 5x the space, since we need to keep
> > > a copy of the compessed image around while decompressing.
> > 
> > Looks like 5x is not enough with omap2plus_defconfig at least..
> > This one needs to be set to 6x for that. Maybe we should just make
> > it go all the way to 11 :)
> 
> That's not really what this commit is about - it's about making the
> code consistent with the comments in the file.  I could have instead
> changed the comment saying "4x" to "3x" instead.
> 
> There isn't really an answer which will always work for this problem,
> as I've already detailed in a previous thread discussing the issue.
> Adding a zImage header don't fix the problem.

Well how about we change both comments and code to use a value
that works?

Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
