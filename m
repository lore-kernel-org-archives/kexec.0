Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 16 Dec 2021 12:07:45 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
Message-ID: <YbseAX6X1VHUF12f@zn.tnic>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
 <YbntdtQo2jfbO4cO@zn.tnic> <20211216011040.GG3023@MiWiFi-R3L-srv>
 <9513d74c-d4c7-babd-f823-8999e195d96d@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9513d74c-d4c7-babd-f823-8999e195d96d@huawei.com>
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
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

On Thu, Dec 16, 2021 at 10:46:12AM +0800, Leizhen (ThunderTown) wrote:
> The original value (1ULL << 32) is inaccurate

I keep asking *why*?

> and it enlarged the CRASH_ADDR_LOW upper limit.

$ git grep -E "CRASH_ADDR_LOW\W"
$

I have no clue what you mean here.

> This is because when the memory is allocated from the low end, the
> address cannot exceed CRASH_ADDR_LOW_MAX, see "if (!high)" branch.

> If
> the memory is allocated from the high end, 'crash_base' is greater than or
> equal to (1ULL << 32), and naturally, it is greater than CRASH_ADDR_LOW_MAX.
> 
> I think I should update the description, thanks.

I think you should explain why is (1ULL << 32) wrong.

It came from:

  eb6db83d1059 ("x86/setup: Do not reserve crashkernel high memory if low reservation failed")

which simply frees the high memory portion when the low reservation
fails. And the test for that is, is crash base > 4G. So that makes
perfect sense to me.

So your change is a NOP on 64-bit and it is a NOP on 32-bit by virtue of
the _low() variant always returning 0 on 32-bit.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
