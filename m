Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZwZx-0003hD-LL
	for kexec@lists.infradead.org; Thu, 13 Mar 2008 23:11:18 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
	<200803122253.07631.rjw@sisk.pl>
	<m1iqzrxy26.fsf@ebiederm.dsl.xmission.com>
	<200803131803.31120.rjw@sisk.pl>
Date: Thu, 13 Mar 2008 17:07:17 -0600
In-Reply-To: <200803131803.31120.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 13 Mar 2008 18:03:29 +0100")
Message-ID: <m1ejaew7dm.fsf@ebiederm.dsl.xmission.com>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From the ACPI compliance point of view it's better to do it this way.  We need
> to put the devices into low power states anyway before "powering off" the
> system and we won't need to touch them for the second time if we do that
> in advance.

Interesting.  From a kexec jump where we exit the kernel and then return
to it seem all that is required.

I will have to look at the ACPI case.  That seems to be the lynch pin
of a couple of arguments for doing strange things: ACPI requires it.

> Still, it would be sufficient if we disconnected the drivers from the hardware
> and thus prevented applications from accessing that hardware.

My gut feeling is that except for a handful of drivers we could even
get away with simply implementing hot unplug and hot replug.  Disks
are the big exception here.

Which suggests to me that it is at least possible that the methods we
want for a kexec jump hibernation may be different from an in-kernel
hibernation and quite possibly are easier to implement.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
