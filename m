Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMtJN-0007wB-R0
 for kexec@lists.infradead.org; Wed, 14 Nov 2018 11:26:23 +0000
Date: Wed, 14 Nov 2018 12:26:01 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181114112600.GD13926@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181114072926.13312-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Wed, Nov 14, 2018 at 03:29:25PM +0800, Lianbo Jiang wrote:
> When load the kernel image and initramfs by kexec_file_load syscall, it can
> not add exact e820 reserved type to kdump kernel e820 table.
> 
> Kdump uses walk_iomem_res_desc() to iterate io resources, then adds matched
> desc to e820 table for kdump kernel. But, when convert the e820 type into
> the iores descriptors, several e820 types are converted to 'IORES_DES_NONE'
> in this function e820_type_to_iores_desc(). So the walk_iomem_res_desc()
> will get these unnecessary types(E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE
> _KERN) when iterate io resources by the 'IORES_DES_NONE'.
> 
> It needs filter out these redundant type(such as E820_TYPE_RAM/E820_TYPE_
> UNUSABLE/E820_TYPE_KERN) in order to add exact e820 reserved type to kdump
> kernel e820 table. Thus it also needs an extra checking in memmap_entry_
> callback() to match the e820 type and resource name.

Ok, it took me a while to parse what this is trying to say so let's
start from the top:

* What resource type do you do need in the second kernel?

* The most important question: why?

* If it is the reserved resource, why aren't you adding
IORES_DESC_RESERVED or so which to look for instead of this hacky string
comparison?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
