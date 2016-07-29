Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bSyaJ-0007xr-Lr
 for kexec@lists.infradead.org; Fri, 29 Jul 2016 03:35:40 +0000
Received: by mail-pf0-f172.google.com with SMTP id y134so28139499pfg.0
 for <kexec@lists.infradead.org>; Thu, 28 Jul 2016 20:35:18 -0700 (PDT)
Date: Fri, 29 Jul 2016 09:05:14 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v2 4/4] arm64: Add support for binary image files
Message-ID: <20160729033514.GC27150@localhost.localdomain>
References: <cover.1469559530.git.geoff@infradead.org>
 <f352dcfc827a4cbb3878dd1043877a4154b1bd08.1469559530.git.geoff@infradead.org>
 <20160728040125.GA27150@localhost.localdomain>
 <1469729083.16559.26.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1469729083.16559.26.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Geoff,

On 28/07/2016:11:04:43 AM, Geoff Levand wrote:
> Hi Pratyush,
> 
> On Thu, 2016-07-28 at 09:31 +0530, Pratyush Anand wrote:
> > On 26/07/2016:08:18:57 PM, Geoff Levand wrote:
> 
> > You removed page_offset calculation in rework.
> > I am unable to understand that how arm64_mem.page_offset will be filled up now
> > for binary image case.
> > 
> > I think, we still need to keep page_offset user input. 
> 
> The current kernel linker scripts are setup to output virtual
> address values to the vmlinux elf file.  
> 
> To load the elf sections of vmlinux using the provided elf
> file loader, elf_exec_load(), we need to convert those elf
> header values to physical addresses since we work with
> physical addresses in the kernel's kimage structure.
> 
> That conversion is 
> 
>   p = v - page_offset + phys_offset;
> 
> We get phys_offset from the memory ranges, and we calculate
> page_offset from the elf header info.
> 
> As for the binary image file, we load that with
> add_segment_phys_virt(), which can put the binary data of the
> Image file into memory at a physical address we specify:
> 
>   image_base = phys_offset + text_offset.
> 
> phys_offset is again from the memory ranges, and text_offset
> from the arm64 image header.
> 
> 
> > You may take following
> > two patches which does this, or you may leave binary image support patch which I
> > will send after your patches are merged.
> > 
> > https://github.com/pratyushanand/kexec-tools/commit/5b7e49a75d1d6cd4ac846f50ff10275fd54cb545
> 
> This one may be useful, for debugging if anything.
> 
> > https://github.com/pratyushanand/kexec-tools/commit/a0ce0ce673755c4061c1f081170a3a75dfa1d1fb
> 
> We do not need, nor want, a PAGE_OFFSET option.

See kexec/crashdump-elf.c:FUNC()
We have:
223                 phdr->p_vaddr = phys_to_virt(elf_info, mstart);

Now, if we do not have page_offset then we will not have correct p_vaddr, and
then vmcore-dmesg/vmcore-dmesg.c:vaddr_to_offset() fails with

No program header covering vaddr 0xfffffc0008c312f0found kexec bug?

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
