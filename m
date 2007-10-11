Return-path: <kexec-bounces@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ifusz-00051U-0Z
	for kexec@lists.infradead.org; Thu, 11 Oct 2007 11:03:24 +0100
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2 -mm] kexec based hibernation -v5
Date: Thu, 11 Oct 2007 12:17:57 +0200
References: <1192068833.27482.13.camel@caritas-dev.intel.com>
In-Reply-To: <1192068833.27482.13.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200710111217.58473.rjw@sisk.pl>
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
Errors-To: kexec-bounces@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Thursday, 11 October 2007 04:13, Huang, Ying wrote:
> Kexec base hibernation has some potential advantages over uswsusp and
> TuxOnIce (suspend2). Some most obvious advantages are:

Well, I have some doubts as far as the obviousness is concerned.

> 1. The hibernation image size can exceed half of memory size easily.

This is also possible with TuxOnIce.

> 2. The hibernation image can be written to and read from almost
>    anywhere, such as USB disk, NFS.

This is possible with uswsusp, at least in theory, probably with TuxOnIce too.

> 3. It is possible to eliminate freezer from kexec based hibernation
>    implementation.

This isn't true as long as we have not changed the handling of devices
(which is in the works, but will take time).

> 4. Based on kexec/kdump implementation, the kernel code needed is
>    less.

Well, maybe.

Greetings,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
