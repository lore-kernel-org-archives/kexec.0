Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD58C-0001ZX-VV
 for kexec@lists.infradead.org; Tue, 01 Sep 2020 12:11:21 +0000
Date: Tue, 1 Sep 2020 14:11:17 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH][next] docs: vmcoreinfo: add lockless printk ringbuffer
 vmcoreinfo
Message-ID: <20200901121116.GL4928@alley>
References: <20200814213316.6394-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814213316.6394-1-john.ogness@linutronix.de>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri 2020-08-14 23:39:16, John Ogness wrote:
> With the introduction of the lockless printk ringbuffer, the
> VMCOREINFO relating to the kernel log buffer was changed. Update the
> documentation to match those changes.
> 
> Fixes: ("printk: use the lockless ringbuffer")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>

The patch is committed in printk/linux.git, branch printk-rework.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
