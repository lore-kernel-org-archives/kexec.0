Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from home.nigel.suspend2.net ([203.171.70.205])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYXBu-0003Kb-9T
	for kexec@lists.infradead.org; Thu, 20 Sep 2007 21:20:26 -0400
From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
Date: Fri, 21 Sep 2007 11:19:59 +1000
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211024.35991.nigel@nigel.suspend2.net>
	<20070920180623.5d7da7b9.akpm@linux-foundation.org>
In-Reply-To: <20070920180623.5d7da7b9.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200709211120.00448.ncunningham@crca.org.au>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi.

On Friday 21 September 2007 11:06:23 Andrew Morton wrote:
> On Fri, 21 Sep 2007 10:24:34 +1000 Nigel Cunningham 
<nigel@nigel.suspend2.net> wrote:
> 
> > Hi Andrew.
> > 
> > On Thursday 20 September 2007 20:09:41 Pavel Machek wrote:
> > > Seems like good enough for -mm to me.
> > > 
> > > 									Pavel
> > 
> > Andrew, if I recall correctly, you said a while ago that you didn't want 
> > another hibernation implementation in the vanilla kernel. If you're going 
to 
> > consider merging this kexec code, will you also please consider merging 
> > TuxOnIce?
> > 
> 
> The theory is that kexec-based hibernation will mainly use preexisting
> kexec code and will permit us to delete the existing hibernation
> implementation.
> 
> That's different from replacing it.

TuxOnIce doesn't remove the existing implementation either. It can 
transparently replace it, but you can enable/disable that at compile time.

Regards,

Nigel
-- 
Nigel Cunningham
Christian Reformed Church of Cobden
103 Curdie Street, Cobden 3266, Victoria, Australia
Ph. +61 3 5595 1185 / +61 417 100 574
Communal Worship: 11 am Sunday.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
