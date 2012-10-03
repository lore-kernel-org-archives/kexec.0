Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TJJaO-0004Sg-FX
 for kexec@lists.infradead.org; Wed, 03 Oct 2012 07:41:42 +0000
Date: Wed, 3 Oct 2012 16:38:35 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
Message-Id: <20121003163835.c4be2b609deb385aab247beb@mxc.nes.nec.co.jp>
In-Reply-To: <20120924145157.GA14886@redhat.com>
References: <20120920200633.GL4681@redhat.com>
 <20120921.092357.94103398.d.hatayama@jp.fujitsu.com>
 <20120921133232.GC15909@redhat.com>
 <20120924.095112.153507503.d.hatayama@jp.fujitsu.com>
 <20120924145157.GA14886@redhat.com>
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
To: vgoyal@redhat.com, d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org, dyoung@redhat.com, chaowang@redhat.com

Hello,

> >> > Hi Atsushi san,
> >> > 
> >> > We tried makedumpfile 1.5.0 on a 1TB machine and it seems to regress
> >> > badly. We reserved 192MB of memory and following are test results.
> >> > 
> >> > #1. makedumpfile-1.4.2 -E --message-level 1 -d 31
> >> > real     3m47.520s
> >> > user     0m56.543s
> >> > sys	 2m41.631s
> >> > 
> >> > #2. makedumpfile-1.5.0 -E --message-level 1 -d 31
> >> > real     52m25.262s
> >> > user     32m51.310s
> >> > sys	 18m53.265s
> >> > 
> >> > #3. makedumpfile-1.4.2 -c --message-level 1 -d 31
> >> > real     8m49.107s
> >> > user     4m34.180s
> >> > sys	 4m8.691s
> >> > 
> >> > #4. makedumpfile-1.5.0 -c --message-level 1 -d 31
> >> > real     46m48.985s
> >> > user     29m35.203s
> >> > sys	 16m43.149s
> >> > 
> >> 
> >> Hello Vivek,
> >> 
> >> On v1.5.0 we cannot filter free pages in constant space becuase we
> >> have yet to test it. Instead, the existing method is used here, which
> >> repeats walking on a whole page frames the number of cycles times.
> >> 
> >> As Kumagai-san explains, the number of cycles can be calculated by the
> >> following expression:
> >> 
> >>   N = physical memory size / (page size * bit per byte(8) * BUFSIZE_CYCLIC)
> >> 
> >> So,
> >> 
> >>   N = 2TB / (4KB * 8 * 1MB) = 64 cycles.
> >> 
> >> I guess on this environment, it took about 50 seconds to filter free
> >> pages in one cycle.
> > 
> > Ok, so once we have your walking through page struct patches in, hopefully
> > this problem will be gone?
> Yes, then free page filtering is integrated in other mem_map array
> logics. You can see how it takes from the following message.
> 
> Excluding unnecessary pages        : [100 %] STEP [Excluding unnecessary pages] : 0.204574 seconds
> 
> New logic takes equal to or quicker than the total time indicated by
> the above kind of messages now.
> 
> > If that's going to take time, can we make using of new logic conditional
> > on a command line option. So that user has the option of using old
> > logic.
> > 
> 
> Kumagai-san should decide this. 

I'm not planning to make the cyclic mode optional.
However, I think the performance issue should be improved even without
mem_map array logic.

So, I will try to reduce the number of cycles as few times as possible for v1.5.1,
the performance issue will be improved.
To make sure of it, would you re-test with --cyclic-buffer 32768 (32MB), Vivek ?
Then the result of v1.5.0 is still too bad, I will consider using the old logic 
as default logic.


> BTW, Kumagai-san, in what version do you plan release of this new
> mem_map logic? Around v1.5.2? I want to re-send a new patch set to
> which I add small changes and comments for maintainability.

Yes, I plan to merge it in v1.5.2. 
Would you re-send the new patch set based on v1.5.1 ?

Additionally, I'm afraid that I haven't reviewed the most of patches
for v1.5.1 yet. So I can't tell you when v1.5.2 will be released.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
