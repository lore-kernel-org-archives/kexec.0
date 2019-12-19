Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v6 0/4] support reserving crashkernel above 4G on arm64
 kdump
References: <20190830071200.56169-1-chenzhou10@huawei.com>
 <2a97b296-59e7-0a26-84fa-e2ddcd7987b6@huawei.com>
 <20191218090932.GA14061@willie-the-truck>
From: Chen Zhou <chenzhou10@huawei.com>
Message-ID: <60f9bf3c-62d1-41cc-ad8e-0e06e6495d52@huawei.com>
Date: Thu, 19 Dec 2019 09:35:25 +0800
MIME-Version: 1.0
In-Reply-To: <20191218090932.GA14061@willie-the-truck>
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
To: Will Deacon <will@kernel.org>
Cc: horms@verge.net.au, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, james.morse@arm.com, guohanjun@huawei.com, tglx@linutronix.de, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

Hi Will

On 2019/12/18 17:09, Will Deacon wrote:
> On Wed, Dec 18, 2019 at 10:07:59AM +0800, Chen Zhou wrote:
>> Friendly ping...
> 
> You broke the build:
> 
> https://lore.kernel.org/lkml/201909010744.CDe940pv%lkp@intel.com
> https://lore.kernel.org/lkml/201909010704.4m9y2sg7%lkp@intel.com
> 
> So I doubt anybody will seriously look at this.

I was also waiting for other suggestions.
I will fix this in next version.

> 
> Will
> 
> .

Thanks,
Chen Zhou


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
