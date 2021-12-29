Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 29 Dec 2021 11:11:35 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
Message-ID: <Ycw0V1CmBPCPqexn@zn.tnic>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com>
 <Ycs3kpZD/vpoo1AX@zn.tnic>
 <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
 <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com>
 <YcwSCAuEgO10DFDT@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YcwSCAuEgO10DFDT@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>

On Wed, Dec 29, 2021 at 03:45:12PM +0800, Dave Young wrote:
> BTW, I would suggest to wait for reviewers to response (eg. one week at
> least, or more due to the holidays) before updating another version
> 
> Do not worry to miss the 5.17.  I would say take it easy if it will
> miss then let's just leave with it and continue to work on the future
> improvements.  I think one reason this issue takes too long time is that it was
> discussed some time but no followup and later people need to warm up
> again.  Just keep it warm and continue to engage in the improvements, do
> not hurry for the specific mainline release.

Can you tell this to *all* patch submitters please?

I can't count the times where people simply hurry to send the new
revision just to get it in the next kernel, and make silly mistakes
while doing so. Or not think things straight and misdesign it all.

And what this causes is the opposite of what they wanna achieve - pissed
maintainers and ignored threads.

And they all *know* that the next kernel is around the corner. So why
the hell does it even matter when?

What most submitters fail to realize is, the moment your code hits
upstream, it becomes the maintainers' problem and submitters can relax.

But maintainers get to deal with this code forever. So after a while
maintainers learn that they either accept ready code and it all just
works or they make the mistake to take half-baked crap in and then they
themselves get to clean it up and fix it.

So maintainers learn quickly to push back.

But it is annoying and it would help immensely if submitters would
consider this and stop hurrying the code in but try to do a *good* job
first, design-wise and code-wise by thinking hard about what they're
trying to do.

Yeah, things could be a lot simpler and easier - it only takes a little
bit of effort...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
