Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0SSS-0001Un-Fn
 for kexec@lists.infradead.org; Mon, 26 Mar 2018 13:46:46 +0000
Date: Mon, 26 Mar 2018 19:15:40 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: Re: [PATCH net-next v2 0/2] kernel: add support to collect hardware
 logs in crash recovery kernel
Message-ID: <20180326134539.GA15852@chelsio.com>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <87muyxlctn.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87muyxlctn.fsf@xmission.com>
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
Cc: Indranil Choudhury <indranil@chelsio.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nirranjan Kirubaharan <nirranjan@chelsio.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, Ganesh GR <ganeshgr@chelsio.com>

On Saturday, March 03/24/18, 2018 at 20:50:52 +0530, Eric W. Biederman wrote:
> 
> Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
> 
> > On production servers running variety of workloads over time, kernel
> > panic can happen sporadically after days or even months. It is
> > important to collect as much debug logs as possible to root cause
> > and fix the problem, that may not be easy to reproduce. Snapshot of
> > underlying hardware/firmware state (like register dump, firmware
> > logs, adapter memory, etc.), at the time of kernel panic will be very
> > helpful while debugging the culprit device driver.
> >
> > This series of patches add new generic framework that enable device
> > drivers to collect device specific snapshot of the hardware/firmware
> > state of the underlying device in the crash recovery kernel. In crash
> > recovery kernel, the collected logs are exposed via /sys/kernel/crashdd/
> > directory, which is copied by user space scripts for post-analysis.
> >
> > A kernel module crashdd is newly added. In crash recovery kernel,
> > crashdd exposes /sys/kernel/crashdd/ directory containing device
> > specific hardware/firmware logs.
> 
> Have you looked at instead of adding a sysfs file adding the dumps
> as additional elf notes in /proc/vmcore?
> 

I see the crash recovery kernel's memory is not present in any of the
the PT_LOAD headers.  So, makedumpfile is not collecting the dumps
that are in crash recovery kernel's memory.

Also, are you suggesting exporting the dumps themselves as PT_NOTE
instead?  I'll look into doing it this way.

> That should allow existing tools to capture your extended dump
> information with no code changes, and it will allow having a single file
> core dump for storing the information.
> 
> Both of which should mean something that will integrate better into
> existing flows.
> 
> The interface logic of the driver should be essentially the same.
> 
> 
> Also have you tested this and seen how well your current logic captures
> the device information?
> 

Yes, the hardware snapshot is pretty close to the state during kernel
panic.  It is better than risking not being able to collect anything
at all during kernel panic.

Thanks,
Rahul

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
