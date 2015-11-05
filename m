Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1on0137.outbound.protection.outlook.com
 ([157.56.110.137] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZuDY4-0002Jo-1j
 for kexec@lists.infradead.org; Thu, 05 Nov 2015 05:57:25 +0000
Message-ID: <1446703011.12676.83.camel@freescale.com>
Subject: Re: [PATCH] kexec: Add --lite option
From: Scott Wood <scottwood@freescale.com>
Date: Wed, 4 Nov 2015 23:56:51 -0600
In-Reply-To: <1445540891.30908.144.camel@infradead.org>
References: <1445469125.30908.105.camel@infradead.org>
 <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
 <20151022125012.GB20847@redhat.com>
 <1445540891.30908.144.camel@infradead.org>
MIME-Version: 1.0
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
To: Geoff Levand <geoff@infradead.org>
Cc: panand@redhat.com, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Petitboot@lists.ozlabs.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2015-10-22 at 12:08 -0700, Geoff Levand wrote:
> Hi Vivek,
> 
> On Thu, 2015-10-22 at 08:50 -0400, Vivek Goyal wrote:
> > On Thu, Oct 22, 2015 at 11:17:18AM +0800, Dave Young wrote:
> > > On 10/21/15 at 04:12pm, Geoff Levand wrote:
> > > > Add a new option --lite to kexec that allows for a fast reboot
> > > > by avoiding the purgatory integrity checks.  This option is
> > > > intended for use by kexec based bootloaders that load a new
> > > > image and then immediately transfer control to it.
> > > 
> > > I think Vivek was rejecting this --lite since kdump need the purgatory
> > > integrity checks. Ccing him.
> > 
> > Right. Why are we trying to bypass sha256 hash verification of loaded
> > segments at run time, that needs to be justified. 
> 
> Please see my reply to Dave.
> 
> > Atleast on x86, this integrity verification was fast and we did not
> > notice any siginificant delays in purgatory. And in that case extra knob
> > like this is hard to justify.
> 
> I notice the difference on the my arm64 system, so I guess we
> are even on that.

For me it was beyond "notice the difference" -- I thought it was completely 
broken, and was preparing to debug, until it started spitting out output over 
a minute later.

Compiling the sha256 code with -O2 instead of -O0 cut it down to around 10 
seconds (still unpleasant, but not quite as crazy... still unacceptable for 
non-kdump, though).  There was a patch posted a couple years ago to do that --
does anyone know what happened to it?

http://kexec.infradead.narkive.com/JSemzXoT/patch-purgatory-compile-sha256-c-only-on-ia64-with-o0

-Scott



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
