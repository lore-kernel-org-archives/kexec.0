Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjzKZ-0003Wu-7Q
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 22:36:07 +0000
Message-ID: <1385159448.1791.161.camel@misato.fc.hp.com>
Subject: Re: [patch 0/4 v3] kexec-tools: efi runtime support
From: Toshi Kani <toshi.kani@hp.com>
Date: Fri, 22 Nov 2013 15:30:48 -0700
In-Reply-To: <20131121064043.969000753@dhcp-16-126.nay.redhat.com>
References: <20131121064043.969000753@dhcp-16-126.nay.redhat.com>
Mime-Version: 1.0
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Thu, 2013-11-21 at 14:40 +0800, dyoung@redhat.com wrote:
> Hi,
> 
> This is the v3 patchset for adding efi runtime support on kexec kernel
> kernel patches was sent a while ago, not yet updated in archive. 
> 
> in kexec-tools, this patchset will do below:
> 1. retrieve efi_info from sysfs boot_params, and fill the
> x86 setup header. If kernel does not export sysfs boot_params,
> still try to find them in debugfs.
> 
> 2. collect data efi runtime needed:
> /sys/firmware/efi/systab: smbios
> /sys/firmware/efi/fw_vendor
> /sys/firmware/efi/runtime
> /sys/firmware/efi/config_table
> 
> /sys/firmware/efi/runtime-map/*, the phys-virt mappings in 1st kernel
> 
> 3. assemble setup_data based on data get in 2) then pass it to 2nd kernel
> 
> Tested on OVMF, dell laptop, lenovo laptop and HP workstation

Tested on an HP EFI-based 60-way server (prototype).  For the series:

Tested-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
