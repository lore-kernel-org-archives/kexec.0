Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v17 05/10] x86: kdump: move reserve_crashkernel[_low]()
 into crash_core.c
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-6-thunder.leizhen@huawei.com>
 <20211214104558.GA28607@MiWiFi-R3L-srv>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <097c6a8c-3b96-19b4-2bb9-bf2dcb4a6109@huawei.com>
Date: Tue, 14 Dec 2021 20:38:41 +0800
MIME-Version: 1.0
In-Reply-To: <20211214104558.GA28607@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>



On 2021/12/14 18:45, Baoquan He wrote:
>> +		/* User specifies base address explicitly. */
> If you plan to repost, please take above sentence off either. Then we
> can say this patch is only doing code moving.
> 
>> +		unsigned long long start;
>> +
> OK, I can see that this patch is only moving code, and introducing
> CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL to wrap them appropriately, no
> extra functionality change added or removed, except of this place.
> An alignment checking is added for the user specified base address.
> I love this checking. While I have to say it will be more perfect if
> it's put in another small patch, that will be look much better from
> patch splitting and reviewing point of view.

Good eye. I will put it in a new patch.

> 
> This whole patch looks great to me, thanks for the effort.
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
