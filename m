Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 30 Dec 2021 11:40:38 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v19 01/13] kdump: add helper parse_crashkernel_high_low()
Message-ID: <Yc2MprJJsm7LagGc@zn.tnic>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-2-thunder.leizhen@huawei.com>
 <4878dda9-871d-228d-21ac-3ac7c8a84322@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4878dda9-871d-228d-21ac-3ac7c8a84322@huawei.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>

On Thu, Dec 30, 2021 at 06:14:59PM +0800, Leizhen (ThunderTown) wrote:
> 
> Hi, Dave, Baoquan, Borislav:
>   What do you think about the introduction of parse_crashkernel_high_low()? If everyone
> doesn't object, I'll bring it to the next version. But I'll make some adjustments to the
> patches, see below. If there's any objection, I still strongly recommend removing the
> parameters "system_ram" and "crash_base" of parse_crashkernel_{high,low}().
> 
> How about splitting __parse_crashkernel() into two parts? One for parsing
> "crashkernel=X[@offset]", another one for parsing "crashkernel=X,{high,low}" and other
> suffixes in the future. So the parameter requirements are clear at the lowest level.

First of all, please do not top post!

Now, I already explained to you what I'd like to see:

https://lore.kernel.org/r/Ycs3kpZD/vpoo1AX@zn.tnic

yet you still don't get it.

So let me make myself clear: in its current form, this is not really an
improvement so for all x86 changes:

NAKed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
