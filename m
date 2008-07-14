Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KIT4n-0007ml-7T
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 18:47:09 +0000
Date: Mon, 14 Jul 2008 20:47:48 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
Message-ID: <20080714204748.07b06e30@halley.suse.de>
In-Reply-To: <m1r69wxq8v.fsf@frodo.ebiederm.org>
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com>
	<86802c440807140011v728cc35fy2540b537ddca9844@mail.gmail.com>
	<20080714112404.36783df5@halley.suse.de>
	<m1od50ztoa.fsf@frodo.ebiederm.org>
	<86802c440807141006o98afac8t66b0933d8acd2746@mail.gmail.com>
	<m17iboz83v.fsf@frodo.ebiederm.org>
	<86802c440807141117q218fdd61w1216dc6ded72252a@mail.gmail.com>
	<m1r69wxq8v.fsf@frodo.ebiederm.org>
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
Cc: x86@kernel.org, kexec@lists.infradead.org, Yinghai Lu <yhlu.kernel@gmail.com>, Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org

* Eric W. Biederman [2008-07-14 11:41]:
>
> "Yinghai Lu" <yhlu.kernel@gmail.com> writes:
> 
> > On Mon, Jul 14, 2008 at 10:30 AM, Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
> >> "Yinghai Lu" <yhlu.kernel@gmail.com> writes:
> >>
> >>> for 64bit, kdump can start from address above 4g with bzImage?
> >>
> >> I think the boot protocol was properly updated for that, it was in the
> >> original drafts.  A relocatable kernel with a 64bit entry point.
> >>
> >> I do know that the 64bit code is ready to do that.
> >
> > but bzImage for 64bit still use 32bit entries, except kexec could
> > uncompress the bzImage like xen domain builder.
> 
> From the standpoint of the crashdump option it doesn't matter.
> As the vmlinux supports it, and bzImage could easily support it,
> the decompresser is 64bit code.
> 
> If bzImage doesn't support it that is a bug we will have to
> correct one of these years when it actually matters.

But such checks belong into kexec itself, not into the kernel.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
