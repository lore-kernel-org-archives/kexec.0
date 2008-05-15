Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwiWx-0006dF-N4
	for kexec@lists.infradead.org; Thu, 15 May 2008 18:50:20 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210830110.23707.141.camel@caritas-dev.intel.com>
Date: Thu, 15 May 2008 11:42:03 -0700
In-Reply-To: <1210830110.23707.141.camel@caritas-dev.intel.com> (Ying Huang's
	message of "Thu, 15 May 2008 13:41:50 +0800")
Message-ID: <m18wybs938.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH -mm] kexec jump -v9
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

"Huang, Ying" <ying.huang@intel.com> writes:

> Hi, Vivek,
>
> On Wed, 2008-05-14 at 16:52 -0400, Vivek Goyal wrote:
> [...]
>> Ok, I have done some testing on this patch. Currently I have just
>> tested switching back and forth between two kernels and it is working for
>> me.
>> 
>> Just that I had to put LAPIC and IOAPIC in legacy mode for it to work. Few
>> comments/questions are inline.
>
> It seems that for LAPIC and IOAPIC, there is
> lapic_suspend()/lapic_resume() and ioapic_suspend()/ioapic_resume(),
> which will be called before/after kexec jump through
> device_power_down()/device_power_up(). So, the mechanism for
> LAPIC/IOAPIC is there, we may need to check the corresponding
> implementation.

And if you start with the device shutdown path the code is already
there and working.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
