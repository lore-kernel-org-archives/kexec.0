Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQXOp-0003dw-1m
 for kexec@lists.infradead.org; Fri, 01 Nov 2019 13:55:37 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [Crash-utility] crash and makedumpfile with 5.3 missing memory
 in dump
Date: Fri, 1 Nov 2019 13:54:30 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03594495@BPXM09GP.gisp.nec.co.jp>
References: <20191101014837.lxmqee5jyic7lk4d@two.firstfloor.org>
 <1684529127.9771679.1572612525461.JavaMail.zimbra@redhat.com>
 <1593ae18-e75d-0023-5895-04e3bcdb1950@Oracle.com>
In-Reply-To: <1593ae18-e75d-0023-5895-04e3bcdb1950@Oracle.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: "andi@firstfloor.org" <andi@firstfloor.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

Hi,

> -----Original Message-----
> >> I'm trying to use crash to read a makedumpfile vmcore from 5.3, but I always
> >> end up with an error when opening the dump.

As John mentioned, makedumpfile needs the following patch to work with
5.3 or later correctly.  This patch is in the devel branch now.
Please try the latest one.
https://sourceforge.net/p/makedumpfile/code/ci/7bdb468c2c99dd780c9a5321f93c79cbfdce2527/

Although the commit message says that it causes makedumpfile an error,
I saw some patterns later that makedumpfile created a broken dumpfile
without error.

(Usually I had to wrote "Required for kernel 5.3" in the commit message,
but forgot it at that time..)

Thanks,
Kazu

> >>
> >> I'm using the latest github crash
> >>
> >> crash 7.2.7++
> >> ...
> >>   crash: page excluded: kernel virtual address: ffffffff82110370  type:
> >>   "possible"
> >>   WARNING: cannot read cpu_possible_map
> >>   crash: page excluded: kernel virtual address: ffffffff82110360  type:
> >>   "present"
> >>   WARNING: cannot read cpu_present_map
> >>   crash: page excluded: kernel virtual address: ffffffff82110368  type:
> >>   "online"
> >>   WARNING: cannot read cpu_online_map
> >>   crash: page excluded: kernel virtual address: ffffffff82110358  type:
> >>   "active"
> >>   WARNING: cannot read cpu_active_map
> >>   crash: page excluded: kernel virtual address: ffffffff82011544  type:
> >>   "init_uts_ns"
> >>   crash: page excluded: kernel virtual address: ffffffff82110360  type:
> >>   "cpu_present_map"
> >>   crash: page excluded: kernel virtual address: ffffffff82110360  type:
> >>   "cpu_present_map"
> >>   WARNING: ORC unwinder: cannot read lookup_num_blocks
> >>   crash: seek error: kernel virtual address: ffff88822dffb000  type:
> >>   "memory section root table"
> >>
> >> The dump is created with the latest makedumpfile release
> >>
> >> makedumpfile: version 1.6.6 (released on 27 Jun 2019)
> >>
> >> It complains that it doesn't support the kernel
> >>
> >> Any ideas?
> >>
> >> -Andi
> >>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
