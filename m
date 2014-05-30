Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WqFM3-0006MQ-A6
 for kexec@lists.infradead.org; Fri, 30 May 2014 05:27:47 +0000
Date: Fri, 30 May 2014 14:27:24 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH kexec-tools] kdump: pass acpi_rsdp to 2nd kernel if
 kernel does not export efi runtime maps
Message-ID: <20140530052724.GG6561@verge.net.au>
References: <20140530032452.GA30043@dhcp-16-198.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140530032452.GA30043@dhcp-16-198.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, vgoyal@redhat.com

On Fri, May 30, 2014 at 11:24:52AM +0800, Dave Young wrote:
> 
> If kernel does not export efi runtime maps it means 1:1 mapping does not
> work or user explictly boot with efi=old_map. In this case efi setup code
> will failback to noefi boot, but for kdump case we still need pass extra
> acpi_rsdp cmdline.
> 
> Thus adding a check in kdump path.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
