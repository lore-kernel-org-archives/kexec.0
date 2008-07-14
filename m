Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from el-out-1112.google.com ([209.85.162.183])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIRVh-0001pI-5U
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 17:06:49 +0000
Received: by el-out-1112.google.com with SMTP id y26so1030255ele.18
	for <kexec@lists.infradead.org>; Mon, 14 Jul 2008 10:06:48 -0700 (PDT)
Message-ID: <86802c440807141006o98afac8t66b0933d8acd2746@mail.gmail.com>
Date: Mon, 14 Jul 2008 10:06:48 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
In-Reply-To: <m1od50ztoa.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com>
	<86802c440807140011v728cc35fy2540b537ddca9844@mail.gmail.com>
	<20080714112404.36783df5@halley.suse.de>
	<m1od50ztoa.fsf@frodo.ebiederm.org>
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
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

On Mon, Jul 14, 2008 at 2:44 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Bernhard Walle <bwalle@suse.de> writes:
>
>> * Yinghai Lu [2008-07-14 00:11]:
>>>
>>> should use min_t(u64, 1ULL<<32, max_low_pfn<<PAGE_SHIFT) replace ULONG_MAX
>>
>> Shouldn't we use  min_t(u64, ULLONG_MAX, max_low_pfn<<PAGE_SHIFT), i.e.
>> should we really limit the crashkernel to a 32 bit address on a 64 bit
>> system?
>
> We should use the lowest physical address that meets our size and
> alignment constraints.  However there is no reason to make this be <
> 4G or even < 1G.  The worst case is that we reserve an area the kdump
> kernel can't run out of.  However /sbin/kexec should check for that as
> the kexec on panic code is not necessarily a linux kernel.

for 64bit, kdump can start from address above 4g with bzImage?

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
