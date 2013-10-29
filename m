Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vb1xQ-0004Bh-L7
 for kexec@lists.infradead.org; Tue, 29 Oct 2013 05:35:13 +0000
Date: Tue, 29 Oct 2013 13:34:27 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 5/6] export efi runtime memory mapping to sysfs
Message-ID: <20131029053427.GH5185@dhcp-16-126.nay.redhat.com>
References: <20131027034713.481920209@dhcp-16-126.nay.redhat.com>
 <20131027035923.442470867@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131027035923.442470867@dhcp-16-126.nay.redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, vgoyal@redhat.com

On 10/27/13 at 11:47am, Dave Young wrote:
> kexec kernel will need exactly same mapping for
> efi runtime memory ranges. Thus here export the
> runtime ranges mapping to sysfs, kexec-tools
> will assemble them and pass to 2nd kernel via
> setup_data.
> 
> Introducing a new directly /sys/firmware/efi/efi-runtime-map
> Just like /sys/firmware/memmap. Containing below attribute
> in each file of that directory:
> attribute  num_pages  phys_addr  type  virt_addr
> 
> It will not work for efi 32bit. Only x86_64 currently.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/include/asm/efi.h             |    3 
>  arch/x86/platform/efi/efi.c            |   11 ++
>  drivers/firmware/efi/Kconfig           |   10 +
>  drivers/firmware/efi/Makefile          |    1 
>  drivers/firmware/efi/efi-runtime-map.c |  166 +++++++++++++++++++++++++++++++++
>  drivers/firmware/efi/efi.c             |    3 
>  6 files changed, 193 insertions(+), 1 deletion(-)

Remind myself: add below to Documentaion in next version:
Documentation/ABI/testing/sysfs-efi-runtime-map

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
