Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TCcZ8-0004UZ-Em
 for kexec@lists.infradead.org; Fri, 14 Sep 2012 20:32:43 +0000
Message-ID: <5053945F.9060107@hp.com>
Date: Fri, 14 Sep 2012 14:32:31 -0600
From: Khalid Aziz <khalid.aziz@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
 <5047DBA9.8030000@hp.com> <504815EB.9000701@redhat.com>
 <5048E40E.7040003@hp.com> <5049B6AD.9000304@redhat.com>
 <1347028634.20255.79.camel@lyra> <20120913133827.GB4396@redhat.com>
In-Reply-To: <20120913133827.GB4396@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, Dave Young <dyoung@redhat.com>

On 09/13/2012 07:38 AM, Vivek Goyal wrote:
> So what does this mean? Second kernel assumes the regular BIOS and tries
> to initialize that way? That sounds broken or is it just fine given
> the fact we are anyway not planning to call into any of the efi services.
> But what about memory maps, ACPI tables etc.

Hi Vivek,

My understanding on x86 side is not as clear as on ia64 side of kexec. 
 From my reading of the code, second kernel seems to assume a regular 
BIOS. It searches through EBDA or upper memory region E0000h-FFFFFh to 
find RSDP, if an RSDP pointer was not passed to the second kernel. This 
works on my EFI machine which also implements a BIOS compatibility 
layer. I wonder how it works on pure EFI machines. Do pure EFI machines 
not implement, say EBDA? If yes, acpi_find_root_pointer() should fail 
tofind RSDP.As for memory map, all I can find are reference to e820 
memory map which again assumes a BIOS but most EFI implementations I 
have come across implement a BIOS compatibility layer, so this will work 
still. I will look some more into this.

--
Khalid

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
