Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtRzl-0002Re-4T
 for kexec@lists.infradead.org; Thu, 09 Jul 2020 08:33:29 +0000
Received: by mail-pj1-x1035.google.com with SMTP id t15so783401pjq.5
 for <kexec@lists.infradead.org>; Thu, 09 Jul 2020 01:33:27 -0700 (PDT)
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Thu, 9 Jul 2020 17:33:23 +0900
Subject: Re: [printk] 18a2dc6982: ltp.kmsg01.fail
Message-ID: <20200709083323.GA572@jagdpanzerIV.localdomain>
References: <20200707145932.8752-5-john.ogness@linutronix.de>
 <20200709071411.GR3874@shao2-debian>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709071411.GR3874@shao2-debian>
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
To: kernel test robot <rong.a.chen@intel.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Paul McKenney <paulmck@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, lkp@lists.01.org, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On (20/07/09 15:14), kernel test robot wrote:
[..]

Took me a while to find the FAIL-ed test:

> kmsg01.c:393: INFO: TEST: read returns EPIPE when messages get overwritten
> kmsg01.c:398: INFO: first seqno: 0
> kmsg01.c:411: INFO: first seqno now: 881
> kmsg01.c:425: FAIL: read returned: 77: SUCCESS (0)

So this is seq number related
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/logging/kmsg/kmsg01.c#L383

LTP writes a gazillion (roughly, maybe a bit less than that)
filler messages to /dev/kmsg in order to cause logbuf overlap:
...
19490 [  172.301584] LTP kmsg01 FILLER MESSAGE TO OVERWRITE OTHERS
19491 [  172.308730] LTP kmsg01 FILLER MESSAGE TO OVERWRITE OTHERS
19492 [  172.313852] LTP kmsg01 FILLER MESSAGE TO OVERWRITE OTHERS
19493 [  172.320988] LTP kmsg01 FILLER MESSAGE TO OVERWRITE OTHERS
19494 [  172.325618] LTP kmsg01 FILLER MESSAGE TO OVERWRITE OTHERS
...

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
