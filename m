Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-la0-x22a.google.com ([2a00:1450:4010:c03::22a])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG9Q1-0001gX-6P
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 14:46:14 +0000
Received: by mail-la0-f42.google.com with SMTP id fe20so2577849lab.15
 for <kexec@lists.infradead.org>; Thu, 14 Mar 2013 07:46:05 -0700 (PDT)
Message-ID: <5141E2AA.8010303@openvz.org>
Date: Thu, 14 Mar 2013 18:46:02 +0400
From: Konstantin Khlebnikov <khlebnikov@openvz.org>
MIME-Version: 1.0
Subject: Re: 3.9.0-rc1: kexec not working: root disk does not show up
References: <20130308171704.GE8219@redhat.com>
 <20130312192922.GA2268@redhat.com> <51402ED5.6000902@openvz.org>
 <20130313135351.GB11528@redhat.com> <514092DC.5020500@openvz.org>
 <20130314135507.GA24238@redhat.com>
In-Reply-To: <20130314135507.GA24238@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Bjorn Helgaas <bhelgaas@google.com>, Jeff Garzik <jgarzik@pobox.com>

Vivek Goyal wrote:
> On Wed, Mar 13, 2013 at 06:53:16PM +0400, Konstantin Khlebnikov wrote:
>
> [..]
>> PCI: Don't try to disable Bus Master on disconnected PCI devices
>>
>> From: Konstantin Khlebnikov<khlebnikov@openvz.org>
>>
>> This is fix for commit 7897e6022761ace7377f0f784fca059da55f5d71 from v3.9-rc1
>> ("PCI: Disable Bus Master unconditionally in pci_device_shutdown()")
>> in turn that was fix for b566a22c23327f18ce941ffad0ca907e50a53d41 from v3.5-rc1
>> ("PCI: disable Bus Master on PCI device shutdown")
>>
>> Unfortunately fixing one bug uncovers another: after ->shutdown() device can be
>> already disconnected from the bus and configuration space in no longer available
>>
>> Link: https://lkml.org/lkml/2013/3/12/529
>> Signed-off-by: Konstantin Khlebnikov<khlebnikov@openvz.org>
>> Reported-by: Vivek Goyal<vgoyal@redhat.com>
>> Cc: Bjorn Helgaas<bhelgaas@google.com>
>> Cc: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
>> ---
>>   drivers/pci/pci-driver.c |    5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 1fa1e48..79277fb 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -390,9 +390,10 @@ static void pci_device_shutdown(struct device *dev)
>>
>>   	/*
>>   	 * Turn off Bus Master bit on the device to tell it to not
>> -	 * continue to do DMA
>> +	 * continue to do DMA. Don't touch devices in D3cold or unknown states.
>>   	 */
>> -	pci_clear_master(pci_dev);
>> +	if (pci_dev->current_state<= PCI_D3hot)
>> +		pci_clear_master(pci_dev);
>>   }
>>
>>   #ifdef CONFIG_PM
>
> Hi,
>
> Above patch fixed the issue on my box. Now I can kexec. Thanks.
>
> Vivek
>

Ok, thanks for testing.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
