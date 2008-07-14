Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIKj4-0002MI-EO
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 09:52:10 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com>
	<86802c440807140011v728cc35fy2540b537ddca9844@mail.gmail.com>
	<20080714112404.36783df5@halley.suse.de>
Date: Mon, 14 Jul 2008 02:44:37 -0700
In-Reply-To: <20080714112404.36783df5@halley.suse.de> (Bernhard Walle's
	message of "Mon, 14 Jul 2008 11:24:04 +0200")
Message-ID: <m1od50ztoa.fsf@frodo.ebiederm.org>
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
Cc: x86@kernel.org, kexec@lists.infradead.org, Yinghai Lu <yhlu.kernel@gmail.com>, Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org

Bernhard Walle <bwalle@suse.de> writes:

> * Yinghai Lu [2008-07-14 00:11]:
>>
>> should use min_t(u64, 1ULL<<32, max_low_pfn<<PAGE_SHIFT) replace ULONG_MAX
>
> Shouldn't we use  min_t(u64, ULLONG_MAX, max_low_pfn<<PAGE_SHIFT), i.e.
> should we really limit the crashkernel to a 32 bit address on a 64 bit
> system?

We should use the lowest physical address that meets our size and
alignment constraints.  However there is no reason to make this be <
4G or even < 1G.  The worst case is that we reserve an area the kdump
kernel can't run out of.  However /sbin/kexec should check for that as
the kexec on panic code is not necessarily a linux kernel.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
