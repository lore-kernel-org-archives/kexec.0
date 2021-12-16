Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v17 05/10] x86: kdump: move reserve_crashkernel[_low]()
 into crash_core.c
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-6-thunder.leizhen@huawei.com> <YbsgNpPMmp38X+it@zn.tnic>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <217fb106-980c-0bd9-8398-d52ef255d51f@huawei.com>
Date: Thu, 16 Dec 2021 21:15:18 +0800
MIME-Version: 1.0
In-Reply-To: <YbsgNpPMmp38X+it@zn.tnic>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>



On 2021/12/16 19:17, Borislav Petkov wrote:
> On Fri, Dec 10, 2021 at 02:55:28PM +0800, Zhen Lei wrote:
>> + * reserve_crashkernel() - reserves memory for crash kernel
>> + *
>> + * This function reserves memory area given in "crashkernel=" kernel command
>> + * line parameter. The memory reserved is used by dump capture kernel when
>> + * primary kernel is crashing.
>> + */
>> +void __init reserve_crashkernel(void)
> 
> As I've already alluded to in another mail, ontop of this there should
> be a patch or multiple patches which clean this up more and perhaps even
> split it into separate functions doing stuff in this order:
> 
> 1. Parse all crashkernel= cmdline options
> 
> 2. Do all crash_base, crash_size etc checks
> 
> 3. Do the memory reservations
> 
> And all that supplied with comments explaining why stuff is being done.

I agree with you. This makes the code look clear. I will do it, try to
post v18 next Monday.

> 
> This set of functions is a mess and there's no better time for cleaning
> it up and documenting it properly than when you move it to generic code.
> 
> Thx.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
