Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga03.intel.com ([143.182.124.21])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZGBN-0004zM-Cz
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 01:55:05 +0000
Subject: Re: [PATCH -mm] kexec jump -v9
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <200803120049.06491.rjw@sisk.pl>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com> <20080311232415.GA26320@elf.ucw.cz>
	<200803120049.06491.rjw@sisk.pl>
Date: Wed, 12 Mar 2008 09:55:37 +0800
Message-Id: <1205286937.29875.9.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Wed, 2008-03-12 at 00:49 +0100, Rafael J. Wysocki wrote:
> On Wednesday, 12 of March 2008, Pavel Machek wrote:
[...]
> > 
> > Its certainly "more traditional" method of doing hibernation than
> > tricks swsusp currently plays.
> 
> What exactly are you referring to?

Long long ago, the hibernation is not done by Linux kernel itself but
BIOS (APM). Those days, kernel just does some preparation and jump to
BIOS to do the hibernation. Imagine kernel B is the hibernation BIOS,
kernel A does some prepare and jump to the BIOS (kernel B) just like the
old days.

> > Yes, I'd like these patches to go in, being able to switch kernels seems like
> > useful tool. 
> 
> No objection from me.
>  
> > Now, I guess they are some difficulties, like ACPI integration, and
> > some basic drawbacks, like few seconds needed to boot second kernel
> > during suspend.
> > 
> > ...OTOH this is probably only chance to eliminate freezer from
> > swsusp...
> 
> Some facts:
> 
> * In order to be able to do suspend (STR) without the freezer, we need to make
>   device drivers block access to devices from applications during suspend.
> * There's no reason to think that we can't use this same mechanism for
>   hibernation (the only difficulty seems to be the handling of devices used for
>   saving the image).

I think "kexec based hibernation" is the only currently available
possible method to write out image without freezer (after driver works
are done). If other process is running, how to prevent them from writing
to disk without freezing them in current implementation?

> * We need the drivers to quiesce devices to be able to do the kexec jump in the
>   first place (and to avoid races, we'll need them to block applications'
>   access to devices just like for STR, which is the sufficient condition for
>   removing the freezer).
> 
> So, I don't really think that the "freezer removal" argument is valid here.
> 
> Moreover, if this had been the _only_ argument for the $subject functionality,
> I'd have been against it.

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
