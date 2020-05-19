Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v7 0/4] support reserving crashkernel above 4G on arm64
 kdump
From: John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <CAK8P3a2VrAqefPYF2JqRjwdhgTDtORUgWgVuYxRYWqKxE3+5pA@mail.gmail.com>
Date: Tue, 19 May 2020 15:21:58 -0500
Message-Id: <3D37F6BE-ECFC-4EC0-A7C4-341F85FC056E@oracle.com>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <a57d46bc-881e-3526-91ca-558bf64e2aa8@huawei.com>
 <CAK8P3a2VrAqefPYF2JqRjwdhgTDtORUgWgVuYxRYWqKxE3+5pA@mail.gmail.com>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Donnelly <john.p.donnelly@oracle.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Chen Zhou <chenzhou10@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, Dave Young <dyoung@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Prabhakar Kushwaha <pkushwaha@marvell.com>, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>



> On May 19, 2020, at 5:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> On Thu, Mar 26, 2020 at 4:10 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>> 
>> Hi all,
>> 
>> Friendly ping...
> 
> I was asked about this patch series, and see that you last posted it in
> December. I think you should rebase it to linux-5.7-rc6 and post the
> entire series again to make progress, as it's unlikely that any maintainer
> would pick up the patches from last year.
> 
> For the contents, everything seems reasonable to me, but I noticed that
> you are adding a property to the /chosen node without adding the
> corresponding documentation to
> Documentation/devicetree/bindings/chosen.txt
> 
> Please add that, and Cc the devicetree maintainers on the updated
> patch.
> 
>         Arnd
> 
>> On 2019/12/23 23:23, Chen Zhou wrote:
>>> This patch series enable reserving crashkernel above 4G in arm64.
>>> 
>>> There are following issues in arm64 kdump:
>>> 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
>>> when there is no enough low memory.
>>> 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
>>> in this case, if swiotlb or DMA buffers are required, crash dump kernel
>>> will boot failure because there is no low memory available for allocation.
>>> 
>>> The previous changes and discussions can be retrieved from:
>>> 
>>> Changes since [v6]
>>> - Fix build errors reported by kbuild test robot.
> ...


 Hi 

We found 

https://lkml.org/lkml/2020/4/30/1583

Has cured our Out-Of-Memory kdump failures. 

From	Henry Willard 
Subject	[PATCH] mm: Limit boost_watermark on small zones.

I am currently not on linux-kernel@vger.kernel.org. dlist for all to see  this message so you may want to rebase and see if this cures your OoM issue and share the results. 









_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
