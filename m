Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKf80-0005h0-Vl
 for kexec@lists.infradead.org; Tue, 22 Sep 2020 10:02:29 +0000
Date: Tue, 22 Sep 2020 12:02:25 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH printk v2 0/3] printk: move dictionaries to meta data
Message-ID: <20200922100225.GK14605@alley>
References: <20200918223421.21621-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918223421.21621-1-john.ogness@linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat 2020-09-19 00:40:18, John Ogness wrote:
> Hello,
> 
> Here is v2 for a series to move all existing dictionary
> properties (SUBSYSTEM and DEVICE) into the meta data of a
> record, thus eliminating the need for the dict ring. This
> change affects how the dictionaries are stored, but does not
> affect how they are presented to userspace. (v1 is here [0]).
> 
> John Ogness (3):
>   printk: move printk_info into separate array
>   printk: move dictionary keys to dev_printk_info
>   printk: remove dict ring

The patchset is committed in printk/linux.git, branch printk-rework.

The 4th version of the 2nd patch is used.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
