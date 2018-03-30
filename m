Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1yzx-0006Ad-48
 for kexec@lists.infradead.org; Fri, 30 Mar 2018 18:43:38 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
 <20180330103907.GC3313@nanopsycho>
 <20180330105156.GA24344@chelsio.com>
Date: Fri, 30 Mar 2018 13:42:00 -0500
In-Reply-To: <20180330105156.GA24344@chelsio.com> (Rahul Lakkireddy's message
 of "Fri, 30 Mar 2018 16:21:57 +0530")
Message-ID: <87k1tt2yo7.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
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
Cc: Jiri Pirko <jiri@resnulli.us>, Indranil Choudhury <indranil@chelsio.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nirranjan Kirubaharan <nirranjan@chelsio.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, Ganesh GR <ganeshgr@chelsio.com>

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> On Friday, March 03/30/18, 2018 at 16:09:07 +0530, Jiri Pirko wrote:
>> Sat, Mar 24, 2018 at 11:56:33AM CET, rahul.lakkireddy@chelsio.com wrote:
>> >Add a new module crashdd that exports the /sys/kernel/crashdd/
>> >directory in second kernel, containing collected hardware/firmware
>> >dumps.
>> >
>> >The sequence of actions done by device drivers to append their device
>> >specific hardware/firmware logs to /sys/kernel/crashdd/ directory are
>> >as follows:
>> >
>> >1. During probe (before hardware is initialized), device drivers
>> >register to the crashdd module (via crashdd_add_dump()), with
>> >callback function, along with buffer size and log name needed for
>> >firmware/hardware log collection.
>> >
>> >2. Crashdd creates a driver's directory under
>> >/sys/kernel/crashdd/<driver>. Then, it allocates the buffer with
>> 
>> This smells. I need to identify the exact ASIC instance that produced
>> the dump. To identify by driver name does not help me if I have multiple
>> instances of the same driver. This looks wrong to me. This looks like
>> a job for devlink where you have 1 devlink instance per 1 ASIC instance.
>> 
>> Please see:
>> http://patchwork.ozlabs.org/project/netdev/list/?series=36524
>> 
>> I bevieve that the solution in the patchset could be used for
>> your usecase too.
>> 
>> 
>
> The sysfs approach proposed here had been dropped in favour exporting
> the dumps as ELF notes in /proc/vmcore.
>
> Will be posting the new patches soon.

The concern was actually how you identify which device that came from.
Where you read the identifier changes but sysfs or /proc/vmcore the
change remains valid.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
