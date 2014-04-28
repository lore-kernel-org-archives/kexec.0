Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Weld7-0003pW-Dd
 for kexec@lists.infradead.org; Mon, 28 Apr 2014 13:29:57 +0000
Date: Mon, 28 Apr 2014 21:29:34 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH] kdump: pass e820 reserved region to 2nd kernel via e820
 table or setup_data
Message-ID: <20140428132933.GB1400@dhcp-17-89.nay.redhat.com>
References: <1398669704-31851-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398669704-31851-1-git-send-email-chaowang@redhat.com>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, cpw@sgi.com

On 04/28/14 at 03:21pm, WANG Chao wrote:
> e820 reserved region could be useful in 2nd kernel.
> 
> For example, PCI mmconf (extended mode) requires reserved region
> otherwise it falls back to legacy mode. The following log is from Cliff
> Wickman <cpw@sgi.com>:
> 
>  PCI: MMCONFIG for domain 1003 [bus 3f-3f] at [mem 0xff0ff00000-0xff0fffffff] (base 0xff0c000000)
>  [Firmware Bug]: PCI: MMCONFIG at [mem 0x80000000-0x80cfffff] not reserved in ACPI motherboard resources
>  PCI: not using MMCONFIG
> 
> PCI devices on segment 1 (>0) can't fall back to legacy mode, thus
> kernel probing fails and device can't be found.
> 
> We don't pass reserved region because these regions could be too much
> and eat up our very limited kernel command line resource in
> memmap=exactmap case.
> 
> However now we use e820 map and setup_data to pass memory map to 2nd
> kernel and the number of reserved regions should not be a problem any
> more.
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> ---
>  kexec/arch/i386/crashdump-x86.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 4a1491b..321ed3d 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -300,6 +300,9 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  			type = RANGE_ACPI;
>  		} else if(memcmp(str,"ACPI Non-volatile Storage\n",26) == 0 ) {
>  			type = RANGE_ACPI_NVS;
> +		} else if(memcmp(str,"reserved\n",9) == 0 ) {
> +			type = RANGE_RANGE;

This is wrong. I've resend the correct one.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
