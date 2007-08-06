Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IHsNW-00065e-A0
	for kexec@lists.infradead.org; Sun, 05 Aug 2007 22:31:31 -0400
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec based
	hibernation
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20070805185558.GE1758@elf.ucw.cz>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070731110458.GA1777@elf.ucw.cz>
	<1185932071.1363.13.camel@caritas-dev.intel.com>
	<20070805185558.GE1758@elf.ucw.cz>
Date: Mon, 06 Aug 2007 10:31:26 +0800
Message-Id: <1186367486.527.5.camel@caritas-dev.intel.com>
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
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Sun, 2007-08-05 at 20:55 +0200, Pavel Machek wrote:
> Did the trick, I got the kernel to load, and it even attempted
> exec... but I got doublefault (or what is it?)
> 
> Int 6: ... EIP: c4739906. Address is in reserve_bootmem_core.
> 
> Do I have to disable ACPI completely? I tried with acpi=off,
> nosmp... but problem does not seem device related.

It seems that the problem has nothing to do with device or ACPI. Can you
do a normal kexec? That is:

kexec -l <...>
kexec -e

or 

kexec -p <...>
ALT-SysRq-c to trigger a crash dump.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
