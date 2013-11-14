Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vgm7a-0002ag-KZ
 for kexec@lists.infradead.org; Thu, 14 Nov 2013 01:53:27 +0000
Date: Thu, 14 Nov 2013 09:52:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 6/7 v2] passing kexec necessary efi data via setup_data
Message-ID: <20131114015245.GE4081@dhcp-16-126.nay.redhat.com>
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082718.837997775@dhcp-16-126.nay.redhat.com>
 <20131113155032.GD17248@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131113155032.GD17248@console-pimps.org>
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
To: Matt Fleming <matt@console-pimps.org>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/13/13 at 03:50pm, Matt Fleming wrote:
> On Tue, 05 Nov, at 04:20:13PM, dyoung@redhat.com wrote:
> > Add a new setup_data type SETUP_EFI for kexec use.
> > Passing the saved fw_vendor, runtime, config tables and
> > efi runtime mappings.
> > 
> > When entering virtual mode, directly mapping the efi
> > runtime ragions which we passed in previously. And skip
> > the step to call SetVirtualAddressMap.
> > 
> > Specially for HP z420 workstation it need another variable
> > saving, it's the smbios physical address, the HP bios
> > also update the SMBIOS address after entering virtual mode
> > besides of the standard fw_vendor,runtime and config table.
>  
> Does that mean that on some of the platforms you tested the SMBIOS
> address isn't updated?

Yes, on my three test machines, lenovo, dell and HP, only the HP
machine need this that means the lenovo and dell machine does not
update the SMBIOS address to virt addr.

> 
> -- 
> Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
