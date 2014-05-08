Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WiEbs-0006kX-Sa
 for kexec@lists.infradead.org; Thu, 08 May 2014 03:03:01 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
 (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4832cnt006366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Wed, 7 May 2014 23:02:39 -0400
Date: Thu, 8 May 2014 11:04:08 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: Why do we pass memory map both in e820 and efi_info
Message-ID: <20140508030408.GC3320@darkstar.nay.redhat.com>
References: <20140507175858.GD21048@redhat.com>
 <20140508022450.GA3320@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140508022450.GA3320@darkstar.nay.redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>

On 05/08/14 at 10:24am, Dave Young wrote:
> On 05/07/14 at 01:58pm, Vivek Goyal wrote:
> > Hi Dave/Chao,
> > 
> > I am going through kexec-tools code and it looks like that for EFI
> > systems, we pass memory map entries both in bootparams e820 memory map
> > as well as efi_info. I am wondering why that's the case?
> 
> Most UEFI firmware have a CSM (Compatibility Support Module) that could
> have provided a suitable E820-style memory map to the kernel. 
> Linux kernel use E820 always either for legacy bios boot or UEFI boot.

BTW, For the machine without CSM, boot loader can convert EFI mem ranges to
E820 then pass to kernel since linux kernel need E820.

> 
> For the machine firmware which does not provide E820 interface user can
> specify 'add_efi_memmap' kernel cmdline thus kernel can add efi memmaps
> to E820 array.
> 
> For the efi memmap in efi_info, it's necessary for efi boot because
> efi initialization will use it. UEFI has a lot of mem types, E820 only
> have several RAM,RESERVED, ACPI, etc.  efi_init need the special UEFI
> specific mem ranges ie. for boot services, runtime services etc. I believe
> the UEFI specific mem ranges could be contained in the RESERVED E820 ranges
> though I did not verify it.
> 
> > 
> > IOW, I am also trying to figure out as a bootloader, when should we
> > pass memmap in e820 and when should it be passed in efi_info.
> 
> E820 is mandatory usually. efi_info only for UEFI boot.
> 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
