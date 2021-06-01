Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loEDY-001I2Z-AF
 for kexec@lists.infradead.org; Tue, 01 Jun 2021 23:54:41 +0000
Date: Wed, 2 Jun 2021 08:54:31 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 1/4] kprobes: Fix spelling mistakes
Message-Id: <20210602085431.a4c2f3eb92f020ed50775eda@kernel.org>
In-Reply-To: <20210529110305.9446-2-thunder.leizhen@huawei.com>
References: <20210529110305.9446-1-thunder.leizhen@huawei.com>
 <20210529110305.9446-2-thunder.leizhen@huawei.com>
Mime-Version: 1.0
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
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Balbir Singh <bsingharora@gmail.com>, Barry Song <song.bao.hua@hisilicon.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Eric Biederman <ebiederm@xmission.com>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jessica Yu <jeyu@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, Oleg Nesterov <oleg@redhat.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, kgdb-bugreport <kgdb-bugreport@lists.sourceforge.net>, kexec <kexec@lists.infradead.org>, linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sat, 29 May 2021 19:03:02 +0800
Zhen Lei <thunder.leizhen@huawei.com> wrote:

> Fix some spelling mistakes in comments:
> decrese ==> decrease
> immmediately ==> immediately

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  include/linux/freelist.h | 2 +-
>  kernel/kprobes.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/freelist.h b/include/linux/freelist.h
> index fc1842b96469..1811c1f3f8cb 100644
> --- a/include/linux/freelist.h
> +++ b/include/linux/freelist.h
> @@ -39,7 +39,7 @@ static inline void __freelist_add(struct freelist_node *node, struct freelist_he
>  	 * and a refcount increment of a node in try_get, then back up to
>  	 * something non-zero, then the refcount increment is done by the other
>  	 * thread) -- so if the CAS to add the node to the actual list fails,
> -	 * decrese the refcount and leave the add operation to the next thread
> +	 * decrease the refcount and leave the add operation to the next thread
>  	 * who puts the refcount back to zero (which could be us, hence the
>  	 * loop).
>  	 */
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 8c0a6fdef771..d4156082d5a5 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -641,7 +641,7 @@ void wait_for_kprobe_optimizer(void)
>  	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
>  		mutex_unlock(&kprobe_mutex);
>  
> -		/* this will also make optimizing_work execute immmediately */
> +		/* this will also make optimizing_work execute immediately */
>  		flush_delayed_work(&optimizing_work);
>  		/* @optimizing_work might not have been queued yet, relax */
>  		cpu_relax();
> -- 
> 2.25.1
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
