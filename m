Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgciS-0004EH-9r
 for kexec@lists.infradead.org; Wed, 13 Nov 2013 15:50:52 +0000
Date: Wed, 13 Nov 2013 15:50:32 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch 6/7 v2] passing kexec necessary efi data via setup_data
Message-ID: <20131113155032.GD17248@console-pimps.org>
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082718.837997775@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131105082718.837997775@dhcp-16-126.nay.redhat.com>
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
To: dyoung@redhat.com
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Tue, 05 Nov, at 04:20:13PM, dyoung@redhat.com wrote:
> Add a new setup_data type SETUP_EFI for kexec use.
> Passing the saved fw_vendor, runtime, config tables and
> efi runtime mappings.
> 
> When entering virtual mode, directly mapping the efi
> runtime ragions which we passed in previously. And skip
> the step to call SetVirtualAddressMap.
> 
> Specially for HP z420 workstation it need another variable
> saving, it's the smbios physical address, the HP bios
> also update the SMBIOS address after entering virtual mode
> besides of the standard fw_vendor,runtime and config table.
 
Does that mean that on some of the platforms you tested the SMBIOS
address isn't updated?

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
