Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 21 Dec 2021 23:23:38 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
Message-ID: <YcJT6lylm1KZ6Hdc@zn.tnic>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
 <YbntdtQo2jfbO4cO@zn.tnic> <20211216011040.GG3023@MiWiFi-R3L-srv>
 <9513d74c-d4c7-babd-f823-8999e195d96d@huawei.com>
 <YbseAX6X1VHUF12f@zn.tnic>
 <35810a61-604e-9b90-2a7f-cfca6ae042ac@huawei.com>
 <YbtRs3Tq1UpCOpg8@zn.tnic>
 <d2b199b7-584e-8ad4-9626-09bb86cf92c5@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d2b199b7-584e-8ad4-9626-09bb86cf92c5@huawei.com>
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

On Fri, Dec 17, 2021 at 10:51:04AM +0800, Leizhen (ThunderTown) wrote:
> [KNL, X86-64], This doc is for X86-64, not for X86-32

reserve_crashkernel() runs on both.

> If there is no such restriction, we can make CRASH_ADDR_LOW_MAX equal
> to (1ULL << 32) minus 1 on X86_32.

Again, the 4G limit check is relevant only for 64-bit kernels - not
32-bit ones.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
