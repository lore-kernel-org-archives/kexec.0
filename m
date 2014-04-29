Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WexLC-0000ee-M6
 for kexec@lists.infradead.org; Tue, 29 Apr 2014 02:00:15 +0000
Date: Tue, 29 Apr 2014 10:59:52 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH RESEND] kdump: pass e820 reserved region to 2nd kernel
 via e820 table or setup_data
Message-ID: <20140429015952.GB454@verge.net.au>
References: <1398669704-31851-1-git-send-email-chaowang@redhat.com>
 <1398691571-19609-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398691571-19609-1-git-send-email-chaowang@redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, cpw@sgi.com

On Mon, Apr 28, 2014 at 09:26:11PM +0800, WANG Chao wrote:
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

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
