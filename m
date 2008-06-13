Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6xfT-0006JO-Q9
	for kexec@lists.infradead.org; Fri, 13 Jun 2008 01:01:28 +0000
Subject: Re: [PATCH -mm 1/2] kexec jump -v11: kexec jump
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20080612192015.GH9654@redhat.com>
References: <1213082104.22608.29.camel@caritas-dev.intel.com>
	<20080612192015.GH9654@redhat.com>
Date: Fri, 13 Jun 2008 09:04:00 +0800
Message-Id: <1213319040.20431.8.camel@caritas-dev.intel.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Thu, 2008-06-12 at 15:20 -0400, Vivek Goyal wrote:
> On Tue, Jun 10, 2008 at 03:15:04PM +0800, Huang, Ying wrote:
> > This patch provides an enhancement to kexec/kdump. It implements
> > the following features:
> > 
> > - Backup/restore memory used by the original kernel before/after
> >   kexec.
> > 
> > - Save/restore CPU state before/after kexec.
> > 
> > The features of this patch can be used as a general method to call
> > program in physical mode (paging turning off). This can be used to
> > call BIOS code under Linux.
> > 
> > 
> 
> Hi Huang,
> 
> I was testing these patches and I get following error on my machine.
> 
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: Device i8042 failed to freeze: error -22
> Restarting tasks ... done.
> 
> Any idea why keyboard controller would not freeze?

Which kernel version do you use?

Does original hibernation work? It can be setup easily. Just add
following parameters to kernel command line:

resume=/dev/<xxx>

Where <xxx> is the swap partition.

And execute following command:

echo reboot > /sys/power/disk
echo disk > /sys/power/state

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
