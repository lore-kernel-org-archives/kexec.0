From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Thu, 24 Feb 2022 11:45:42 -0300
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <YheXRmmWr619Qxin@alley>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com> <YheXRmmWr619Qxin@alley>
Message-ID: <39f64d7d-714f-0be4-2854-10c00bcc9cda@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 24/02/2022 11:33, Petr Mladek wrote:
> [...]
> That said, I could live with the patch as is. I leave the decision
> to Andrew. Feel free to use:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr

Thanks a bunch Petr and Sergey for the reviews (and the tags).

I also vote to keep the patch as-is and get it merged, maybe eventually
improving that along with the complex panic notifiers task [0]. I could
definitely do it over there...

Andrew, is this fine for you?
Thanks,


Guilherme

[0] https://lore.kernel.org/lkml/YfPxvzSzDLjO5ldp at alley/

