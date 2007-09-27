Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [150.101.163.206] (helo=home.nigel.suspend2.net)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ian60-0004Ro-6s
	for kexec@lists.infradead.org; Thu, 27 Sep 2007 02:43:40 -0400
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
Date: Thu, 27 Sep 2007 16:35:10 +1000
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<20070926203036.GF31759@nineveh.local>
	<1190874834.21818.300.camel@caritas-dev.intel.com>
In-Reply-To: <1190874834.21818.300.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200709271635.13099.nigel@nigel.suspend2.net>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Joseph Fannin <jfannin@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi.

On Thursday 27 September 2007 16:33:54 Huang, Ying wrote:
> On Wed, 2007-09-26 at 16:30 -0400, Joseph Fannin wrote:
> >     But, in my ignorance, I'm not sure even fixing the ext3 bug will
> > guarantee you consistent metadata so that you can handle a
> > swap/hibernate file.  You can do a sync(), but how do you make that
> > not race against running processes without the freezer, or blkdev
> > snapshots?
> > 
> >     I guess uswsusp and the-patch-previously-known-as-suspend2 handle
> > this somehow, though.
> 
> The image-writing kernel of kexec based hibernation run in a controlled
> way. It is not used by normal user, so only really necessary process
> need to be run. For example, it is possible that there is only one user
> process -- the image-writing process running in image-writing kernel.
> So, no freezer or blkdev snapshot is needed.

You're thinking of the wrong kernel - we were talking about prior to switching 
to the kexec'd kernel while suspending.

Regards,

Nigel
-- 
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
