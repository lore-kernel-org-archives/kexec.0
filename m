Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f9Axu-0004GC-0R
 for kexec@lists.infradead.org; Thu, 19 Apr 2018 14:55:44 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
 <20180418061546.GA4551@dhcp-128-65.nay.redhat.com>
 <20180418123114.GA19159@chelsio.com>
 <20180419014030.GA2340@dhcp-128-65.nay.redhat.com>
 <20180419142747.GA30274@chelsio.com>
Date: Thu, 19 Apr 2018 09:53:37 -0500
In-Reply-To: <20180419142747.GA30274@chelsio.com> (Rahul Lakkireddy's message
 of "Thu, 19 Apr 2018 19:57:48 +0530")
Message-ID: <87lgdjnt72.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 0/3] kernel: add support to collect hardware
 logs in crash recovery kernel
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
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: Indranil Choudhury <indranil@chelsio.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nirranjan Kirubaharan <nirranjan@chelsio.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Ganesh GR <ganeshgr@chelsio.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> On Thursday, April 04/19/18, 2018 at 07:10:30 +0530, Dave Young wrote:
>> On 04/18/18 at 06:01pm, Rahul Lakkireddy wrote:
>> > On Wednesday, April 04/18/18, 2018 at 11:45:46 +0530, Dave Young wrote:
>> > > Hi Rahul,
>> > > On 04/17/18 at 01:14pm, Rahul Lakkireddy wrote:
>> > > > On production servers running variety of workloads over time, kernel
>> > > > panic can happen sporadically after days or even months. It is
>> > > > important to collect as much debug logs as possible to root cause
>> > > > and fix the problem, that may not be easy to reproduce. Snapshot of
>> > > > underlying hardware/firmware state (like register dump, firmware
>> > > > logs, adapter memory, etc.), at the time of kernel panic will be very
>> > > > helpful while debugging the culprit device driver.
>> > > > 
>> > > > This series of patches add new generic framework that enable device
>> > > > drivers to collect device specific snapshot of the hardware/firmware
>> > > > state of the underlying device in the crash recovery kernel. In crash
>> > > > recovery kernel, the collected logs are added as elf notes to
>> > > > /proc/vmcore, which is copied by user space scripts for post-analysis.
>> > > > 
>> > > > The sequence of actions done by device drivers to append their device
>> > > > specific hardware/firmware logs to /proc/vmcore are as follows:
>> > > > 
>> > > > 1. During probe (before hardware is initialized), device drivers
>> > > > register to the vmcore module (via vmcore_add_device_dump()), with
>> > > > callback function, along with buffer size and log name needed for
>> > > > firmware/hardware log collection.
>> > > 
>> > > I assumed the elf notes info should be prepared while kexec_[file_]load
>> > > phase. But I did not read the old comment, not sure if it has been discussed
>> > > or not.
>> > > 
>> > 
>> > We must not collect dumps in crashing kernel. Adding more things in
>> > crash dump path risks not collecting vmcore at all. Eric had
>> > discussed this in more detail at:
>> > 
>> > https://lkml.org/lkml/2018/3/24/319
>> > 
>> > We are safe to collect dumps in the second kernel. Each device dump
>> > will be exported as an elf note in /proc/vmcore.
>> 
>> I understand that we should avoid adding anything in crash path.  And I also
>> agree to collect device dump in second kernel.  I just assumed device
>> dump use some memory area to store the debug info and the memory
>> is persistent so that this can be done in 2 steps, first register the
>> address in elf header in kexec_load, then collect the dump in 2nd
>> kernel.  But it seems the driver is doing some other logic to collect
>> the info instead of just that simple like I thought. 
>> 
>
> It seems simpler, but I'm concerned with waste of memory area, if
> there are no device dumps being collected in second kernel. In
> approach proposed in these series, we dynamically allocate memory
> for the device dumps from second kernel's available memory.

Don't count that kernel having more than about 128MiB.

For that reason if for no other it would be nice if it was possible to
have the driver to not initialize the device and just stand there
handing out the data a piece at a time as it is read from /proc/vmcore.

The 2GiB number I read earlier concerns me for working in a limited
environment.

It might even make sense to separate this into a completely separate
module (depended upon the main driver if it makes sense to share
the functionality) so that people performing crash dumps would not
hesitate to include the code in their initramfs images.

I can see splitting a device up into a portion only to be used in case
of a crash dump and a normal portion like we do for main memory but I
doubt that makes sense in practice.

>> > > If do this in 2nd kernel a question is driver can be loaded later than vmcore init.
>> > 
>> > Yes, drivers will add their device dumps after vmcore init.
>> > 
>> > > How to guarantee the function works if vmcore reading happens before
>> > > the driver is loaded?
>> > > 
>> > > Also it is possible that kdump initramfs does not contains the driver
>> > > module.
>> > > 
>> > > Am I missing something?
>> > > 
>> > 
>> > Yes, driver must be in initramfs if it wants to collect and add device
>> > dump to /proc/vmcore in second kernel.
>> 
>> In RH/Fedora kdump scripts we only add the things are required to
>> bring up the dump target, so that we can use as less memory as we can.
>> 
>> For example, if a net driver panicked, and the dump target is rootfs
>> which is a scsi disk, then no network related stuff will be added in
>> initramfs.
>> 
>> In this case the device dump info will be not collected..
>
> Correct. If the driver is not present in initramfs, it can't collect
> its underlying device's dump. Administrator is expected to add the 
> driver to initramfs, if device dump needs to be collected.

That makes sense, as most people won't have that need.  Still if we can
find something that can work automatically and safely without the need
for manual configuration people are more likely to use it.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
