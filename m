Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from home.nigel.suspend2.net ([203.171.70.205])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYWLx-0002yN-UP
	for kexec@lists.infradead.org; Thu, 20 Sep 2007 20:26:44 -0400
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
Date: Fri, 21 Sep 2007 10:24:34 +1000
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<20070920100941.GA12157@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070920100941.GA12157@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200709211024.35991.nigel@nigel.suspend2.net>
Reply-To: nigel@suspend2.net
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
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi Andrew.

On Thursday 20 September 2007 20:09:41 Pavel Machek wrote:
> Seems like good enough for -mm to me.
> 
> 									Pavel

Andrew, if I recall correctly, you said a while ago that you didn't want 
another hibernation implementation in the vanilla kernel. If you're going to 
consider merging this kexec code, will you also please consider merging 
TuxOnIce?

Regards,

Nigel
-- 
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
