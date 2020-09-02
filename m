Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 2 Sep 2020 17:42:52 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
Message-ID: <20200902164251.GA16673@gaia>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com>
 <20200808100239.GB60590@dhcp-128-65.nay.redhat.com>
 <96d0da23-d484-7f66-1680-07b4b5984831@huawei.com>
 <20200810060355.GB6988@dhcp-128-65.nay.redhat.com>
 <2e6aebf9-3765-5d8c-933c-698442db1d52@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e6aebf9-3765-5d8c-933c-698442db1d52@huawei.com>
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
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, Dave Young <dyoung@redhat.com>, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On Tue, Aug 18, 2020 at 03:07:04PM +0800, chenzhou wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index a8e34d97a894..4df18c7ea438 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -147,7 +147,7 @@ static void __init reserve_crashkernel(void)
>         }
>         memblock_reserve(crash_base, crash_size);
>  
> -       if (crash_base >= CRASH_ADDR_LOW_MAX) {
> +       if (memstart_addr < CRASH_ADDR_LOW_MAX && crash_base >= CRASH_ADDR_LOW_MAX) {
>                 const char *rename = "Crash kernel (low)";

Since CRASH_ADDR_LOW_MAX is defined as arm64_dma32_phys_limit and such
limit is always greater than memstart_addr, this additional check
doesn't do anything. See my other reply on how ZONE_DMA32 is created on
arm64.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
