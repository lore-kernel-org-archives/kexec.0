Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 29 Dec 2021 17:51:29 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
Message-ID: <YcySEdyhXysDSKn/@zn.tnic>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com>
 <Ycs3kpZD/vpoo1AX@zn.tnic>
 <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
 <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com>
 <YcwyZRDJUMniSaY9@zn.tnic>
 <Ycw8n2BvJzH9wJKG@dhcp-128-65.nay.redhat.com>
 <21736ba2-883d-1037-dbe8-299e40f7ad13@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <21736ba2-883d-1037-dbe8-299e40f7ad13@huawei.com>
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
Cc: Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>

On Wed, Dec 29, 2021 at 11:04:21PM +0800, Leizhen (ThunderTown) wrote:
> Chen Zhou and I tried to share the code because of a suggestion. After so many
> attempts, it doesn't seem to fit to make generic. Or maybe I haven't figured
> out a good solution yet.

Well, you learned a very important lesson and the many attempts are not
in vain: code sharing does not make sense in every case.

> I will put the patches that make arm64 support crashkernel...high,low to
> the front, then the parse_crashkernel() unification patches. Even if the
> second half of the patches is not ready for v5.18, the first half of the
> patches is ready.

I think you should concentrate on the arm64 side which is, AFAICT, what
you're trying to achieve.

The "parse_crashkernel() unification" needs more thought because, as I
said already, that doesn't make a whole lot of sense to me.

If you want to enforce the fact that "low" makes sense only when "high"
is supplied, parse_crashkernel_high_low() is not the right thing to do.
You need to have a *single* function which does all the parsing where
you can decide what to do: "if high, parse low", "if no high supplied,
ignore low" and so on.

And if those are supported on certain architectures only, you can do
ifdeffery...

But I think I already stated that I don't like such unifications which
introduce unnecessary dependencies between architectures. Therefore, I
won't accept them into x86 unless there's a strong compelling reason.
Which I don't see ATM.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
