Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0oVL-000677-Q3
 for kexec@lists.infradead.org; Tue, 27 Mar 2018 13:19:13 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <87muyxlctn.fsf@xmission.com> <20180326134539.GA15852@chelsio.com>
Date: Tue, 27 Mar 2018 08:17:34 -0500
In-Reply-To: <20180326134539.GA15852@chelsio.com> (Rahul Lakkireddy's message
 of "Mon, 26 Mar 2018 19:15:40 +0530")
Message-ID: <87k1txfyj5.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 0/2] kernel: add support to collect hardware
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
Cc: Indranil Choudhury <indranil@chelsio.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nirranjan Kirubaharan <nirranjan@chelsio.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, Ganesh GR <ganeshgr@chelsio.com>

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> On Saturday, March 03/24/18, 2018 at 20:50:52 +0530, Eric W. Biederman wrote:
>> 
>> Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
>> 
>> > On production servers running variety of workloads over time, kernel
>> > panic can happen sporadically after days or even months. It is
>> > important to collect as much debug logs as possible to root cause
>> > and fix the problem, that may not be easy to reproduce. Snapshot of
>> > underlying hardware/firmware state (like register dump, firmware
>> > logs, adapter memory, etc.), at the time of kernel panic will be very
>> > helpful while debugging the culprit device driver.
>> >
>> > This series of patches add new generic framework that enable device
>> > drivers to collect device specific snapshot of the hardware/firmware
>> > state of the underlying device in the crash recovery kernel. In crash
>> > recovery kernel, the collected logs are exposed via /sys/kernel/crashdd/
>> > directory, which is copied by user space scripts for post-analysis.
>> >
>> > A kernel module crashdd is newly added. In crash recovery kernel,
>> > crashdd exposes /sys/kernel/crashdd/ directory containing device
>> > specific hardware/firmware logs.
>> 
>> Have you looked at instead of adding a sysfs file adding the dumps
>> as additional elf notes in /proc/vmcore?
>> 
>
> I see the crash recovery kernel's memory is not present in any of the
> the PT_LOAD headers.  So, makedumpfile is not collecting the dumps
> that are in crash recovery kernel's memory.
>
> Also, are you suggesting exporting the dumps themselves as PT_NOTE
> instead?  I'll look into doing it this way.

Yes.  I was suggesting exporting the dumps themselves as PT_NOTE
in /proc/vmcore.  I think that will allow makedumpfile to collect
your new information without modification.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
