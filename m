Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([143.182.124.37])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwpHK-0004O8-Sf
	for kexec@lists.infradead.org; Fri, 16 May 2008 02:02:39 +0000
Subject: Re: [PATCH -mm] kexec jump -v9
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20080516015142.GB6926@redhat.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210818762.23707.102.camel@caritas-dev.intel.com>
	<20080515200923.GC9718@redhat.com>
	<1210902514.23707.161.camel@caritas-dev.intel.com>
	<20080516015142.GB6926@redhat.com>
Date: Fri, 16 May 2008 10:08:06 +0800
Message-ID: <1210903686.23707.171.camel@caritas-dev.intel.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Thu, 2008-05-15 at 21:51 -0400, Vivek Goyal wrote:
> On Fri, May 16, 2008 at 09:48:34AM +0800, Huang, Ying wrote:
> > On Thu, 2008-05-15 at 16:09 -0400, Vivek Goyal wrote:
> > [...]
> > > Ok, You want to make BIOS calls. We already do that using vm86 mode and
> > > use bios real mode interrupts. So why do we need this interface? Or, IOW,
> > > how is this interface better?
> > 
> > It can call code in 32-bit physical mode in addition to real mode. So It
> > can be used to call EFI runtime service, especially call EFI 64 runtime
> > service under 32-bit kernel or vice versa.
> > 
> > The main purpose of kexec jump is for hibernation. But I think if the
> > effort is small, why not support general 32-bit physical mode code call
> > at same time.
> > 
> 
> In general what's the environment requirements for EFI runtime 
> services? I mean, just that processor should be in protected mode with
> paging disabled or one need to stop all other cpus and devices and then make
> the call (as we are doing in this case?). 

Put processor in protected mode with paging disabled is sufficient. In
one of previous kexec jump versions, I provide some option to choose the
state saved (whether stop other cpus, whether stop devices).

I agree that now we should focus on kexec based hibernation. But I think
it is reasonable to keep the possibility with minimal effort.

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
