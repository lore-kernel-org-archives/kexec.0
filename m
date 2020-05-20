Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbK9n-0006GJ-8h
 for kexec@lists.infradead.org; Wed, 20 May 2020 08:32:56 +0000
Received: by mail-qk1-f200.google.com with SMTP id b7so3043056qkk.6
 for <kexec@lists.infradead.org>; Wed, 20 May 2020 01:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <a57d46bc-881e-3526-91ca-558bf64e2aa8@huawei.com>
 <CAK8P3a2VrAqefPYF2JqRjwdhgTDtORUgWgVuYxRYWqKxE3+5pA@mail.gmail.com>
 <3D37F6BE-ECFC-4EC0-A7C4-341F85FC056E@oracle.com>
In-Reply-To: <3D37F6BE-ECFC-4EC0-A7C4-341F85FC056E@oracle.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 20 May 2020 14:02:36 +0530
Message-ID: <CACi5LpO82hmXG6bcSqhAhNZJW8mPRP2CuLGT2mrgKDMk1s8g_g@mail.gmail.com>
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
To: John Donnelly <john.p.donnelly@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Chen Zhou <chenzhou10@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, kexec mailing list <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>, Simon Horman <horms@verge.net.au>, James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Prabhakar Kushwaha <pkushwaha@marvell.com>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi John,

On Wed, May 20, 2020 at 1:53 AM John Donnelly
<john.p.donnelly@oracle.com> wrote:
>
>
>
> > On May 19, 2020, at 5:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Mar 26, 2020 at 4:10 AM Chen Zhou <chenzhou10@huawei.com> wrote:
> >>
> >> Hi all,
> >>
> >> Friendly ping...
> >
> > I was asked about this patch series, and see that you last posted it in
> > December. I think you should rebase it to linux-5.7-rc6 and post the
> > entire series again to make progress, as it's unlikely that any maintainer
> > would pick up the patches from last year.
> >
> > For the contents, everything seems reasonable to me, but I noticed that
> > you are adding a property to the /chosen node without adding the
> > corresponding documentation to
> > Documentation/devicetree/bindings/chosen.txt
> >
> > Please add that, and Cc the devicetree maintainers on the updated
> > patch.
> >
> >         Arnd
> >
> >> On 2019/12/23 23:23, Chen Zhou wrote:
> >>> This patch series enable reserving crashkernel above 4G in arm64.
> >>>
> >>> There are following issues in arm64 kdump:
> >>> 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
> >>> when there is no enough low memory.
> >>> 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
> >>> in this case, if swiotlb or DMA buffers are required, crash dump kernel
> >>> will boot failure because there is no low memory available for allocation.
> >>>
> >>> The previous changes and discussions can be retrieved from:
> >>>
> >>> Changes since [v6]
> >>> - Fix build errors reported by kbuild test robot.
> > ...
>
>
>  Hi
>
> We found
>
> https://lkml.org/lkml/2020/4/30/1583
>
> Has cured our Out-Of-Memory kdump failures.
>
> From    Henry Willard
> Subject [PATCH] mm: Limit boost_watermark on small zones.
>
> I am currently not on linux-kernel@vger.kernel.org. dlist for all to see  this message so you may want to rebase and see if this cures your OoM issue and share the results.

This is a very interesting finding. Thanks a lot for sharing the same.
I am working on further avoiding OOM issues with arm64 kdump kernels.
I will experiment more with this patch and get back with more details.

Regards,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
