Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljXj6-00FsvI-1Y
 for kexec@lists.infradead.org; Thu, 20 May 2021 01:43:53 +0000
Date: Thu, 20 May 2021 09:43:37 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: i386 kexec-tools for x86_64 kdump kernels
Message-ID: <20210520014337.GA10223@dhcp-128-65.nay.redhat.com>
References: <YKNFQnJ5JbqQ/OqI@chmeee>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YKNFQnJ5JbqQ/OqI@chmeee>
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
To: Kevin Mitchell <kevmitch@arista.com>
Cc: kexec@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org

Hi Kevin,
On 05/17/21 at 09:40pm, Kevin Mitchell wrote:
> Hi,
> 
> As a space-saving strategy for our embedded boot environment, we use an i386
> kexec binary to load our x86_64 kdump kernel from an x86_64 system kernel. This
> worked great up until linux-5.2, which included the commit
> 
> 9ca5c8e632ce ("x86/kdump: Have crashkernel=X reserve under 4G by
> default")
> 
> Sure enough, according to /proc/iomem, the "Crash kernel" area went from
> starting at 0x34000000 to 0x7b000000, which is above the 896M
> limit. Unfortunately, since i386 kexec seems to use
> kexec/arch/i386/kexec-bzImage.c even to load an x86_64 kernel, the
> DEFAULT_BZIMAGE_ADDR_MAX = 0x37FFFFFF 896M limit is still enforced when loading
> the panic kernel:
> 
> # kexec32 --load-panic bzImage64
> Could not find a free area of memory of 0x8000 bytes...
> locate_hole failed
> 
> I can work around this by patching kexec-tools to raise that limit to
> DEFAULT_BZIMAGE_ADDR_MAX = 0xFFFFFFFF which allows loading the x86_64 kdump
> bzImage. This does in fact kexec fine from that position if I trigger a panic.
> 
> However, this doesn't appear to be a general solution since the 896M does still
> apply if either of the kernels is i386. In that case, attempting to kexec from
> the higher address will just hang with no console output. In this case, it
> probably is better to continue to fail to load the kdump image rather than wait
> until the panic to find out something is wrong.

I'm not sure if you can try to detect the kernel type and special case
this in kexec-tools, eg. if the 2nd kernel is 64-bit kernel then just
bump the addr max otherwise go original logic.  If this is doable then
it would be a good way IMO.

See if Eric, Baoquan and other X86 people have more idea.

> 
> Fortunately, while 9ca5c8e632ce allows an i386 kernel to reserve a "Crash
> kernel" region > 896M, it doesn't actually do that by default - I have to force
> it to go there with crashkernel=@. I am not sure if this is just a fluke or if
> there is something actually ensuring it defaults to a working
> location. Nevertheless, it appears the restriction removed by this commit is
> still required by i386 kernels. Its enforcement has just moved to userspace.
> 
> So it seems that the largest fallout of the commit is restricted to the
> admittedly niche combination linux-x86_64 -> kexec-i386 -> linux-x86_64(kdump),
> which no longer works out of the box without pinning the crashkernel address or
> patching kexec.
> 
> Is this just something we need to live with or is it worth looking into how to
> better support this combination?

This is the case I missed, but I would think it as not a common use
case. It would be better to leave it as is in kernel and try to fix in
kexec-tools or just use the workaround.

> 
> Thanks,
> Kevin
> 

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
