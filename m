Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IBRxh-0002WS-7L
	for kexec@lists.infradead.org; Thu, 19 Jul 2007 05:06:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec based
	hibernation
Date: Thu, 19 Jul 2007 11:13:21 +0200
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070718180420.02352d4f.akpm@linux-foundation.org>
	<1184827403.15756.14.camel@caritas-dev.intel.com>
In-Reply-To: <1184827403.15756.14.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200707191113.22711.rjw@sisk.pl>
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
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Thursday, 19 July 2007 08:43, Huang, Ying wrote:
> On Wed, 2007-07-18 at 18:04 -0700, Andrew Morton wrote:
> > I like the idea but I think I'll let people chat about it a bit more
> > before looking at merging the patches, OK?
> 
> I think maybe we should wait for Rafael to separate the device hibernate
> (quiesce and state save) from device suspend.

Well, I'm afraid that will take some time ...

> Without that, the ACPI issue can not be resolved.

Yes, it seems so.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
