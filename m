Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTuKW-00039l-8y
 for kexec@lists.infradead.org; Wed, 29 Apr 2020 21:33:21 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH 0/1] support lockless printk ringbuffer
Date: Wed, 29 Apr 2020 23:32:55 +0200
Message-Id: <20200429213256.3691-1-john.ogness@linutronix.de>
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, crash-utility@redhat.com

Hi Kazu,

Here is a patch adding full support for the new lockless printk
ringbuffer as it is currently being proposed. Note that the latest
version has not yet been submitted to LKML. I was waiting until I
finished tests with crash(8) and makedumpfile(8).

The new ringbuffer will export all the necessary symbols, sizes,
and offsets in VMCOREINFO.

Note that I created a separate printk.c for the iteration logic.

Also note that I modified dwarf_info.c to support resolving
typedefs of typedefs. This was necessary in order to support
atomic_long_t and its "counter" member.

I don't expect you to take the patch as-is, but I hope it can
provide some positive ground work for moving forward.

John Ogness (1):
  printk: add support for lockless ringbuffer

 Makefile       |   2 +-
 dwarf_info.c   |  36 +++++++++-
 makedumpfile.c | 101 ++++++++++++++++++++++++++--
 makedumpfile.h |  25 +++++++
 printk.c       | 177 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 333 insertions(+), 8 deletions(-)
 create mode 100644 printk.c

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
