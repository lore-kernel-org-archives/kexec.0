Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icrVC-0004EI-Eg
 for kexec@lists.infradead.org; Thu, 05 Dec 2019 13:49:09 +0000
From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RFC PATCH v5 0/3] printk: new ringbuffer implementation
Date: Thu,  5 Dec 2019 08:46:52 -0500
Message-Id: <20191205134652.12631-1-prarit@redhat.com>
In-Reply-To: <20191128015235.12940-1-john.ogness@linutronix.de>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
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
To: linux-kernel@vger.kernel.org
Cc: andrea.parri@amarulasolutions.com, pmladek@suse.com, sergey.senozhatsky.work@gmail.com, john.ogness@linutronix.de, peterz@infradead.org, gregkh@linuxfoundation.org, brendanhiggins@google.com, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, tglx@linutronix.de, torvalds@linux-foundation.org, kexec@lists.infradead.org

  John Ogness <john.ogness@linutronix.de> wrote:
> Hello,
> 
> This is a follow-up RFC on the work to re-implement much of the
> core of printk. The threads for the previous RFC versions are
> here[0][1][2][3].
> 
> This RFC includes only the ringbuffer and a test module. This is
> a rewrite of the proposed ringbuffer, now based on the proof of
> concept[4] from Petr Mladek as agreed at the meeting[5] during
> LPC2019 in Lisbon.
> 
> The internal structure has been reworked such that the printk
> strings are in their own array, each separated by a 32-bit
> integer.
> 
> A 2nd array contains the dictionary strings (also with each
> separated by a 32-bit integer).
> 
> A 3rd array is made up of descriptors that contain all the
> meta-data for each printk record (sequence number, timestamp,
> loglevel, caller, etc.) as well as pointers into the other data
> arrays for the text and dictionary data.
> 
> The writer interface is somewhat similar to v4, but the reader
> interface has changed significantly. Rather than using an
> iterator object, readers just specify the sequence number they
> want to read. In effect, the sequence number acts as the
> iterator.
> 
> I have been communicating with Petr the last couple months to
> make sure this implementation fits his expectations. This RFC is
> mainly to get some feedback from anyone else that may see
> something that Petr and I have missed.
> 
> This series also includes my test module. On a 16-core ARM64
> test machine, the module runs without any errors. I am seeing
> the 15 writing cores each writing about 34500 records per
> second, while the 1 reading core misses only about 15% of the
> total records.
> 

John,

Based on the comments there is going to be a v6 but in any case I am
starting testing of this patchset on several large core systems across
multiple architectures (x86_64, ARM64, s390, ppc64le).  Some of those
systems are known to fail boot due to the large amount of printk output so
it will be good to see if these changes resolve those issues.

Sorry for the delay and I'll report back in a few days.

P.

> John Ogness
> 
> [0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutronix.de
> [1] https://lkml.kernel.org/r/20190607162349.18199-1-john.ogness@linutronix.de
> [2] https://lkml.kernel.org/r/20190727013333.11260-1-john.ogness@linutronix.de
> [3] https://lkml.kernel.org/r/20190807222634.1723-1-john.ogness@linutronix.de
> [4] https://lkml.kernel.org/r/20190704103321.10022-1-pmladek@suse.com
> [5] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
> 
> John Ogness (3):
>   printk-rb: new printk ringbuffer implementation (writer)
>   printk-rb: new printk ringbuffer implementation (reader)
>   printk-rb: add test module
> 
>  kernel/printk/Makefile            |   3 +
>  kernel/printk/printk_ringbuffer.c | 910 ++++++++++++++++++++++++++++++
>  kernel/printk/printk_ringbuffer.h | 249 ++++++++
>  kernel/printk/test_prb.c          | 347 ++++++++++++
>  4 files changed, 1509 insertions(+)
>  create mode 100644 kernel/printk/printk_ringbuffer.c
>  create mode 100644 kernel/printk/printk_ringbuffer.h
>  create mode 100644 kernel/printk/test_prb.c
> 
> -- 
> 2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
