Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VkD3m-0005E9-T2
 for kexec@lists.infradead.org; Sat, 23 Nov 2013 13:15:43 +0000
Date: Sat, 23 Nov 2013 14:15:18 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [patch 5/9 v3] efi: export more efi table variable to sysfs
Message-ID: <20131123131518.GC24148@pd.tnic>
References: <20131121061704.363730447@dhcp-16-126.nay.redhat.com>
 <20131121061754.887381332@dhcp-16-126.nay.redhat.com>
 <20131121165742.GN26009@pd.tnic>
 <20131122024850.GC3874@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131122024850.GC3874@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Fri, Nov 22, 2013 at 10:48:50AM +0800, Dave Young wrote:
> > 	efi.config_table = (unsigned long)efi.systab->tables;
> > 	efi.fw_vendor	 = (unsigned long)efi.systab->fw_vendor;
> > 	efi.runtime	 = (unsigned long)efi.systab->runtime;
> 
> Hmm, UEFI spec mentions the them like below so I use the order:

I'm sure by now you know you should not really trust the UEFI spec, or
any other spec for that matter :)

> Several fields of the EFI System Table must be converted from
> physical pointers to virtual pointers using the ConvertPointer()
> service. These fields include FirmwareVendor, RuntimeServices,
> and ConfigurationTable.
> 
> But since you like the reverse I can change it in next version.

The reverse was simply a suggestion. The vertical alignment was more
what I aimed at because it makes this chunk much more readable IMO.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
