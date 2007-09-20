Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYIyc-0002yX-Fv
	for kexec@lists.infradead.org; Thu, 20 Sep 2007 06:09:45 -0400
Date: Thu, 20 Sep 2007 12:09:41 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
Message-ID: <20070920100941.GA12157@atrey.karlin.mff.cuni.cz>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1190266447.21818.17.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi!

> This patch implements the functionality of jumping between the kexeced
> kernel and the original kernel.
> 
> A new reboot command named LINUX_REBOOT_CMD_KJUMP is defined to
> trigger the jumping to (executing) the new kernel and jumping back to
> the original kernel.
> 
> To support jumping between two kernels, before jumping to (executing)
> the new kernel and jumping back to the original kernel, the devices
> are put into quiescent state (to be fully implemented), and the state
> of devices and CPU is saved. After jumping back from kexeced kernel
> and jumping to the new kernel, the state of devices and CPU are
> restored accordingly. The devices/CPU state save/restore code of
> software suspend is called to implement corresponding function.
> 
> To support jumping without preserving memory. One shadow backup page
> is allocated for each page used by new (kexeced) kernel. When do
> kexec_load, the image of new kernel is loaded into shadow pages, and
> before executing, the original pages and the shadow pages are swapped,
> so the contents of original pages are backuped. Before jumping to the
> new (kexeced) kernel and after jumping back to the original kernel,
> the original pages and the shadow pages are swapped too.
> 
> A jump back protocol is defined and documented.


> Signed-off-by: Huang Ying <ying.huang@intel.com>

Seems like good enough for -mm to me.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
