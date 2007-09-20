Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga03.intel.com ([143.182.124.21])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYHEP-0001r3-Oz
	for kexec@lists.infradead.org; Thu, 20 Sep 2007 04:17:58 -0400
Subject: Re: [RFC][PATCH 2/2 -mm] kexec based hibernation -v3: kexec restore
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20070920081524.GA8732@atrey.karlin.mff.cuni.cz>
References: <1190266450.21818.18.camel@caritas-dev.intel.com>
	<20070920081524.GA8732@atrey.karlin.mff.cuni.cz>
Date: Thu, 20 Sep 2007 16:19:41 +0800
Message-Id: <1190276381.21818.21.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Thu, 2007-09-20 at 10:15 +0200, Pavel Machek wrote:
> > This patch adds writing support for /dev/oldmem. This is used to
> > restore the memory contents of hibernated system.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ACK. (And this can even go in before the patch #1, right?)

Yes. This patch does not depend on patch #1.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
