Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V4PKF-0003Uq-1D
 for kexec@lists.infradead.org; Wed, 31 Jul 2013 05:51:56 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 08C1D3EE0C2
 for <kexec@lists.infradead.org>; Wed, 31 Jul 2013 14:51:28 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 45CCF45DE77
 for <kexec@lists.infradead.org>; Wed, 31 Jul 2013 14:51:26 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0FD6F45DE73
 for <kexec@lists.infradead.org>; Wed, 31 Jul 2013 14:51:26 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id F2D4EE08002
 for <kexec@lists.infradead.org>; Wed, 31 Jul 2013 14:51:25 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A1CF71DB803B
 for <kexec@lists.infradead.org>; Wed, 31 Jul 2013 14:51:25 +0900 (JST)
Message-ID: <51F8A5C2.1030805@jp.fujitsu.com>
Date: Wed, 31 Jul 2013 14:50:58 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com>
 <CAErSpo4t_2Xw76p3Z9FVzyyK-MBovavDu9D=pYoPMjESSxgT=w@mail.gmail.com>
 <51B19DF3.2070009@jp.fujitsu.com>
 <CAErSpo6dfEnzriHD_aWZB_3E-kSzauhNRHPd+VuFX5HONVKgqw@mail.gmail.com>
 <51B6BEDB.3000509@jp.fujitsu.com>
 <CAErSpo5u8qGALt6C+tuPYXdd2YgyMH6fnPnA+afUteEZ7kY0iw@mail.gmail.com>
 <51B93221.2040505@jp.fujitsu.com>
 <CAErSpo5tVK-Z3aOdMTzab-S8o5zLVtDOFQ8-LSYpUgbrJSsxuw@mail.gmail.com>
 <51BA7BB6.1080104@jp.fujitsu.com> <51EF7466.20703@jp.fujitsu.com>
 <CAErSpo5B7NzVfxwW3bQnfK+iK+DrRsWQd2Cm14z5PWNnRHWL5w@mail.gmail.com>
 <51F5B966.9080405@jp.fujitsu.com>
 <CAErSpo4JtG5qVJb-nCywe3vkft=-cDeRDKn_V92RCZ-sGXpwbg@mail.gmail.com>
 <51F758B6.9090204@jp.fujitsu.com>
 <CAErSpo7TNhQO0dx_xZvF=dU2fSWTFf8x=xUJcEsbadJkv8ktuQ@mail.gmail.com>
 <51F85BCC.2070103@jp.fujitsu.com> <1375240269.31262.92.camel@ul30vt.home>
In-Reply-To: <1375240269.31262.92.camel@ul30vt.home>
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
To: alex.williamson@redhat.com
Cc: linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, bill.sumner@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, vgoyal@redhat.com

(2013/07/31 12:11), Alex Williamson wrote:
> On Wed, 2013-07-31 at 09:35 +0900, Takao Indoh wrote:
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e37fea6..c595997 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3392,6 +3392,59 @@ int pci_reset_function(struct pci_dev *dev)
>>   EXPORT_SYMBOL_GPL(pci_reset_function);
>>   
>>   /**
>> + * pci_reset_bus - reset a PCI bus
>> + * @bus: PCI bus to reset
>> + *
>> + * Returns 0 if the bus was successfully reset or negative if failed.
>> + */
>> +int pci_reset_bus(struct pci_bus *bus)
>> +{
>> +	struct pci_dev *pdev;
>> +	u16 ctrl;
>> +
>> +	if (!bus->self)
>> +		return -ENOTTY;
>> +
>> +	list_for_each_entry(pdev, &bus->devices, bus_list)
>> +		if (pdev->subordinate)
>> +			return -ENOTTY;
>> +
>> +	/* Save config registers of children */
>> +	list_for_each_entry(pdev, &bus->devices, bus_list) {
>> +		dev_info(&pdev->dev, "Save state\n");
>> +		pci_save_state(pdev);
>> +	}
>> +
>> +	dev_info(&bus->self->dev, "Reset Secondary bus\n");
>> +
>> +	/* Assert Secondary Bus Reset */
>> +	pci_read_config_word(bus->self, PCI_BRIDGE_CONTROL, &ctrl);
>> +	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
>> +	pci_write_config_word(bus->self, PCI_BRIDGE_CONTROL, ctrl);
>> +
>> +	/* Read config again to flush previous write */
>> +	pci_read_config_word(bus->self, PCI_BRIDGE_CONTROL, &ctrl);
>> +
>> +	msleep(2);
>> +
>> +	/* De-assert Secondary Bus Reset */
>> +	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>> +	pci_write_config_word(bus->self, PCI_BRIDGE_CONTROL, ctrl);
>> +
>> +	/* Wait for completion */
>> +	msleep(1000);
> 
> 
> We already have secondary bus reset code in this file, why are we
> duplicating it here?  Also, why are these delays different from the
> existing code?  I'm also in need of a bus reset interface for when we
> assign all of the devices on a bus to userspace and do not have working
> function level resets per device.  I'll post my patch series and perhaps
> we can collaborate on a pci bus reset interface.  Thanks,

Good point. Yes, we have already similar functions.

pci_parent_bus_reset()
1. Assert secondary bus reset
2. msleep(100)
3. De-assert secondary bus reset
4. msleep(100)

aer_do_secondary_bus_reset()
1. Assert secondary bus reset
2. msleep(2)
3. De-assert secondary bus reset,
4. msleep(200)

To be honest, I wrote my reset code almost one years ago, so I forgot
the reason why I separated them.

Basically my reset code is based on aer_do_secondary_bus_reset(). The
different is waiting time after reset. My patch has 1000msec waiting
time.

At first my reset code is almost same as aer_do_secondary_bus_reset().
But when I tested the reset code, I found that on certain machine
restoring config registers failed after reset. It failed because 200msec
waiting time was too short. And I found the following description in
PCIe spec. According to this, I thought we should wait at least 1000msec.

6.6.1. Conventional Reset

* The Root Complex and/or system software must allow at least 1.0s
  after a Conventional Reset of a device, before it may determine that a
  device which fails to return a Successful Completion status for a
  valid Configuration Request is a broken device. This period is
  independent of how quickly Link training completes.

  Note: This delay is analogous to the Trhfa parameter specified for
  PCI/PCI-X, and is intended to allow an adequate amount of time for
  devices which require self initialization.

* When attempting a Configuration access to devices on a PCI or PCI-X
  bus segment behind a PCI Express/PCI(-X) Bridge, the timing parameter
  Trhfa must be respected.

And I saw patches you posted today, yes, your patch looks helpful for
my purpose:-)

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
