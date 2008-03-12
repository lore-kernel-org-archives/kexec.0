Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZGgI-0004E5-2M
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 02:27:02 +0000
Subject: Re: [PATCH -mm] kexec jump -v9
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <200803112318.28120.rjw@sisk.pl>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>  <200803112318.28120.rjw@sisk.pl>
Date: Wed, 12 Mar 2008 10:26:28 +0800
Message-Id: <1205288788.29875.28.camel@caritas-dev.intel.com>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Tue, 2008-03-11 at 23:18 +0100, Rafael J. Wysocki wrote:
> On Tuesday, 11 of March 2008, Vivek Goyal wrote:
[...]
> > Rafael/Pavel, does the approach of doing hibernation using a separate
> > kernel holds promise?
> 
> Well, what can I say?
> 
> I haven't been a big fan of doing hibernation this way since the very beginning
> and I still have the same reservations.  Namely, my opinion is that the
> hibernation-related problems we have are not just solvable this way.  For one
> example, in order to stop using the freezer for suspend/hibernation we first
> need to revamp the suspending/resuming of devices (uder way) and the
> kexec-based approach doesn't help us here.  I wouldn't like to start another
> discussion about it though.

Yes. We need to work on device drivers for all hibernation
implementations. And kexec-based hibernation provides a possible method
to avoid freezer after driver works done.

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
