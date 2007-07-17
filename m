Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga03.intel.com ([143.182.124.21])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IAmUf-0002an-6L
	for kexec@lists.infradead.org; Tue, 17 Jul 2007 08:49:36 -0400
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base	hibernation
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <Pine.LNX.4.64.0707170101010.19248@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707141159.47289.rjw@sisk.pl>
	<1184410554.1898.84.camel@caritas-dev.intel.com>
	<200707142116.10237.rjw@sisk.pl>
	<1184491804.1898.121.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707170101010.19248@asgard.lang.hm>
Date: Tue, 17 Jul 2007 20:48:38 +0800
Message-Id: <1184676518.10998.34.camel@caritas-dev.intel.com>
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
To: david@lang.hm
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Tue, 2007-07-17 at 01:13 -0700, david@lang.hm wrote:
> however, since the resume designed for ACPI won't work would the following 
> approach work
> 
> 1. boot one kernel
> 2. setup a kexec the same way you would for hibernate
> 3. kexec to the new kernel
> 4. overwrite the memory of the first kernel
> 5. kexec 'back' to the main kernel that has now been overwritten by what was saved?
> 
> as part of this question, when you do a kexec, how does the kernel that 
> you are doing the kexec to know what to run next?

For kernel in 3 that do kexec, the devices and CPU state are saved into
memory before executing the new kernel. So when jumping back, the
control will continue from kexec point. If the memory image of main
kernel is restored from disk, the devices and CPU state in memory is
restored too. Before jumping back in 5, the devices are put in the known
state, after jumping back, the devices and CPU state is restored. If the
"kexec -j" is used to trigger the kexec in 3, the system will continue
with "kexec -j" exiting with exit code 0.

> it needs to do some initialization first before it starts running normal 
> things, and at that point it the move back doesn't look for init like a 
> normal kernel boot (or the system would effectivly boot instead of picking 
> up where it left off)

I think the early initialization can be done in a initramfs. At that
point, the resume image can be checked, the next step depends on the
result of checking.

> is this 'restart point' flexible enough that either the pre-hibernate 
> kerenl or the small hibernate kernel could tell the pre-hibernate kernel 
> to go into suspend-to-ram mode before doing anything else?

It is possible for hibernate kernel to pass information back to
pre-hibernate kernel. For example, the information can be passed in jump
buffer page. 

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
