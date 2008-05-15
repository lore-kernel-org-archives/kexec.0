Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwW87-0006IG-30
	for kexec@lists.infradead.org; Thu, 15 May 2008 05:35:55 +0000
Subject: Re: [PATCH -mm] kexec jump -v9
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20080514205204.GJ30469@redhat.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
Date: Thu, 15 May 2008 13:41:50 +0800
Message-ID: <1210830110.23707.141.camel@caritas-dev.intel.com>
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

Hi, Vivek,

On Wed, 2008-05-14 at 16:52 -0400, Vivek Goyal wrote:
[...]
> Ok, I have done some testing on this patch. Currently I have just
> tested switching back and forth between two kernels and it is working for
> me.
> 
> Just that I had to put LAPIC and IOAPIC in legacy mode for it to work. Few
> comments/questions are inline.

It seems that for LAPIC and IOAPIC, there is
lapic_suspend()/lapic_resume() and ioapic_suspend()/ioapic_resume(),
which will be called before/after kexec jump through
device_power_down()/device_power_up(). So, the mechanism for
LAPIC/IOAPIC is there, we may need to check the corresponding
implementation.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
