Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <a57d46bc-881e-3526-91ca-558bf64e2aa8@huawei.com>
In-Reply-To: <a57d46bc-881e-3526-91ca-558bf64e2aa8@huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2020 12:21:55 +0200
Message-ID: <CAK8P3a2VrAqefPYF2JqRjwdhgTDtORUgWgVuYxRYWqKxE3+5pA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] support reserving crashkernel above 4G on arm64
 kdump
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
Cc: Simon Horman <horms@verge.net.au>, john.p.donnelly@oracle.com, Will Deacon <will@kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, pkushwaha@marvell.com, Dave Young <dyoung@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 26, 2020 at 4:10 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> Hi all,
>
> Friendly ping...

I was asked about this patch series, and see that you last posted it in
December. I think you should rebase it to linux-5.7-rc6 and post the
entire series again to make progress, as it's unlikely that any maintainer
would pick up the patches from last year.

For the contents, everything seems reasonable to me, but I noticed that
you are adding a property to the /chosen node without adding the
corresponding documentation to
Documentation/devicetree/bindings/chosen.txt

Please add that, and Cc the devicetree maintainers on the updated
patch.

         Arnd

> On 2019/12/23 23:23, Chen Zhou wrote:
> > This patch series enable reserving crashkernel above 4G in arm64.
> >
> > There are following issues in arm64 kdump:
> > 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
> > when there is no enough low memory.
> > 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
> > in this case, if swiotlb or DMA buffers are required, crash dump kernel
> > will boot failure because there is no low memory available for allocation.
> >
> > The previous changes and discussions can be retrieved from:
> >
> > Changes since [v6]
> > - Fix build errors reported by kbuild test robot.
...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
