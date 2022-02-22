From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 22 Feb 2022 11:10:48 -0300
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <YhRFNKtxSE8Xrbfw@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
Message-ID: <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 21/02/2022 23:06, Sergey Senozhatsky wrote:
> On (22/02/14 11:13), Guilherme G. Piccoli wrote:
> [...]
> By additional panic_print messages you mean that panic_print_sys_info()
> will print everything (except PANIC_PRINT_ALL_PRINTK_MSG) twice?
> 
> Do we really need to dump everything twice? show_mem(), show_state(),
> ftrace_dump(DUMP_ALL). That's quite a bit of extra data.
> 

Oh no, we don't print everything twice, that'd be insane heh

The patch only anticipates the call site for the panic_print_sys_info()
- but as discussed in the first iterations, we couldn't just bring it
earlier due to the console replay thing. Hence, we needed to split
calls...the first call dumps the information, the 2nd call only does the
console replaying if that is set.

Cheers,


Guilherme

