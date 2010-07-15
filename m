Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gpfs3.symplicity.com ([66.151.109.81] helo=mail.symplicity.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OZQTU-00082o-GX
	for kexec@lists.infradead.org; Thu, 15 Jul 2010 15:35:52 +0000
Received: from [10.120.101.106] (unknown [10.120.101.106])
	by mail.symplicity.com (Postfix) with ESMTPSA id 1CDC2D7060A
	for <kexec@lists.infradead.org>; Thu, 15 Jul 2010 11:35:44 -0400 (EDT)
Message-ID: <4C3F2ACF.60601@symplicity.com>
Date: Thu, 15 Jul 2010 11:35:43 -0400
From: Richard Genthner <rgenthner@symplicity.com>
MIME-Version: 1.0
Subject: Re: Kexec Reboot Network Issue
References: <4C3EF80B.1040400@symplicity.com>
	<20100715142003.GB19856@verge.net.au>
In-Reply-To: <20100715142003.GB19856@verge.net.au>
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
To: kexec@lists.infradead.org

I would try a different kenerl but our cluster fs has us locked to this 
kernel until we finish the upgrade to the new cluster fs version. heres 
ethtool on the iface

from lshw
*-network
                 description: Ethernet interface
                 product: NetXtreme BCM5721 Gigabit Ethernet PCI Express
                 vendor: Broadcom Corporation
                 physical id: 0
                 bus info: pci@0000:03:00.0
                 logical name: eth0
                 version: 21
                 serial: 00:25:64:3b:9c:ae
                 size: 1GB/s
                 capacity: 1GB/s
                 width: 64 bits
                 clock: 33MHz
                 capabilities: pm vpd msi pciexpress bus_master cap_list 
ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd 
autonegotiation
                 configuration: autonegotiation=on broadcast=yes 
driver=tg3 driverversion=3.93 duplex=full firmware=5721-v3.65, ASFIPMI 
v6.25 ip=172.16.1.123 latency=0 link=yes module=tg3 multicast=yes 
port=twisted pair speed=1GB/s


On 07/15/2010 10:20 AM, Simon Horman wrote:
> On Thu, Jul 15, 2010 at 07:59:07AM -0400, Richard Genthner wrote:
>    
>> I'm currently using the following string:
>>
>> kexex --type=elf-x86_64 --args-linux -l /boot/vmlinuz-2.6.18-12.el5
>> --initrid=/boot/initrd-2.6.18-128.el6.img --append="`cat
>> /proc/cmdline`"
>> kexec -e
>>
>> Some times we can get to the box from any subnet, other times we can
>> only get to the box from the same subnet only. Our solution to this
>> is to down the iface and then restart networking. Has anyone else
>> run into this issue?
>>      
> Hi Richard,
>
> could you be more specific about which NIC you are using?
> And is it at all possible to test a newer kernel version?
>
> What I suspect is happening is that the NIC is getting into an unknown
> state. And what I'm hoping is that is a problem thats already been
> addressed.
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>
>    

-- 
Richard Genthner
Systems Administration
Symplicity
ph. 703-351-0200 x8051



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
