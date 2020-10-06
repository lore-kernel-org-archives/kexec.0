Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 6 Oct 2020 19:00:12 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64
 kdump
Message-ID: <20201006180012.GB31946@C02TF0J2HF1T.local>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <e9b1b5db-a848-468e-6baf-2f7b4d658805@oracle.com>
 <20201005170937.GA14576@gaia>
 <CACi5LpMWUmP1df8fB8psJY_cNGHF9MNn+TNK4B4edaRHvOXxGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpMWUmP1df8fB8psJY_cNGHF9MNn+TNK4B4edaRHvOXxGQ@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: wangkefeng.wang@huawei.com, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Chen Zhou <chenzhou10@huawei.com>, huawei.libin@huawei.com, guohanjun@huawei.com, Will Deacon <will@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>, RuiRui Yang <dyoung@redhat.com>, John Donnelly <john.p.donnelly@oracle.com>, Arnd Bergmann <arnd@arndb.de>, xiexiuqi@huawei.com, Simon Horman <horms@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, James Morse <james.morse@arm.com>, Prabhakar Kushwaha <prabhakar.pkin@gmail.com>, nsaenzjulienne@suse.de

On Mon, Oct 05, 2020 at 11:12:10PM +0530, Bhupesh Sharma wrote:
> I think my earlier email with the test results on this series bounced
> off the mailing list server (for some weird reason), but I still see
> several issues with this patchset. I will add specific issues in the
> review comments for each patch again, but overall, with a crashkernel
> size of say 786M, I see the following issue:
> 
> # cat /proc/cmdline
> BOOT_IMAGE=(hd7,gpt2)/vmlinuz-5.9.0-rc7+ root=<..snip..> rd.lvm.lv=<..snip..> crashkernel=786M
> 
> I see two regions of size 786M and 256M reserved in low and high
> regions respectively, So we reserve a total of 1042M of memory, which
> is an incorrect behaviour:
> 
> # dmesg | grep -i crash
> [    0.000000] Reserving 256MB of low memory at 2816MB for crashkernel (System low RAM: 768MB)
> [    0.000000] Reserving 786MB of memory at 654158MB for crashkernel (System RAM: 130816MB)
> [    0.000000] Kernel command line: BOOT_IMAGE=(hd2,gpt2)/vmlinuz-5.9.0-rc7+ root=/dev/mapper/rhel_ampere--hr330a--03-root ro rd.lvm.lv=rhel_ampere-hr330a-03/root rd.lvm.lv=rhel_ampere-hr330a-03/swap crashkernel=786M cma=1024M
> 
> # cat /proc/iomem | grep -i crash
>   b0000000-bfffffff : Crash kernel (low)
>   bfcbe00000-bffcffffff : Crash kernel

As Chen said, that's the intended behaviour and how x86 works. The
requested 768M goes in the high range if there's not enough low memory
and an additional buffer for swiotlb is allocated, hence the low 256M.

We could (as an additional patch), subtract the 256M from the high
allocation so that you'd get a low 256M and a high 512M, not sure it's
worth it. Note that with a "crashkernel=768M,high" option, you still get
the additional low 256M, otherwise the crashkernel won't be able to
boot as there's no memory in ZONE_DMA. In the explicit ",high" request
case, I'm not sure subtracted the 256M is more intuitive.

In 5.11, we also hope to fix the ZONE_DMA layout for non-RPi4 platforms
to cover the entire 32-bit address space (i.e. identical to the current
ZONE_DMA32).

> IMO, we should test this feature more before including this in 5.11

Definitely. That's one of the reasons we haven't queued it yet. So any
help with testing here is appreciated.

Thanks.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
