Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 12 Apr 2019 09:00:27 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 1/4] x86: kdump: move reserve_crashkernel_low() into
 kexec_core.c
Message-ID: <20190412070027.GB129493@gmail.com>
References: <20190409102819.121335-1-chenzhou10@huawei.com>
 <20190409102819.121335-2-chenzhou10@huawei.com>
 <20190410070914.GA10935@gmail.com>
 <31b41dcc-0d16-d1d0-bff9-dec3e77515c1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <31b41dcc-0d16-d1d0-bff9-dec3e77515c1@huawei.com>
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
To: Chen Zhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, akpm@linux-foundation.org, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, rppt@linux.ibm.com, linux-mm@kvack.org, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com, linux-arm-kernel@lists.infradead.org


* Chen Zhou <chenzhou10@huawei.com> wrote:

> Hi Ingo,
> 
> On 2019/4/10 15:09, Ingo Molnar wrote:
> > 
> > * Chen Zhou <chenzhou10@huawei.com> wrote:
> > 
> >> In preparation for supporting more than one crash kernel regions
> >> in arm64 as x86_64 does, move reserve_crashkernel_low() into
> >> kexec/kexec_core.c.
> >>
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> ---
> >>  arch/x86/include/asm/kexec.h |  3 ++
> >>  arch/x86/kernel/setup.c      | 66 +++++---------------------------------------
> >>  include/linux/kexec.h        |  1 +
> >>  kernel/kexec_core.c          | 53 +++++++++++++++++++++++++++++++++++
> >>  4 files changed, 64 insertions(+), 59 deletions(-)
> > 
> > No objections for this to be merged via the ARM tree, as long as x86 
> > functionality is kept intact.
> 
> This patch has no affect on x86.

In *principle*.

In practice the series does change x86 code:

> >>  arch/x86/kernel/setup.c      | 66 +++++---------------------------------------
> >>  include/linux/kexec.h        |  1 +
> >>  kernel/kexec_core.c          | 53 +++++++++++++++++++++++++++++++++++

which is, *hopefully*, an identity transformation. :-)

I.e. Ack, but only if it doesn't break anything. :-)

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
