Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KCIGF-0001tb-NY
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 18:01:27 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com> <20080627134212.GC5801@redhat.com>
	<20080627160656.06f71661@halley.suse.de>
	<20080627141910.GD5801@redhat.com>
	<20080627162223.2df5a8b9@halley.suse.de>
Date: Fri, 27 Jun 2008 11:00:44 -0700
In-Reply-To: <20080627162223.2df5a8b9@halley.suse.de> (Bernhard Walle's
	message of "Fri, 27 Jun 2008 16:22:23 +0200")
Message-ID: <m1zlp6vjub.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
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
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>


Bernhard Walle <bwalle@suse.de> writes:

> Ah, that's true. Only on x86, right? (That would be an alternative for
> ia64, too ...)
>
> But in general policy should go in userspace (if possible), so I agree
> with you that kexec-tools can handle that.

At a quick skim the patch looks good.  I thought I had initially implemented
the code to work this way but apparently in all of the churn that aspect of it
got lost.

Let's start with trying to allocate the memory as low as possible for
a crash kernel (I think you are already doing that).

If we need something more we can add another meta character to specify a limit.
/sbin/kexec should balk at loading if the reserved region is too high.

Ramdisks in particular are a problem because they need to be in low mem.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
