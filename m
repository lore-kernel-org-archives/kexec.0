Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IYhG2-0000Xw-HL
	for kexec@lists.infradead.org; Fri, 21 Sep 2007 08:05:22 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
Date: Fri, 21 Sep 2007 14:18:19 +0200
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211356.30291.rjw@sisk.pl>
	<200709212158.50538.nigel@nigel.suspend2.net>
In-Reply-To: <200709212158.50538.nigel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200709211418.20358.rjw@sisk.pl>
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
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Friday, 21 September 2007 13:58, Nigel Cunningham wrote:
> Hi.
> 
> On Friday 21 September 2007 21:56:29 Rafael J. Wysocki wrote:
> > [Besides, the current hibernation userland interface is used by default by
> > openSUSE and it's also used by quite some Debian users, so we can't drop
> > it overnight and it can't be implemented in a compatible way on top of the
> > kexec-based solution.]
> 
> Could it be fudged by giving userland a null image and having (say) the first 
> ioctl be one that triggers all the real work (with other ioctls being noops 
> or such like, as appropriate)?

Well, the "suspend" part is probably doable, but I'm afraid of the "resume"
one.

Greetings,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
