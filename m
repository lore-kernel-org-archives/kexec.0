Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1erkfW-00047P-Kb
 for kexec@lists.infradead.org; Fri, 02 Mar 2018 13:24:19 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
Date: Fri, 02 Mar 2018 07:22:45 -0600
In-Reply-To: <cover.1519911559.git.rahul.lakkireddy@chelsio.com> (Rahul
 Lakkireddy's message of "Fri, 2 Mar 2018 17:49:56 +0530")
Message-ID: <87lgfad32y.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [RFC 0/2] kernel: add support to collect hardware logs in panic
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
Cc: indranil@chelsio.com, netdev@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ganeshgr@chelsio.com, nirranjan@chelsio.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> On production servers running variety of workloads over time, kernel
> panic can happen sporadically after days or even months. It is
> important to collect as much debug logs as possible to root cause
> and fix the problem, that may not be easy to reproduce. Snapshot of
> underlying hardware/firmware state (like register dump, firmware
> logs, adapter memory, etc.), at the time of kernel panic will be very
> helpful while debugging the culprit device driver.
>
> This series of patches add new generic framework that enable device
> drivers to collect device specific snapshot of the hardware/firmware
> state of the underlying device at the time of kernel panic. The
> collected logs are appended to vmcore along with details, such as
> start address and length of the logs, which are required for
> extraction during post-analysis.
>
> Device drivers can use crash_driver_dump_register() to register their
> callback that collects underlying device specific hardware/firmware
> logs during kernel panic (i.e. before booting into the second kernel).
> Drivers can unregister with crash_driver_dump_unregister().
>
> To extract the device specific hardware/firmware logs using crash:
>
> crash> help -D | grep DRIVERDUMP
> DRIVERDUMP=(cxgb4_0000:02:00.4, ffffb131090bd000, 37782968)
>
> crash> rd ffffb131090bd000 37782968 -r hardware.log
> 37782968 bytes copied from 0xffffb131090bd000 to hardware.log
>
> Patch 1 adds API to allow drivers to register callback to
> collect the device specific hardware/firmware logs.
>
> Patch 2 shows a cxgb4 driver example using the API to collect
> hardware/firmware logs during kernel panic.
>
> Suggestions and feedback will be much appreciated.

I strongly suggest you figure out how to run this code in the
crash recovery kernel before your hardware is initialized.
That will give you a known good kernel to perform your collection from.

Every line of code we add to the kexec on panic code path tends to add
to it's fragility and increase the chance you won't get any information
at all.

When the assumption is it is something wrong with your driver/hardware
that caused the crash, calling into your driver is a very bad idea.
Especially running code that does callbacks and all kinds of other cute
things.

Doing this as the crash recover kernel boots up before much if any
hardware is initialized seems like a fine thing to do, and just
needs a little coordination with userspace to ensure the information
gets saved when a vmcore is computed.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
