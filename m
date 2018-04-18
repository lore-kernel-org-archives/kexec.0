Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8ogZ-0004Y8-Ck
 for kexec@lists.infradead.org; Wed, 18 Apr 2018 15:07:56 +0000
Date: Wed, 18 Apr 2018 20:37:07 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: Re: [PATCH net-next v4 0/3] kernel: add support to collect hardware
 logs in crash recovery kernel
Message-ID: <20180418150707.GA27638@chelsio.com>
References: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
 <20180418061546.GA4551@dhcp-128-65.nay.redhat.com>
 <20180418123114.GA19159@chelsio.com> <871sfcy4ge.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871sfcy4ge.fsf@xmission.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Indranil Choudhury <indranil@chelsio.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nirranjan Kirubaharan <nirranjan@chelsio.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Ganesh GR <ganeshgr@chelsio.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>

On Wednesday, April 04/18/18, 2018 at 19:58:01 +0530, Eric W. Biederman wrote:
> Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
> 
> > On Wednesday, April 04/18/18, 2018 at 11:45:46 +0530, Dave Young wrote:
> >> Hi Rahul,
> >> On 04/17/18 at 01:14pm, Rahul Lakkireddy wrote:
> >> > On production servers running variety of workloads over time, kernel
> >> > panic can happen sporadically after days or even months. It is
> >> > important to collect as much debug logs as possible to root cause
> >> > and fix the problem, that may not be easy to reproduce. Snapshot of
> >> > underlying hardware/firmware state (like register dump, firmware
> >> > logs, adapter memory, etc.), at the time of kernel panic will be very
> >> > helpful while debugging the culprit device driver.
> >> > 
> >> > This series of patches add new generic framework that enable device
> >> > drivers to collect device specific snapshot of the hardware/firmware
> >> > state of the underlying device in the crash recovery kernel. In crash
> >> > recovery kernel, the collected logs are added as elf notes to
> >> > /proc/vmcore, which is copied by user space scripts for post-analysis.
> >> > 
> >> > The sequence of actions done by device drivers to append their device
> >> > specific hardware/firmware logs to /proc/vmcore are as follows:
> >> > 
> >> > 1. During probe (before hardware is initialized), device drivers
> >> > register to the vmcore module (via vmcore_add_device_dump()), with
> >> > callback function, along with buffer size and log name needed for
> >> > firmware/hardware log collection.
> >> 
> >> I assumed the elf notes info should be prepared while kexec_[file_]load
> >> phase. But I did not read the old comment, not sure if it has been discussed
> >> or not.
> >> 
> >
> > We must not collect dumps in crashing kernel. Adding more things in
> > crash dump path risks not collecting vmcore at all. Eric had
> > discussed this in more detail at:
> >
> > https://lkml.org/lkml/2018/3/24/319
> >
> > We are safe to collect dumps in the second kernel. Each device dump
> > will be exported as an elf note in /proc/vmcore.
> 
> It just occurred to me there is one variation that is worth
> considering.
> 
> Is the area you are looking at dumping part of a huge mmio area?
> I think someone said 2GB?
> 
> If that is the case it could be worth it to simply add the needed
> addresses to the range of memory we need to dump, and simply having a
> elf note saying that is what happened.
> 

We are _not_ dumping mmio area. However, one part of the dump
collection involves reading 2 GB on-chip memory via PIO access,
which is compressed and stored.

Thanks,
Rahul

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
