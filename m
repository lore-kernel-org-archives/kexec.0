Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aNmfG-0002Gu-H8
 for kexec@lists.infradead.org; Mon, 25 Jan 2016 19:19:05 +0000
Date: Mon, 25 Jan 2016 20:18:04 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 00/17] Enhance iomem search interfaces and support
 EINJ to NVDIMM
Message-ID: <20160125191804.GE14030@pd.tnic>
References: <1452020068-26492-1-git-send-email-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1452020068-26492-1-git-send-email-toshi.kani@hpe.com>
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
To: Toshi Kani <toshi.kani@hpe.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, torvalds@linux-foundation.org, rafael.j.wysocki@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-samsung-soc@vger.kernel.org, xen-devel@lists.xenproject.org, akpm@linux-foundation.org, dyoung@redhat.com, dan.j.williams@intel.com, linux-nvdimm@lists.01.org

On Tue, Jan 05, 2016 at 11:54:28AM -0700, Toshi Kani wrote:
> This patch-set enhances the iomem table and its search interfacs, and
> then changes EINJ to support NVDIMM.
> 
>  - Patches 1-2 add a new System RAM type, IORESOURCE_SYSTEM_RAM, and
>    make the iomem search interfaces work with resource flags with
>    modifier bits set.  IORESOURCE_SYSTEM_RAM has IORESOURCE_MEM bit set
>    for backward compatibility.
> 
>  - Patch 3 adds a new field, I/O resource descriptor, into struct resource.
>    Drivers can assign their unique descritor to a range when they support
>    the iomem search interfaces.
> 
>  - Patches 4-9 changes initializations of resource entries.  They set
>    the System RAM type to System RAM ranges, set I/O resource descriptors
>    to the regions targeted by the iomem search interfaces, and change
>    to call kzalloc() where kmalloc() is used to allocate struct resource
>    ranges.
> 
>  - Patches 10-14 extend the iomem interfaces to check System RAM ranges
>    with the System RAM type and the I/O resource descriptor.
> 
>  - Patch 15-16 remove deprecated walk_iomem_res().
> 
>  - Patch 17 changes the EINJ driver to allow injecting a memory error
>    to NVDIMM.

Ok, all applied ontop of 4.5-rc1.

You could take a look if everything's still fine and I haven't botched
anything:

http://git.kernel.org/cgit/linux/kernel/git/bp/bp.git/log/?h=tip-mm

I'll let the build bot chew on it and then test it here and send it out
again to everyone on CC so that people don't act surprised.

Thanks for this cleanup, code looks much better now!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
