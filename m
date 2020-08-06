Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 6 Aug 2020 15:36:27 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v11 2/5] x86: kdump: move reserve_crashkernel_low() into
 crash_core.c
Message-ID: <20200806133627.GB2077191@gmail.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-3-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200801130856.86625-3-chenzhou10@huawei.com>
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
To: Chen Zhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, catalin.marinas@arm.com, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de


* Chen Zhou <chenzhou10@huawei.com> wrote:

> In preparation for supporting reserve_crashkernel_low in arm64 as
> x86_64 does, move reserve_crashkernel_low() into kernel/crash_core.c.
> 
> BTW, move x86_64 CRASH_ALIGN to 2M suggested by Dave. CONFIG_PHYSICAL_ALIGN
> can be selected from 2M to 16M, move to the same as arm64.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/x86/include/asm/kexec.h | 24 ++++++++++
>  arch/x86/kernel/setup.c      | 86 +++---------------------------------
>  include/linux/crash_core.h   |  3 ++
>  include/linux/kexec.h        |  2 -
>  kernel/crash_core.c          | 74 +++++++++++++++++++++++++++++++
>  kernel/kexec_core.c          | 17 -------
>  6 files changed, 107 insertions(+), 99 deletions(-)

Since the changes are centered around arm64, I suppose the arm64 tree 
will carry this patchset?

Assuming that this is a 100% invariant moving of code that doesn't 
regress on x86:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
