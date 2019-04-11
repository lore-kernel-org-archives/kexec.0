Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] x86: kdump: move reserve_crashkernel_low() into
 kexec_core.c
References: <20190409102819.121335-1-chenzhou10@huawei.com>
 <20190409102819.121335-2-chenzhou10@huawei.com>
 <20190410070914.GA10935@gmail.com>
From: Chen Zhou <chenzhou10@huawei.com>
Message-ID: <31b41dcc-0d16-d1d0-bff9-dec3e77515c1@huawei.com>
Date: Thu, 11 Apr 2019 20:32:11 +0800
MIME-Version: 1.0
In-Reply-To: <20190410070914.GA10935@gmail.com>
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
To: Ingo Molnar <mingo@kernel.org>
Cc: wangkefeng.wang@huawei.com, akpm@linux-foundation.org, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, rppt@linux.ibm.com, linux-mm@kvack.org, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com, linux-arm-kernel@lists.infradead.org

Hi Ingo,

On 2019/4/10 15:09, Ingo Molnar wrote:
> 
> * Chen Zhou <chenzhou10@huawei.com> wrote:
> 
>> In preparation for supporting more than one crash kernel regions
>> in arm64 as x86_64 does, move reserve_crashkernel_low() into
>> kexec/kexec_core.c.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/x86/include/asm/kexec.h |  3 ++
>>  arch/x86/kernel/setup.c      | 66 +++++---------------------------------------
>>  include/linux/kexec.h        |  1 +
>>  kernel/kexec_core.c          | 53 +++++++++++++++++++++++++++++++++++
>>  4 files changed, 64 insertions(+), 59 deletions(-)
> 
> No objections for this to be merged via the ARM tree, as long as x86 
> functionality is kept intact.

This patch has no affect on x86.

Thanks,
Chen Zhou

> 
> Thanks,
> 
> 	Ingo
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
