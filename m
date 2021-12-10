Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 10 Dec 2021 10:43:15 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v17 09/10] of: fdt: Add memory for devices by DT property
 "linux,usable-memory-range"
Message-ID: <YbODo3WbV27NyL7h@robh.at.kernel.org>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-10-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211210065533.2023-10-thunder.leizhen@huawei.com>
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
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-doc@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, Will Deacon <will@kernel.org>, Chen Zhou <dingguo.cz@antgroup.com>, Eric Biederman <ebiederm@xmission.com>, Rob Herring <robh+dt@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Frank Rowand <frowand.list@gmail.com>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri, 10 Dec 2021 14:55:32 +0800, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices and never mapped by the first kernel.
> This memory range is advertised to crash dump kernel via DT property
> under /chosen,
>         linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>
> 
> We reused the DT property linux,usable-memory-range and made the low
> memory region as the second range "BASE2 SIZE2", which keeps compatibility
> with existing user-space and older kdump kernels.
> 
> Crash dump kernel reads this property at boot time and call memblock_add()
> to add the low memory region after memblock_cap_memory_range() has been
> called.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  drivers/of/fdt.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
