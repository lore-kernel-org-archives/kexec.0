Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5bBG-0002cs-AV
 for kexec@lists.infradead.org; Tue, 11 Aug 2020 20:47:35 +0000
Received: by mail-yb1-xb49.google.com with SMTP id w17so276548ybl.9
 for <kexec@lists.infradead.org>; Tue, 11 Aug 2020 13:47:32 -0700 (PDT)
Date: Tue, 11 Aug 2020 13:47:29 -0700
In-Reply-To: <20200709132344.760-5-john.ogness@linutronix.de>
Message-Id: <20200811204729.1116341-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200709132344.760-5-john.ogness@linutronix.de>
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
From: Nick Desaulniers <ndesaulniers@google.com>
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
To: john.ogness@linutronix.de
Cc: parri.andrea@gmail.com, pmladek@suse.com, sergey.senozhatsky.work@gmail.com, paulmck@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, swboyd@chromium.org, sergey.senozhatsky@gmail.com, tglx@linutronix.de, torvalds@linux-foundation.org

From what I can tell, I think this patch ("printk: use the lockless
ringbuffer") breaks lx-dmesg in CONFIG_GDB_SCRIPTS.

(gdb) lx-dmesg
Python Exception <class 'gdb.error'> No symbol "log_first_idx" in specified context.: 
Error occurred in Python: No symbol "log_first_idx" in specified context.

This command is used to dump the printk log buffer.

It looks like the only places left in the kernel that reference are:

- Documentation/admin-guide/kdump/gdbmacros.txt
- Documentation/admin-guide/kdump/vmcoreinfo.rst
- scripts/gdb/linux/dmesg.py

I believe this commit removed log_first_idx, so all of the above probably need
to be fixed up, too.

~ Nick

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
