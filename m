Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jwynb-0004xe-7H
	for kexec@lists.infradead.org; Fri, 16 May 2008 12:12:35 +0000
Date: Fri, 16 May 2008 14:13:28 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm] kexec jump -v9
Message-ID: <20080516121328.GD22264@elf.ucw.cz>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210818762.23707.102.camel@caritas-dev.intel.com>
	<20080515200923.GC9718@redhat.com>
	<1210902514.23707.161.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1210902514.23707.161.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Fri 2008-05-16 09:48:34, Huang, Ying wrote:
> On Thu, 2008-05-15 at 16:09 -0400, Vivek Goyal wrote:
> [...]
> > Ok, You want to make BIOS calls. We already do that using vm86 mode and
> > use bios real mode interrupts. So why do we need this interface? Or, IOW,
> > how is this interface better?
> 
> It can call code in 32-bit physical mode in addition to real mode. So It
> can be used to call EFI runtime service, especially call EFI 64 runtime
> service under 32-bit kernel or vice versa.
> 
> The main purpose of kexec jump is for hibernation. But I think if the
> effort is small, why not support general 32-bit physical mode code call
> at same time.

I believe we should focus on kexecing kernels, first.

Only way to prove the effort is small is by having small followup
patch, and that needs the two patches separated...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
