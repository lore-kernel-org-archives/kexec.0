Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fxRax-0003d0-H4
 for kexec@lists.infradead.org; Wed, 05 Sep 2018 06:47:20 +0000
Date: Wed, 5 Sep 2018 14:46:58 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 2/5 V6] x86/ioremap: strengthen the logic in
 early_memremap_pgprot_adjust() to adjust encryption mask
Message-ID: <20180905064658.GA10310@dhcp-128-65.nay.redhat.com>
References: <20180831081930.31561-1-lijiang@redhat.com>
 <20180831081930.31561-3-lijiang@redhat.com>
 <20180903024512.GA2568@dhcp-128-65.nay.redhat.com>
 <d2229538-51d5-ead7-c7e5-f4afe5b53693@redhat.com>
 <20180904004417.GA9842@dhcp-128-65.nay.redhat.com>
 <20180904012902.GB9842@dhcp-128-65.nay.redhat.com>
 <20180904015131.GA10877@dhcp-128-65.nay.redhat.com>
 <3a9ae246-0c3a-753a-41e2-f2788a882c50@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a9ae246-0c3a-753a-41e2-f2788a882c50@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, linux-efi <linux-efi@vger.kernel.org>, bhe@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de

[snip]
> 
> As previously mentioned, there are also many differences between kexec and kdump. In general,
> kexec needs to look at all of available physical memory, but kdump doesn't need.
> 
> For kexec, kexec-tools will read /sys/firmware/memmap and recreate the e820 ranges for the 2nd
> kernel. If it fails, will use /proc/iomem.
> 
> For kdump, kexec-tools will read /proc/iomem and recreate the e820 ranges for kdump kernel.
> BTW: we can not get the range of persistent memory from /proc/iomem. So e820 ranges don't contain
> the persistent memory in kdump kernel, this is the real reason why i need to strengthen the logic
> of adjusting memory encryption mask.

"persistent memory" is different, I think you meant about some reserved
memory instead

> 
> If kexec-tools also use /sys/firmware/memmap for kdump(like kexec), kdump kernel can also work
> without a fix, but the kexec-tools will have to be modified. Are you sure that you want me to
> fix kexec-tools instead of kernel?

Yes, please fix kexec-tools to pass reserved ranges in e820, you will
not need this patch then.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
