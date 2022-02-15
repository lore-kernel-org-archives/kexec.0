From: Petr Mladek <pmladek@suse.com>
Date: Tue, 15 Feb 2022 17:14:51 +0100
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <20220214141308.841525-1-gpiccoli@igalia.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
Message-ID: <YgvRe92hEvj5mEUS@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon 2022-02-14 11:13:09, Guilherme G. Piccoli wrote:
> The panic_print setting allows users to collect more information in a
> panic event, like memory stats, tasks, CPUs backtraces, etc.
> This is an interesting debug mechanism, but currently the print event
> happens *after* kmsg_dump(), meaning that pstore, for example, cannot
> collect a dmesg with the panic_print extra information.
> 
> This patch changes that in 2 steps:
> 
> (a) The panic_print setting allows to replay the existing kernel log
> buffer to the console (bit 5), besides the extra information dump.
> This functionality makes sense only at the end of the panic() function.
> So, we hereby allow to distinguish the two situations by a new boolean
> parameter in the function panic_print_sys_info().
> 
> (b) With the above change, we can safely call panic_print_sys_info()
> before kmsg_dump(), allowing to dump the extra information when using
> pstore or other kmsg dumpers.
> 
> The additional messages from panic_print could overwrite the oldest
> messages when the buffer is full. The only reasonable solution is to
> use a large enough log buffer, hence we added an advice into the kernel
> parameters documentation about that.
> 
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Makes sense and looks good to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

