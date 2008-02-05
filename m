Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.18.163])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JMGRQ-0002yr-UF
	for kexec@lists.infradead.org; Tue, 05 Feb 2008 05:34:04 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m155Y8lG031521
	for <kexec@lists.infradead.org>; Tue, 5 Feb 2008 16:34:08 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m155Xq1r3354834
	for <kexec@lists.infradead.org>; Tue, 5 Feb 2008 16:33:52 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m155XsMi021258
	for <kexec@lists.infradead.org>; Tue, 5 Feb 2008 16:33:54 +1100
Message-ID: <47A7F53C.8090606@in.ibm.com>
Date: Tue, 05 Feb 2008 11:03:48 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [mm] Crashkernel memory reservation fails with 2.6.24-rc8-mm1
References: <47A7391F.2020408@in.ibm.com> <20080204183810.GE16021@redhat.com>
	<20080204193524.GA11104@suse.de>
In-Reply-To: <20080204193524.GA11104@suse.de>
Content-Type: multipart/mixed; boundary="------------040902040104010200030102"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, bwalle@suse.de
Cc: kexec@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040902040104010200030102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bernhard Walle wrote:
> * Vivek Goyal <vgoyal@redhat.com> [2008-02-04 19:38]:
>   
>> Bernahard, any idea who is the competitor here?
>>     
> Hm ..., can you boot the kernel without crashkernel= and provide the
> /proc/iomem?
>   
Attached is the /proc/iomem output with and without crashkernel
parameter.

Adding debug gives this extra information.

hm, page 02a9d000 reserved twice.
crashkernel reservation failed - memory is in use

Will try to add more debug statements.

Thanks
-Sachin



--------------040902040104010200030102
Content-Type: text/plain;
 name="iomem_with_crashkernel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iomem_with_crashkernel"

00000000-0009dbff : System RAM
0009dc00-0009ffff : reserved
000e0000-000fffff : reserved
00100000-c7fcadff : System RAM
  00200000-004780d6 : Kernel code
  004780d7-0059e867 : Kernel data
  008a2000-009969ab : Kernel bss
c7fcae00-c7fcf7ff : ACPI Tables
c7fcf800-c7ffffff : reserved
c8000000-c9ffffff : PCI Bus #07
  c9ff0000-c9ffffff : 0000:07:00.0
    c9ff0000-c9ffffff : tg3
ca000000-cbbfffff : PCI Bus #06
  cbbf0000-cbbfffff : 0000:06:00.0
    cbbf0000-cbbfffff : tg3
cbc00000-cdafffff : PCI Bus #02
  cbc00000-cbffffff : PCI Bus #04
  cc000000-cdafffff : PCI Bus #03
cdb00000-cfffffff : PCI Bus #02
  cdb00000-cdefffff : PCI Bus #04
  cdfff000-cdffffff : 0000:02:00.2
    cdfff000-cdfff027 : shpchp
  ce000000-cfffffff : PCI Bus #03
    cfffc000-cfffdfff : 0000:03:07.1
      cfffc000-cfffcfff : aic79xx
    cfffe000-cfffffff : 0000:03:07.0
      cfffe000-cfffefff : aic79xx
d0000000-ddffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:06.0
de000000-dfffffff : PCI Bus #01
  dfff0000-dfffffff : 0000:01:06.0
e0000000-efffffff : PCI MMCONFIG 0
f0000000-f00003ff : 0000:00:1d.7
  f0000000-f00003ff : ehci_hcd
f0000400-f00007ff : 0000:00:1f.1
fec00000-fec00fff : IOAPIC 0
fec80000-fec80fff : IOAPIC 1
fed20800-fed208ff : pnp 00:0e
fed30800-fed308ff : pnp 00:0e
fee00000-fee00fff : Local APIC
ff000000-ff000fff : 0000:00:00.0
  ff000000-ff000fff : pnp 00:0e
fff00000-ffffffff : pnp 00:0e
100000000-237ffffff : System RAM

--------------040902040104010200030102
Content-Type: text/plain;
 name="iomem_without_crashkernel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iomem_without_crashkernel"

00000000-0009dbff : System RAM
0009dc00-0009ffff : reserved
000e0000-000fffff : reserved
00100000-c7fcadff : System RAM
  00200000-004780d6 : Kernel code
  004780d7-0059e867 : Kernel data
  008a2000-009969ab : Kernel bss
c7fcae00-c7fcf7ff : ACPI Tables
c7fcf800-c7ffffff : reserved
c8000000-c9ffffff : PCI Bus #07
  c9ff0000-c9ffffff : 0000:07:00.0
    c9ff0000-c9ffffff : tg3
ca000000-cbbfffff : PCI Bus #06
  cbbf0000-cbbfffff : 0000:06:00.0
    cbbf0000-cbbfffff : tg3
cbc00000-cdafffff : PCI Bus #02
  cbc00000-cbffffff : PCI Bus #04
  cc000000-cdafffff : PCI Bus #03
cdb00000-cfffffff : PCI Bus #02
  cdb00000-cdefffff : PCI Bus #04
  cdfff000-cdffffff : 0000:02:00.2
    cdfff000-cdfff027 : shpchp
  ce000000-cfffffff : PCI Bus #03
    cfffc000-cfffdfff : 0000:03:07.1
      cfffc000-cfffcfff : aic79xx
    cfffe000-cfffffff : 0000:03:07.0
      cfffe000-cfffefff : aic79xx
d0000000-ddffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:06.0
de000000-dfffffff : PCI Bus #01
  dfff0000-dfffffff : 0000:01:06.0
e0000000-efffffff : PCI MMCONFIG 0
f0000000-f00003ff : 0000:00:1d.7
  f0000000-f00003ff : ehci_hcd
f0000400-f00007ff : 0000:00:1f.1
fec00000-fec00fff : IOAPIC 0
fec80000-fec80fff : IOAPIC 1
fed20800-fed208ff : pnp 00:0e
fed30800-fed308ff : pnp 00:0e
fee00000-fee00fff : Local APIC
ff000000-ff000fff : 0000:00:00.0
  ff000000-ff000fff : pnp 00:0e
fff00000-ffffffff : pnp 00:0e
100000000-237ffffff : System RAM

--------------040902040104010200030102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------040902040104010200030102--

