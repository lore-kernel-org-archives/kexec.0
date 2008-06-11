Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6Efo-0000Go-PW
	for kexec@lists.infradead.org; Wed, 11 Jun 2008 00:58:49 +0000
Subject: Re: [linux-pm] [PATCH -mm 2/2] kexec jump -v11: save/restore
	device state
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <alpine.LFD.1.10.0806101400090.14381@localhost.localdomain>
References: <1213082106.22608.30.camel@caritas-dev.intel.com>
	<alpine.LFD.1.10.0806101400090.14381@localhost.localdomain>
Date: Wed, 11 Jun 2008 09:01:14 +0800
Message-Id: <1213146074.21923.10.camel@caritas-dev.intel.com>
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
To: Len Brown <lenb@kernel.org>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Tue, 2008-06-10 at 14:01 -0400, Len Brown wrote:
> 
> On Tue, 10 Jun 2008, Huang, Ying wrote:
> 
> > This patch implements devices state save/restore before after kexec.
> > 
> > 
> > This patch together with features in kexec_jump patch can be used for
> > following:
> > 
> > - A simple hibernation implementation without ACPI support. You can
> >   kexec a hibernating kernel, save the memory image of original system
> >   and shutdown the system. When resuming, you restore the memory image
> >   of original system via ordinary kexec load then jump back.
> 
> What part of ACPI's role in hibernation are you trying to avoid
> 1. enabling wake devices
> 2. removing power from the system
> 3. something else?

ACPI S5 is used instead of S4 for this simple hibernation
implementation. That is, before creating the hibernation image, the ACPI
_PTS is not executed, devices are not put into low power state and wake
devices are not enabled. After creating the hibernation image, the image
is saved to disk and system is shutdown (go to S5). When resuming from
hibernated image, ACPI _BFS and _WAK are not executed too.

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
