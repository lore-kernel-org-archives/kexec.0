Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KCIhU-0008Ts-PM
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 18:29:37 +0000
Date: Fri, 27 Jun 2008 20:29:32 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
Message-ID: <20080627202932.16634031@kopernikus.site>
In-Reply-To: <m1zlp6vjub.fsf@frodo.ebiederm.org>
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com>
	<20080627134212.GC5801@redhat.com>
	<20080627160656.06f71661@halley.suse.de>
	<20080627141910.GD5801@redhat.com>
	<20080627162223.2df5a8b9@halley.suse.de>
	<m1zlp6vjub.fsf@frodo.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

* ebiederm@xmission.com (Eric W. Biederman) [2008-06-27 11:00]:
> Bernhard Walle <bwalle@suse.de> writes:
> 
> > Ah, that's true. Only on x86, right? (That would be an alternative for
> > ia64, too ...)
> >
> > But in general policy should go in userspace (if possible), so I agree
> > with you that kexec-tools can handle that.
> 
> At a quick skim the patch looks good.  I thought I had initially implemented
> the code to work this way but apparently in all of the churn that aspect of it
> got lost.
> 
> Let's start with trying to allocate the memory as low as possible for
> a crash kernel (I think you are already doing that).

Yes, in 95 % of the cases the crashkernel still gets reserved at 16M.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
