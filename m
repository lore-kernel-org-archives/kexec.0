Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 7 Oct 2020 17:24:53 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v12 9/9] kdump: update Documentation about crashkernel
Message-ID: <20201007162453.GR3462@gaia>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-10-chenzhou10@huawei.com>
 <20201005171936.GD14576@gaia>
 <8644712d-1331-1efc-1cd2-6da8640145b7@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8644712d-1331-1efc-1cd2-6da8640145b7@huawei.com>
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
To: chenzhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On Tue, Oct 06, 2020 at 10:10:54AM +0800, chenzhou wrote:
> On 2020/10/6 1:19, Catalin Marinas wrote:
> > On Mon, Sep 07, 2020 at 09:47:45PM +0800, Chen Zhou wrote:
> >> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> >> index 2da65fef2a1c..549611abc581 100644
> >> --- a/Documentation/admin-guide/kdump/kdump.rst
> >> +++ b/Documentation/admin-guide/kdump/kdump.rst
> > [...]
> >> @@ -316,8 +325,18 @@ Boot into System Kernel
> >>     kernel will automatically locate the crash kernel image within the
> >>     first 512MB of RAM if X is not given.
> >>  
> >> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> >> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> >> +   On arm64, use "crashkernel=X" to try low allocation in DMA zone, and
> >> +   fall back to high allocation if it fails. And go for high allocation
> >> +   directly if the required size is too large.
> >> +   We can also use "crashkernel=X,high" to select a high region above
> >> +   DMA zone, which also tries to allocate at least 256M low memory in
> >> +   DMA zone automatically.
> >> +   "crashkernel=Y,low" can be used to allocate specified size low memory
> >> +   in DMA zone.
> >> +   For non-RPi4 platforms, change DMA zone memtioned above to DMA32 zone.
> > I don't think we should mention non-RPi4 explicitly here. I don't even
> > understand what the suggestion is since the only way is to disable
> > ZONE_DMA in the kernel config. I'd just stick to ZONE_DMA description
> > here.
> How about like this:
> If the kernel config ZONE_DMA is disabled, just try low allocation in DMA32 zone
> and high allocation above DMA32 zone.

Something like: "allocate 256M low memory in the DMA zone automatically
(or the DMA32 zone if CONFIG_ZONE_DMA is disabled)".

I'd keep it short.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
