Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 23 Dec 2021 18:26:06 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v18 02/17] x86/setup: Move xen_pv_domain() check and
 insert_resource() to setup_arch()
Message-ID: <YcSxLodOnxXHx0sV@zn.tnic>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
 <20211222130820.1754-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211222130820.1754-3-thunder.leizhen@huawei.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>

On Wed, Dec 22, 2021 at 09:08:05PM +0800, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> We will make the functions reserve_crashkernel() as generic, the
> xen_pv_domain() check in reserve_crashkernel() is relevant only to
> x86,

Why is that so? Is Xen-PV x86-only?

> the same as insert_resource() in reserve_crashkernel[_low]().

Why?

Looking at

  0212f9159694 ("x86: Add Crash kernel low reservation")

it *surprisingly* explains why that resources thing is being added:

    We need to add another range in /proc/iomem like "Crash kernel low",
    so kexec-tools could find that info and append to kdump kernel
    command line.

Then,

  157752d84f5d ("kexec: use Crash kernel for Crash kernel low")

renamed it because, as it states, kexec-tools was taught to handle
multiple resources of the same name.

So why does kexec-tools on arm *not* need those iomem resources? How
does it parse the ranges there? Questions over questions...

So last time I told you to sit down and take your time with this cleanup.
From reading this here, it doesn't look like it. Rather, it looks like
hastily done in a hurry and hurrying stuff doesn't help you one bit - it
actually makes it worse.

Your commit messages need to explain *why* a change is being done and
why is that ok. This one doesn't.

> @@ -1120,7 +1109,17 @@ void __init setup_arch(char **cmdline_p)
>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>  	 * won't consume hotpluggable memory.
>  	 */
> -	reserve_crashkernel();
> +#ifdef CONFIG_KEXEC_CORE
> +	if (xen_pv_domain())
> +		pr_info("Ignoring crashkernel for a Xen PV domain\n");

This is wrong - the check is currently being done inside
reserve_crashkernel(), *after* it has parsed a crashkernel= cmdline
correctly - and not before.

Your change would print on Xen PV, regardless of whether it has received
crashkernel= on the cmdline or not.

This is exactly why I say that making those functions generic and shared
might not be such a good idea, after all, because then you'd have to
sprinkle around arch-specific stuff.

One of the ways how to address this particular case here would be:

1. Add a x86-specific wrapper around parse_crashkernel() which does
all the parsing. When that wrapper finishes, you should have parsed
everything that has crashkernel= on the cmdline.

2. At the end of that wrapper, you do arch-specific checks and setup
like the xen_pv_domain() one.

3. Now, you do reserve_crashkernel(), if those checks pass.

The question is, whether the flow on arm64 can do the same. Probably but
it needs careful auditing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
