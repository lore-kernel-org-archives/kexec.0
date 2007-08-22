Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1INk3D-0000qe-M5
	for kexec@lists.infradead.org; Wed, 22 Aug 2007 02:50:49 -0400
Subject: Re: [linux-pm] Re: [PATH 1/1] Kexec jump - v2 - kexec jump
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20070821101404.GA1704@elf.ucw.cz>
References: <1184483639.1898.99.camel@caritas-dev.intel.com>
	<20070731095101.GA1774@elf.ucw.cz>
	<1185954978.1363.23.camel@caritas-dev.intel.com>
	<20070816102635.GA2039@elf.ucw.cz>
	<1187331349.28497.9.camel@caritas-dev.intel.com>
	<20070821101404.GA1704@elf.ucw.cz>
Date: Wed, 22 Aug 2007 14:51:11 +0800
Message-Id: <1187765471.20920.62.camel@caritas-dev.intel.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Tue, 2007-08-21 at 12:14 +0200, Pavel Machek wrote:
> Ok, I got it to work -- thanks a lot.
> 
> Yes, acpi=off is mandatory. Unfortunately, thinkpad x60 does not boot
> with acpi=off (should we add another test to linux firmware kit?
> Machines should still boot in acpi=off mode...). acpi=off noapic
> nolapic nosmp makes it boot, and that in turn makes kjump work.
> 
> Screen is not refreshed on kjump back to original kernel, but I guess
> that's to be expected. I did not play with framebuffer, yet.
> 
> Maybe it is time to move kjump functionality into -mm and
> kexec-testing?

Now I have worked out a full kexec based hibernation prototype,
including kexec, write out the image, reboot, restore the memory and
jump back. I will release it recently. :)

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
