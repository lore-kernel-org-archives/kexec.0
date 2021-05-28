Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmdoE-00GLOh-Bk
 for kexec@lists.infradead.org; Fri, 28 May 2021 14:50:00 +0000
Received: by mail-wm1-x335.google.com with SMTP id
 y184-20020a1ce1c10000b02901769b409001so2552949wmg.3
 for <kexec@lists.infradead.org>; Fri, 28 May 2021 07:49:57 -0700 (PDT)
Date: Fri, 28 May 2021 15:49:53 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 1/1] kernel: fix numerous spelling mistakes
Message-ID: <20210528144953.akwuf5nwky4kt3to@maple.lan>
References: <20210526035345.9113-1-thunder.leizhen@huawei.com>
 <20210526035345.9113-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210526035345.9113-2-thunder.leizhen@huawei.com>
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
Cc: Jason Wessel <jason.wessel@windriver.com>, Douglas Anderson <dianders@chromium.org>, Balbir Singh <bsingharora@gmail.com>, Barry Song <song.bao.hua@hisilicon.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Eric Biederman <ebiederm@xmission.com>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Masami Hiramatsu <mhiramat@kernel.org>, Jessica Yu <jeyu@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, Oleg Nesterov <oleg@redhat.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, kgdb-bugreport <kgdb-bugreport@lists.sourceforge.net>, kexec <kexec@lists.infradead.org>, linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, May 26, 2021 at 11:53:45AM +0800, Zhen Lei wrote:
> Fix some spelling mistakes in comments:
> suspeneded ==> suspended
> occuring ==> occurring
> wont ==> won't
> detatch ==> detach
> represntation ==> representation
> hexidecimal ==> hexadecimal
> delimeter ==> delimiter
> architecure ==> architecture
> accumalator ==> accumulator
> evertything ==> everything
> contingous ==> contiguous
> useable ==> usable
> musn't ==> mustn't
> alloed ==> allowed
> immmediately ==> immediately
> Allocted ==> Allocated
> noone ==> no one
> unparseable ==> unparsable
> dependend ==> dependent
> callled ==> called
> alreay ==> already
> childs ==> children
> implemention ==> implementation
> situration ==> situation
> overriden ==> overridden
> asynchonous ==> asynchronous
> accumalate ==> accumulate
> syncrhonized ==> synchronized
> therefor ==> therefore
> ther ==> their
> capabilites ==> capabilities
> lentgh ==> length
> watchog ==> watchdog
> assing ==> assign
> Retun ==> Return
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/acct.c                  | 2 +-
>  kernel/context_tracking.c      | 2 +-
>  kernel/cpu.c                   | 2 +-
>  kernel/debug/debug_core.c      | 2 +-
>  kernel/debug/kdb/kdb_main.c    | 8 ++++----
>  kernel/debug/kdb/kdb_private.h | 2 +-

For these three files:

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
