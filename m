Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIT01-0005cQ-EL
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 18:42:13 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com>
	<86802c440807140011v728cc35fy2540b537ddca9844@mail.gmail.com>
	<20080714112404.36783df5@halley.suse.de>
	<m1od50ztoa.fsf@frodo.ebiederm.org>
	<86802c440807141006o98afac8t66b0933d8acd2746@mail.gmail.com>
	<m17iboz83v.fsf@frodo.ebiederm.org>
	<86802c440807141117q218fdd61w1216dc6ded72252a@mail.gmail.com>
Date: Mon, 14 Jul 2008 11:41:36 -0700
In-Reply-To: <86802c440807141117q218fdd61w1216dc6ded72252a@mail.gmail.com>
	(Yinghai Lu's message of "Mon, 14 Jul 2008 11:17:16 -0700")
Message-ID: <m1r69wxq8v.fsf@frodo.ebiederm.org>
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
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

"Yinghai Lu" <yhlu.kernel@gmail.com> writes:

> On Mon, Jul 14, 2008 at 10:30 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> "Yinghai Lu" <yhlu.kernel@gmail.com> writes:
>>
>>> for 64bit, kdump can start from address above 4g with bzImage?
>>
>> I think the boot protocol was properly updated for that, it was in the
>> original drafts.  A relocatable kernel with a 64bit entry point.
>>
>> I do know that the 64bit code is ready to do that.
>
> but bzImage for 64bit still use 32bit entries, except kexec could
> uncompress the bzImage like xen domain builder.

From the standpoint of the crashdump option it doesn't matter.
As the vmlinux supports it, and bzImage could easily support it,
the decompresser is 64bit code.

If bzImage doesn't support it that is a bug we will have to
correct one of these years when it actually matters.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
