Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 15 Dec 2021 11:01:03 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v17 02/10] x86: kdump: make the lower bound of crash
 kernel reservation consistent
Message-ID: <YbnK79c0YokJ1ahu@arm.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-3-thunder.leizhen@huawei.com>
 <YbjrjpehprvoRXbV@zn.tnic> <YbjvXl51hc6GZa71@arm.com>
 <20211215034219.GB10336@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211215034219.GB10336@MiWiFi-R3L-srv>
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
Cc: Borislav Petkov <bp@alien8.de>, Zhen Lei <thunder.leizhen@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

On Wed, Dec 15, 2021 at 11:42:19AM +0800, Baoquan He wrote:
> On 12/14/21 at 07:24pm, Catalin Marinas wrote:
> > On Tue, Dec 14, 2021 at 08:07:58PM +0100, Borislav Petkov wrote:
> > > On Fri, Dec 10, 2021 at 02:55:25PM +0800, Zhen Lei wrote:
> > > > From: Chen Zhou <chenzhou10@huawei.com>
> > > > 
> > > > The lower bounds of crash kernel reservation and crash kernel low
> > > > reservation are different, use the consistent value CRASH_ALIGN.
> > > 
> > > A big WHY is missing here to explain why the lower bound of the
> > > allocation range needs to be 16M and why was 0 wrong?
> > 
> > I asked the same here:
> > 
> > https://lore.kernel.org/r/20210224143547.GB28965@arm.com
> > 
> > IIRC Baoquan said that there is a 1MB reserved for x86 anyway in the
> > lower part, so that's equivalent in practice to starting from
> > CRASH_ALIGN.
> 
> Yeah, even for i386, there's area reserved by BIOS inside low 1M.
> Considering the existing alignment CRASH_ALIGN which is 16M, we
> definitely have no chance to get memory starting from 0. So starting
> from 16M can skip the useless memblock searching, and make the
> crashkernel low reservation consisten with crashkernel reservation on
> allocation code.

That's the x86 assumption. Is it valid for other architectures once the
code has been made generic in patch 6? It should be ok for arm64, RAM
tends to start from higher up but other architectures may start using
this common code.

If you want to keep the same semantics as before, just leave it as 0.
It's not that the additional lower bound makes the search slower.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
