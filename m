Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgQRm-0007Hx-OX
 for kexec@lists.infradead.org; Wed, 03 Jun 2020 10:16:36 +0000
Date: Wed, 3 Jun 2020 12:16:28 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 1/3] crash: add VMCOREINFO macro for anonymous structs
Message-ID: <20200603101627.GE14855@linux-b0ei>
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200501094010.17694-2-john.ogness@linutronix.de>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri 2020-05-01 11:46:08, John Ogness wrote:
> Some structs are not named and are only available via their typedef.
> Add a VMCOREINFO macro to export field offsets for such structs.

Honestly, I did not get the meaning until I looked at the sample
usage added by the 2nd patch.

The term "anonymous structures" has another meaning in C++. It is
used for structures without any name that are defined inside a named
structure.

Something like this might be better:

"crash: Add VMCOREINFO macro to define offset in a struct declared by typedef

 The existing macro VMCOREINFO_OFFSET() can't be used for structures
 declared via typedef because "struct" is not part of type definition.

 Create another macro for this purpose."


Anyway, thanks a lot for the prototype of crash implementation.
I am happy that it is possible.

Best Regards,
Petr

PS: It might take few more days until I send some feedback for the
other patches. They are a bit more complex ;-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
