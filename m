Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com> <YbntdtQo2jfbO4cO@zn.tnic>
 <20211216011040.GG3023@MiWiFi-R3L-srv>
 <9513d74c-d4c7-babd-f823-8999e195d96d@huawei.com> <YbseAX6X1VHUF12f@zn.tnic>
 <35810a61-604e-9b90-2a7f-cfca6ae042ac@huawei.com> <YbtRs3Tq1UpCOpg8@zn.tnic>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d2b199b7-584e-8ad4-9626-09bb86cf92c5@huawei.com>
Date: Fri, 17 Dec 2021 10:51:04 +0800
MIME-Version: 1.0
In-Reply-To: <YbtRs3Tq1UpCOpg8@zn.tnic>
Content-Language: en-US
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
To: Borislav Petkov <bp@alien8.de>
Cc: Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>



On 2021/12/16 22:48, Borislav Petkov wrote:
> On Thu, Dec 16, 2021 at 08:08:30PM +0800, Leizhen (ThunderTown) wrote:
>> If the memory of 'crash_base' is successfully allocated at (1), because the last
>> parameter CRASH_ADDR_LOW_MAX is the upper bound, so we can sure that
>> "crash_base < CRASH_ADDR_LOW_MAX". So that, reserve_crashkernel_low() will not be
>> invoked at (3). That's why I said (1ULL << 32) is inaccurate and enlarge the CRASH_ADDR_LOW
>> upper limit.
> 
> No, this is actually wrong - that check *must* be 4G. See:
> 
>   eb6db83d1059 ("x86/setup: Do not reserve crashkernel high memory if low reservation failed")
> 
> It is even documented:
> 
>         crashkernel=size[KMG],low
>                         [KNL, X86-64] range under 4G. When crashkernel=X,high

[KNL, X86-64], This doc is for X86-64, not for X86-32

>                         is passed, kernel could allocate physical memory region
>                         above 4G, that cause second kernel crash on system
>                         that require some amount of low memory, e.g. swiotlb
>                         requires at least 64M+32K low memory, also enough extra
>                         low memory is needed to make sure DMA buffers for 32-bit
>                         devices won't run out.

vi arch/x86/kernel/setup.c +398

/*
 * Keep the crash kernel below this limit.
 *
 * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
 * due to mapping restrictions.

If there is no such restriction, we can make CRASH_ADDR_LOW_MAX equal to (1ULL << 32) minus 1 on X86_32.

> 
> so you need to do a low allocation for DMA *when* the reserved memory is
> above 4G. *NOT* above 512M. But that works due to the obscure situation,
> as Baoquan stated, that reserve_crashkernel_low() returns 0 on 32-bit.
> 
> So all this is telling us is that that function needs serious cleanup.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
