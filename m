Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 13 Dec 2021 10:18:06 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v16 00/11] support reserving crashkernel above 4G on
 arm64 kdump
Message-ID: <Ybcd3r9AeV9vzuG4@arm.com>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
 <YbDnwol20HrRl4uL@arm.com>
 <db65cd76-e2c0-4d35-0dcc-d9f8c164f77e@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <db65cd76-e2c0-4d35-0dcc-d9f8c164f77e@oracle.com>
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
To: john.p.donnelly@oracle.com
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

On Fri, Dec 10, 2021 at 01:53:59PM -0600, john.p.donnelly@oracle.com wrote:
> On 12/8/21 11:13 AM, Catalin Marinas wrote:
> > On Tue, Nov 23, 2021 at 08:46:35PM +0800, Zhen Lei wrote:
> > > Chen Zhou (10):
> > >    x86: kdump: replace the hard-coded alignment with macro CRASH_ALIGN
> > >    x86: kdump: make the lower bound of crash kernel reservation
> > >      consistent
> > >    x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
> > >      reserve_crashkernel()
> > >    x86: kdump: move xen_pv_domain() check and insert_resource() to
> > >      setup_arch()
> > >    x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
> > >    arm64: kdump: introduce some macros for crash kernel reservation
> > >    arm64: kdump: reimplement crashkernel=X
> > >    x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL config
> > >    of: fdt: Add memory for devices by DT property
> > >      "linux,usable-memory-range"
> > >    kdump: update Documentation about crashkernel
> > > 
> > > Zhen Lei (1):
> > >    of: fdt: Aggregate the processing of "linux,usable-memory-range"
> > 
> > Apart from a minor comment I made on patch 8 and some comments from Rob
> > that need addressing, the rest looks fine to me.
> > 
> > Ingo stated in the past that he's happy to ack the x86 changes as long
> > as there's no functional change (and that's the case AFAICT). Ingo, does
> > your conditional ack still stand?
> > 
> > In terms of merging, I'm happy to take it all through the arm64 tree
> > with acks from the x86 maintainers. Alternatively, with the change I
> > mentioned for patch 8, the first 5 patches could be queued via the tip
> > tree on a stable branch and I can base the rest of the arm64 on top.
> > 
> > Thomas, Ingo, Peter, any preference?
> > 
> > Thanks.
> 
> If you notice the trend over the past year , some of additional review
> requests are because the submitter had to rebase to the next version.

Normally the reviews stand even if the series is rebased. You only drop
them if there were non-trivial changes to the patches, not just because
of a rebase.

Ingo acked the x86 changes in the past but there were some functional
changes to the minimum alignment, so the series had to be reworked and
the ack not applied.

https://lore.kernel.org/r/20200806133627.GB2077191@gmail.com

> Can we get this acked and placed in a build so others can test and start
> using it ?

If Ingo's conditional ack (no functional changes, just a move) still
stands over the five x86 patches now, I'm happy to queue them all via
the arm64 tree. The latest series here:

https://lore.kernel.org/r/20211210065533.2023-1-thunder.leizhen@huawei.com

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
