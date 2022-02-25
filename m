From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Fri, 25 Feb 2022 14:23:07 +0900
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <YhhmnmgAlVCcVqSV@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com> <YheXRmmWr619Qxin@alley>
 <YhhmnmgAlVCcVqSV@google.com>
Message-ID: <Yhhnu8K71Gz53aeO@google.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Correction:

On (22/02/25 14:18), Sergey Senozhatsky wrote:
> > 
> > Or just split panic_printk_sys_info() into these two functions.
> 
> Agreed. I also tend to think that panic_printk_sys_info() is needed anyway,

							^^^^ split

