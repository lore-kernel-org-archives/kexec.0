Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9iyK-0005eY-9G
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 20:46:45 +0000
Date: Thu, 6 Sep 2012 16:46:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
Message-ID: <20120906204642.GE27209@redhat.com>
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
 <20120905131852.GB19749@redhat.com> <5048114F.4050108@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5048114F.4050108@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On Thu, Sep 06, 2012 at 10:58:23AM +0800, Dave Young wrote:

[..]
> > Also, what's the corelation of efi and acpi_rsdp. Is acpi_rsdp required
> > only on EFI boot or in general it is required? If it is required in 
> > general, why kdump works currently.
> 
> 
> Hi, here is the background of this issue:
> http://lists.infradead.org/pipermail/kexec/2010-March/003889.html

Ok, looks like this is EFI specific. So keeping noefi and acpi_rsdp
together makes sense.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
