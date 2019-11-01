Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([193.170.194.197])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQM3S-00030W-Im
 for kexec@lists.infradead.org; Fri, 01 Nov 2019 01:48:48 +0000
Date: Thu, 31 Oct 2019 18:48:37 -0700
From: Andi Kleen <andi@firstfloor.org>
Subject: crash and makedumpfile with 5.3 missing memory in dump
Message-ID: <20191101014837.lxmqee5jyic7lk4d@two.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
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
To: crash-utility@redhat.com
Cc: k-hagio@ab.jp.nec.com, kexec@lists.infradead.org

Hi,

[I'm not sure if that is a crash or mkdumpfile problem]

I'm trying to use crash to read a makedumpfile vmcore from 5.3, but I always end up with an error when opening the dump. 

I'm using the latest github crash 

crash 7.2.7++
...
 crash: page excluded: kernel virtual address: ffffffff82110370  type:
 "possible"
 WARNING: cannot read cpu_possible_map
 crash: page excluded: kernel virtual address: ffffffff82110360  type:
 "present"
 WARNING: cannot read cpu_present_map
 crash: page excluded: kernel virtual address: ffffffff82110368  type:
 "online"
 WARNING: cannot read cpu_online_map
 crash: page excluded: kernel virtual address: ffffffff82110358  type:
 "active"
 WARNING: cannot read cpu_active_map
 crash: page excluded: kernel virtual address: ffffffff82011544  type:
 "init_uts_ns"
 crash: page excluded: kernel virtual address: ffffffff82110360  type:
 "cpu_present_map"
 crash: page excluded: kernel virtual address: ffffffff82110360  type:
 "cpu_present_map"
 WARNING: ORC unwinder: cannot read lookup_num_blocks
 crash: seek error: kernel virtual address: ffff88822dffb000  type:
 "memory section root table"

The dump is created with the latest makedumpfile release

makedumpfile: version 1.6.6 (released on 27 Jun 2019)

It complains that it doesn't support the kernel 

Any ideas? 

-Andi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
