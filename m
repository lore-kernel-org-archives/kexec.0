Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SthSc-0000Gk-TT
 for kexec@lists.infradead.org; Tue, 24 Jul 2012 15:55:52 +0000
Message-ID: <1343145331.16290.45.camel@cr0>
Subject: Re: [PATCH] x86: revert "x86: Fix S4 regression"
From: Cong Wang <amwang@redhat.com>
Date: Tue, 24 Jul 2012 23:55:31 +0800
In-Reply-To: <500D340F.5080801@jp.fujitsu.com>
References: <1339478463-31172-1-git-send-email-amwang@redhat.com>
 <5004D8BF.6050205@jp.fujitsu.com> <500D20A1.1030800@redhat.com>
 <500D340F.5080801@jp.fujitsu.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: yinghai.lu@oracle.com, tiwai@suse.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, hpa@zytor.com, xiyou.wangcong@gmail.com, akpm@linux-foundation.org, dyoung@redhat.com

On Mon, 2012-07-23 at 20:22 +0900, Takao Indoh wrote:
> (2012/07/23 19:00), Dave Young wrote:
> > On 07/17/2012 11:15 AM, Takao Indoh wrote:
> > 
> >> Hi Cong,
> >>
> >> When I tested kdump with 3.5.0-rc6 kernel, I found a problem of kdump
> >> kernel's panic in find_early_table_space().
> >>
> >> init_memory_mapping: [mem 0x00000000-0x36ffafff]
> >> Kernel panic - not syncing: Cannot find space for the kernel page tables
> >> Pid: 0, comm: swapper Not tainted 3.5.0-rc6 #17
> >> Call Trace:
> >>   [<ffffffff8158549b>] panic+0xb8/0x1c8
> >>   [<ffffffff8158565d>] ? printk+0x48/0x4a
> >>   [<ffffffff8157304c>] init_memory_mapping+0x46c/0x530
> >>   [<ffffffff818a73c7>] setup_arch+0x669/0xb0e
> >>   [<ffffffff8158565d>] ? printk+0x48/0x4a
> >>   [<ffffffff818a3a1f>] start_kernel+0x9b/0x34a
> >>   [<ffffffff818a332d>] x86_64_start_reservations+0x131/0x136
> >>   [<ffffffff818a341f>] x86_64_start_kernel+0xed/0xf4
> >>
> >> In find_early_table_space(), a kernel tries to find free area below 512M
> >> for pgtable using memblock_find_in_range, but it fails because kdump
> >> kernel does not have enough free space below 512M due to the memmap
> >> restriction. This is the memmap option specified against kdump kernel
> >> when crashkernel=128M.
> >>
> >> memmap=560K@64K memmap=130492K@770608K
> >>
> >> Only 560KB area is available and it is not sufficient for pgtable (it
> >> seems that about 1.8MB area is needed for pgtable). This problem is
> >> fixed by your revert patch. I hope this patch gets merged.
> > 
> > 
> > I can reproduce this issue as well, probably related to some x86 mm init
> > commits, this alloc failure does not happen with reverting below commits:
> > 
> > bd2753b2dda7bb43c7468826de75f49c6a7e8965
> > 722bc6b16771ed80871e1fd81c86d3627dda2ac8
> Yeah, my result of bisect is as follows and at first I thought the
> commit 722bc6 caused this regression.
> 
> 722bc6b16771ed80871e1fd81c86d3627dda2ac8 is the first bad commit
> commit 722bc6b16771ed80871e1fd81c86d3627dda2ac8
> Author: WANG Cong <xiyou.wangcong@gmail.com>
> Date:   Mon Mar 5 15:05:13 2012 -0800
> 
> IIUC, this commit just fixes a bug of counting pgtable entries. As the
> result, another problem came up to the surface. In the case of my
> machine(16GB memory), before applying 722bc6, find_early_table_space()
> requests about 12KB free area and it can be got from 560K@64K area
> luckily. I think the size find_early_table_space() requests was a bug.
> After the bug is fixed by the commit 722bc6, find_early_table_space()
> requires 1.8MB area and it fails as I wrote.

Thanks for tracking this, Takao!

I bet you are using x86_64 not x86 PAE? If so, could you try this patch
https://patchwork.kernel.org/patch/1195751/
? I already reviewed it.

Sorry for the trouble!



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
