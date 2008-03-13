Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZbRz-0002OR-KH
	for kexec@lists.infradead.org; Thu, 13 Mar 2008 00:37:40 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
	<200803122253.07631.rjw@sisk.pl>
Date: Wed, 12 Mar 2008 18:33:21 -0600
In-Reply-To: <200803122253.07631.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 12 Mar 2008 22:53:06 +0100")
Message-ID: <m1iqzrxy26.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Yes, it ought to be possible.
>
> Ultimately, IMHO, we should put all devices unnecessary for saving the image
> (and doing some eye-candy work) into low power states before the image is
> created and keep them in low power states until the system is eventually
> powered off.

Why?  I guess I don't see why we care what power state the devices are in.
Especially since we should be able to quickly save the image.

We need to disconnect the drivers from the hardware yes.  So filesystems
still work and applications that do direct hardware access still work
and don't need to reopen their connections.

I'm leery of low power states as they don't always work, and bringing
low power states seems to confuse hibernation to disk with suspend to
ram.

> If this is done, the remaining problem is the handling of the devices that we
> need to save the image.  I believe that will be achievable without using the
> freezer.

Reasonable.  In general the problem is much easier if we don't store
the hibernation image in a filesystem or partition that the rest of
the system is using.  That way we avoid inconsistencies.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
