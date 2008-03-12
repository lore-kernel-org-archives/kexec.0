Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZYtg-0005X7-9E
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 21:54:04 +0000
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 22:53:06 +0100
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200803122253.07631.rjw@sisk.pl>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Wednesday, 12 of March 2008, Alan Stern wrote:
> On Wed, 12 Mar 2008, Huang, Ying wrote:
> 
> > I think "kexec based hibernation" is the only currently available
> > possible method to write out image without freezer (after driver works
> > are done). If other process is running, how to prevent them from writing
> > to disk without freezing them in current implementation?
> 
> This is a very good question.
> 
> It's a matter of managing the block layer's request queues.  Somehow 
> the existing I/O requests must remain blocked while the requests needed 
> for writing the image must be allowed to proceed.
> 
> I don't know what would be needed to make this work, but it ought to be 
> possible somehow...

Yes, it ought to be possible.

Ultimately, IMHO, we should put all devices unnecessary for saving the image
(and doing some eye-candy work) into low power states before the image is
created and keep them in low power states until the system is eventually
powered off.

If this is done, the remaining problem is the handling of the devices that we
need to save the image.  I believe that will be achievable without using the
freezer.

Thanks,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
