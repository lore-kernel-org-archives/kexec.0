Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxrU4-0064As-MJ
 for kexec@lists.infradead.org; Thu, 16 Dec 2021 14:11:50 +0000
Date: Thu, 16 Dec 2021 22:11:15 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
Message-ID: <20211216141115.GA18773@MiWiFi-R3L-srv>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
 <YbntdtQo2jfbO4cO@zn.tnic> <20211216011040.GG3023@MiWiFi-R3L-srv>
 <YbsbO1XnrzLAIBEu@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbsbO1XnrzLAIBEu@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>, Zhen Lei <thunder.leizhen@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

On 12/16/21 at 11:55am, Borislav Petkov wrote:
> On Thu, Dec 16, 2021 at 09:10:40AM +0800, Baoquan He wrote:
> > reserve_crashkernel_low() always return 0 on x86_32, so the not equivalent
> > transformation for x86_32 doesn't matter, I think.
> 
> That is, of course, very obvious... not!
> 
> Why is that function parsing crashkernel=XM, and crashkernel=X,high,
> then it attempts some low memory reservation too? Why isn't
> crashkernel=Y,low parsed there too?
> 
> I guess this alludes to why:
> 
>         crashkernel=size[KMG],low
>                         [KNL, X86-64] range under 4G. When crashkernel=X,high
>                         is passed, kernel could allocate physical memory region
>                         above 4G, that cause second kernel crash on system
>                         that require some amount of low memory, e.g. swiotlb
>                         requires at least 64M+32K low memory, also enough extra
>                         low memory is needed to make sure DMA buffers for 32-bit
>                         devices won't run out.
> 
> So, before this is going anywhere, I'd like to see this function
> documented properly. I see Documentation/admin-guide/kdump/kdump.rst
> explains the crashkernel= options too so you can refer to it in the
> comments so that when someone looks at that code, someone can follow why
> it is doing what it is doing.
> 
> Then, as a future work, all that parsing of crashkernel= cmdline options
> should be concentrated at the beginning and once it is clear what the
> user requests, the reservations should be done.

Totally agree we should refactor code to make reserve_crashkernel()
clearer on logic and readibility. In this patchset, we can rewrite the
kernel-doc of reserve_crashkernel() to add more words to explain. As for
the code refactoring, it can be done in another patchset.

> 
> As it is, reserve_crashkernel() is pretty unwieldy and hard to read.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
