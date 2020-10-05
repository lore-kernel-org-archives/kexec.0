Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 5 Oct 2020 18:20:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v12 3/9] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel[_low]()
Message-ID: <20201005172057.GE14576@gaia>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-4-chenzhou10@huawei.com>
 <20200918072526.GD25604@MiWiFi-R3L-srv>
 <fa6634dd-4438-4e5d-f350-fc19d5fa7d97@huawei.com>
 <14e22d92-1601-fc1c-a1c8-e3936d63db42@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <14e22d92-1601-fc1c-a1c8-e3936d63db42@huawei.com>
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
To: chenzhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, Baoquan He <bhe@redhat.com>, corbet@lwn.net, rppt@linux.ibm.com, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On Fri, Sep 18, 2020 at 05:06:37PM +0800, chenzhou wrote:
> On 2020/9/18 16:59, chenzhou wrote:
> > On 2020/9/18 15:25, Baoquan He wrote:
> >> On 09/07/20 at 09:47pm, Chen Zhou wrote:
> >>> To make the functions reserve_crashkernel[_low]() as generic,
> >>> replace some hard-coded numbers with macro CRASH_ADDR_LOW_MAX.
> >>>
> >>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >>> ---
> >>>  arch/x86/kernel/setup.c | 11 ++++++-----
> >>>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >>> index d7fd90c52dae..71a6a6e7ca5b 100644
> >>> --- a/arch/x86/kernel/setup.c
> >>> +++ b/arch/x86/kernel/setup.c
> >>> @@ -430,7 +430,7 @@ static int __init reserve_crashkernel_low(void)
> >>>  	unsigned long total_low_mem;
> >>>  	int ret;
> >>>  
> >>> -	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
> >>> +	total_low_mem = memblock_mem_size(CRASH_ADDR_LOW_MAX >> PAGE_SHIFT);
> >> Just note that the replacement has been done in another patch from Mike
> >> Rapoport, partially. He seems to have done reserve_crashkernel_low()
> >> part, there's one left in reserve_crashkernel(), you might want to check
> >> that. 
> >>
> >> Mike's patch which is from a patchset has been merged into Andrew's next
> >> tree.
> >>
> >> commit 6e50f7672ffa362e9bd4bc0c0d2524ed872828c5
> >> Author: Mike Rapoport <rppt@linux.ibm.com>
> >> Date:   Wed Aug 26 15:22:32 2020 +1000
> >>
> >>     x86/setup: simplify reserve_crashkernel()
> As Baoquan said, some functions have been changed in the next tree,
> if i need to rebase on top of the next tree.

Please rebase at 5.10-rc1 when the x86 change will probably be in and
aim to queue this series for 5.11.

Thanks.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
