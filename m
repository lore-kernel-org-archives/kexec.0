Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v17 01/10] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-2-thunder.leizhen@huawei.com> <Ybek4VRr8RaLM7kD@zn.tnic>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e96d3f88-7f33-5c83-9fdc-5d4180287ea7@huawei.com>
Date: Tue, 14 Dec 2021 17:27:27 +0800
MIME-Version: 1.0
In-Reply-To: <Ybek4VRr8RaLM7kD@zn.tnic>
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



On 2021/12/14 3:54, Borislav Petkov wrote:
>> Subject: Re: [PATCH v17 01/10] x86: kdump: replace the hard-coded alignment with macro CRASH_ALIGN
> 
>>From Documentation/process/maintainer-tip.rst:
> 
> "Patch subject
>  ^^^^^^^^^^^^^
> 
> The tip tree preferred format for patch subject prefixes is
> 'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
> 'genirq/core:'. Please do not use file names or complete file paths as
> prefix. 'git log path/to/file' should give you a reasonable hint in most
> cases.
> 
> The condensed patch description in the subject line should start with a
> uppercase letter and should be written in imperative tone."
> 
> Please fix 1-5 for your next submission.

OK. I will update them.

> 
> Thx.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
