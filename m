Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5tnk-0000zF-50
 for kexec@lists.infradead.org; Wed, 12 Aug 2020 16:40:33 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
In-Reply-To: <20200811204729.1116341-1-ndesaulniers@google.com>
References: <20200709132344.760-5-john.ogness@linutronix.de>
 <20200811204729.1116341-1-ndesaulniers@google.com>
Date: Wed, 12 Aug 2020 18:46:22 +0206
Message-ID: <871rkb4y2x.fsf@jogness.linutronix.de>
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
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: parri.andrea@gmail.com, pmladek@suse.com, sergey.senozhatsky.work@gmail.com, paulmck@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, swboyd@chromium.org, sergey.senozhatsky@gmail.com, tglx@linutronix.de, torvalds@linux-foundation.org

On 2020-08-11, Nick Desaulniers <ndesaulniers@google.com> wrote:
> From what I can tell, I think this patch ("printk: use the lockless
> ringbuffer") breaks lx-dmesg in CONFIG_GDB_SCRIPTS.
>
> (gdb) lx-dmesg
> Python Exception <class 'gdb.error'> No symbol "log_first_idx" in specified context.: 
> Error occurred in Python: No symbol "log_first_idx" in specified context.
>
> This command is used to dump the printk log buffer.
>
> It looks like the only places left in the kernel that reference are:
>
> - Documentation/admin-guide/kdump/gdbmacros.txt
> - Documentation/admin-guide/kdump/vmcoreinfo.rst
> - scripts/gdb/linux/dmesg.py
>
> I believe this commit removed log_first_idx, so all of the above
> probably need to be fixed up, too.

Thanks for pointing this out! I will get to work on a patch for this.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
