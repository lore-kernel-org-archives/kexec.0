Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPUVG-0001lA-6W
 for kexec@lists.infradead.org; Mon, 05 Oct 2020 17:42:29 +0000
Received: by mail-oi1-f199.google.com with SMTP id z1so505004oid.0
 for <kexec@lists.infradead.org>; Mon, 05 Oct 2020 10:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <e9b1b5db-a848-468e-6baf-2f7b4d658805@oracle.com>
 <20201005170937.GA14576@gaia>
In-Reply-To: <20201005170937.GA14576@gaia>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 5 Oct 2020 23:12:10 +0530
Message-ID: <CACi5LpMWUmP1df8fB8psJY_cNGHF9MNn+TNK4B4edaRHvOXxGQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: wangkefeng.wang@huawei.com, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Chen Zhou <chenzhou10@huawei.com>, huawei.libin@huawei.com, guohanjun@huawei.com, Will Deacon <will@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>, RuiRui Yang <dyoung@redhat.com>, John Donnelly <john.p.donnelly@oracle.com>, Arnd Bergmann <arnd@arndb.de>, xiexiuqi@huawei.com, Simon Horman <horms@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, James Morse <james.morse@arm.com>, Prabhakar Kushwaha <prabhakar.pkin@gmail.com>, nsaenzjulienne@suse.de

Hi Catalin, Chen,

On Mon, Oct 5, 2020 at 10:39 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Sat, Sep 12, 2020 at 06:44:29AM -0500, John Donnelly wrote:
> > On 9/7/20 8:47 AM, Chen Zhou wrote:
> > > Chen Zhou (9):
> > >    x86: kdump: move CRASH_ALIGN to 2M
> > >    x86: kdump: make the lower bound of crash kernel reservation
> > >      consistent
> > >    x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
> > >      reserve_crashkernel[_low]()
> > >    x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
> > >    arm64: kdump: introduce some macroes for crash kernel reservation
> > >    arm64: kdump: reimplement crashkernel=X
> > >    kdump: add threshold for the required memory
> > >    arm64: kdump: add memory for devices by DT property
> > >      linux,usable-memory-range
> > >    kdump: update Documentation about crashkernel
> [...]
> > I did a brief unit-test on 5.9-rc4.
> >
> > Please add:
> >
> > Tested-by:  John Donnelly <John.p.donnelly@oracle.com>
>
> Thanks for testing.
>
> > This activity is over a year old. It needs accepted.
>
> It's getting there, hopefully in 5.11. There are some minor tweaks to
> address.

I think my earlier email with the test results on this series bounced
off the mailing list server (for some weird reason), but I still see
several issues with this patchset. I will add specific issues in the
review comments for each patch again, but overall, with a crashkernel
size of say 786M, I see the following issue:

# cat /proc/cmdline
BOOT_IMAGE=(hd7,gpt2)/vmlinuz-5.9.0-rc7+ root=<..snip..>
rd.lvm.lv=<..snip..> crashkernel=786M

I see two regions of size 786M and 256M reserved in low and high
regions respectively, So we reserve a total of 1042M of memory, which
is an incorrect behaviour:

# dmesg | grep -i crash
[    0.000000] Reserving 256MB of low memory at 2816MB for crashkernel
(System low RAM: 768MB)
[    0.000000] Reserving 786MB of memory at 654158MB for crashkernel
(System RAM: 130816MB)
[    0.000000] Kernel command line:
BOOT_IMAGE=(hd2,gpt2)/vmlinuz-5.9.0-rc7+
root=/dev/mapper/rhel_ampere--hr330a--03-root ro
rd.lvm.lv=rhel_ampere-hr330a-03/root
rd.lvm.lv=rhel_ampere-hr330a-03/swap crashkernel=786M cma=1024M

# cat /proc/iomem | grep -i crash
  b0000000-bfffffff : Crash kernel (low)
  bfcbe00000-bffcffffff : Crash kernel

IMO, we should test this feature more before including this in 5.11

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
