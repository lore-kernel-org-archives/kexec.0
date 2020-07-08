Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jt9xx-0006DE-Dh
 for kexec@lists.infradead.org; Wed, 08 Jul 2020 13:18:26 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 4/4] printk: use the lockless ringbuffer
In-Reply-To: <202007080356.fSb8SLZk%lkp@intel.com>
References: <20200707145932.8752-5-john.ogness@linutronix.de>
 <202007080356.fSb8SLZk%lkp@intel.com>
Date: Wed, 08 Jul 2020 15:24:20 +0206
Message-ID: <87r1tmcfhf.fsf@jogness.linutronix.de>
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
To: kernel test robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, kbuild-all@lists.01.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, clang-built-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>

Fix prepared for for v5.

On 2020-07-08, kernel test robot <lkp@intel.com> wrote:
>>> kernel/printk/printk.c:1146:10: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
>                           new_descs_size);
>                           ^~~~~~~~~~~~~~
>    include/linux/printk.h:338:33: note: expanded from macro 'pr_err'
>            printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>                                   ~~~     ^~~~~~~~~~~
>    1 warning generated.

Reported-by: kernel test robot <lkp@intel.com>

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index de8d54be4115..0b1337f4188c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1142,7 +1142,7 @@ void __init setup_log_buf(int early)
 	new_descs_size = new_descs_count * sizeof(struct prb_desc);
 	new_descs = memblock_alloc(new_descs_size, LOG_ALIGN);
 	if (unlikely(!new_descs)) {
-		pr_err("log_buf_len: %lu desc bytes not available\n",
+		pr_err("log_buf_len: %zu desc bytes not available\n",
 		       new_descs_size);
 		memblock_free(__pa(new_dict_buf), new_log_buf_len);
 		memblock_free(__pa(new_log_buf), new_log_buf_len);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
