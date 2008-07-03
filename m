Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KEOeW-0007dv-MS
	for kexec@lists.infradead.org; Thu, 03 Jul 2008 13:15:13 +0000
Date: Thu, 3 Jul 2008 15:14:56 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
Message-ID: <20080703131456.GA12102@elte.hu>
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com>
	<20080627134212.GC5801@redhat.com>
	<20080627160656.06f71661@halley.suse.de>
	<20080627141910.GD5801@redhat.com>
	<20080627162223.2df5a8b9@halley.suse.de>
	<m1zlp6vjub.fsf@frodo.ebiederm.org>
	<20080627202932.16634031@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080627202932.16634031@kopernikus.site>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org


* Bernhard Walle <bwalle@suse.de> wrote:

> > > But in general policy should go in userspace (if possible), so I 
> > > agree with you that kexec-tools can handle that.
> > 
> > At a quick skim the patch looks good.  I thought I had initially 
> > implemented the code to work this way but apparently in all of the 
> > churn that aspect of it got lost.
> > 
> > Let's start with trying to allocate the memory as low as possible 
> > for a crash kernel (I think you are already doing that).
> 
> Yes, in 95 % of the cases the crashkernel still gets reserved at 16M.

ok - i've applied it to tip/x86/crashdump - thanks Bernhard.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
