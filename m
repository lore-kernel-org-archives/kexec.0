Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ob0-x231.google.com ([2607:f8b0:4003:c01::231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UNQLT-0002Ed-N8
 for kexec@lists.infradead.org; Wed, 03 Apr 2013 16:15:32 +0000
Received: by mail-ob0-f177.google.com with SMTP id uz6so1549110obc.22
 for <kexec@lists.infradead.org>; Wed, 03 Apr 2013 09:15:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51593E81.3030800@openvz.org>
References: <20130314144936.10073.2403.stgit@zurg>
 <51593E81.3030800@openvz.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 3 Apr 2013 10:15:09 -0600
Message-ID: <CAErSpo7uPodBTk1v4ch=Aycgx6OVkWDvw6-Wrwh3MrSaduHnkA@mail.gmail.com>
Subject: Re: [PATCH bugfix 3.9] PCI: Don't try to disable Bus Master on
 disconnected PCI devices
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
To: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Jeff Garzik <jgarzik@pobox.com>, Vivek Goyal <vgoyal@redhat.com>

[+cc linux-pci]

On Mon, Apr 1, 2013 at 2:00 AM, Konstantin Khlebnikov
<khlebnikov@openvz.org> wrote:
> BUMP. This is degradation from 3.8, so this patch must be in 3.9.
>
> I still don't like this forced clearing bus-master bit. But this hack
> definitely fixes problems in kexec, so there is reason to keep it here.

Applied to for-linus for v3.9, thanks!

> Konstantin Khlebnikov wrote:
>>
>> This is fix for commit 7897e6022761ace7377f0f784fca059da55f5d71 from
>> v3.9-rc1
>> ("PCI: Disable Bus Master unconditionally in pci_device_shutdown()")
>> in turn that was fix for b566a22c23327f18ce941ffad0ca907e50a53d41 from
>> v3.5-rc1
>> ("PCI: disable Bus Master on PCI device shutdown")
>>
>> Unfortunately fixing one bug uncovers another:
>> ->shutdown() callback might switch device to deep sleep state.
>> PCI config space no longer available after that.
>>
>> Link: https://lkml.org/lkml/2013/3/12/529
>> Signed-off-by: Konstantin Khlebnikov<khlebnikov@openvz.org>
>> Reported-and-Tested-by: Vivek Goyal<vgoyal@redhat.com>
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
>>         /*
>>          * Turn off Bus Master bit on the device to tell it to not
>> -        * continue to do DMA
>> +        * continue to do DMA. Don't touch devices in D3cold or unknown
>> states.
>>          */
>> -       pci_clear_master(pci_dev);
>> +       if (pci_dev->current_state <= PCI_D3hot)
>> +               pci_clear_master(pci_dev);
>>   }
>>
>>   #ifdef CONFIG_PM
>>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
