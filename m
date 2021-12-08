Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 8 Dec 2021 17:13:38 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v16 00/11] support reserving crashkernel above 4G on
 arm64 kdump
Message-ID: <YbDnwol20HrRl4uL@arm.com>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211123124646.1995-1-thunder.leizhen@huawei.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

On Tue, Nov 23, 2021 at 08:46:35PM +0800, Zhen Lei wrote:
> Chen Zhou (10):
>   x86: kdump: replace the hard-coded alignment with macro CRASH_ALIGN
>   x86: kdump: make the lower bound of crash kernel reservation
>     consistent
>   x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
>     reserve_crashkernel()
>   x86: kdump: move xen_pv_domain() check and insert_resource() to
>     setup_arch()
>   x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
>   arm64: kdump: introduce some macros for crash kernel reservation
>   arm64: kdump: reimplement crashkernel=X
>   x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL config
>   of: fdt: Add memory for devices by DT property
>     "linux,usable-memory-range"
>   kdump: update Documentation about crashkernel
> 
> Zhen Lei (1):
>   of: fdt: Aggregate the processing of "linux,usable-memory-range"

Apart from a minor comment I made on patch 8 and some comments from Rob
that need addressing, the rest looks fine to me.

Ingo stated in the past that he's happy to ack the x86 changes as long
as there's no functional change (and that's the case AFAICT). Ingo, does
your conditional ack still stand?

In terms of merging, I'm happy to take it all through the arm64 tree
with acks from the x86 maintainers. Alternatively, with the change I
mentioned for patch 8, the first 5 patches could be queued via the tip
tree on a stable branch and I can base the rest of the arm64 on top.

Thomas, Ingo, Peter, any preference?

Thanks.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
