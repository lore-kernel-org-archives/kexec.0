Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout-de.gmx.net ([213.165.64.23])
 by merlin.infradead.org with smtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T2GW1-0004oc-6c
 for kexec@lists.infradead.org; Fri, 17 Aug 2012 06:58:42 +0000
Message-ID: <502DEB9D.7010308@gmx.at>
Date: Fri, 17 Aug 2012 08:58:37 +0200
From: =?UTF-8?B?Q2hyaXN0aWFuIFNjaGF1YnNjaGzDpGdlcg==?=
 <christian.schaubschlaeger@gmx.at>
MIME-Version: 1.0
Subject: Re: Problem with kexec on i386, linux-3.5
References: <500EE046.2000705@gmx.at> <87sjbqjgi8.fsf@xmission.com>
 <502CEA93.7090808@gmx.at> <877gsy4p6h.fsf@xmission.com>
In-Reply-To: <877gsy4p6h.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Khalid Aziz <khalid.aziz@hp.com>, kexec@lists.infradead.org


>> I bistcted that down to this patch:
>>
>> commit b566a22c23327f18ce941ffad0ca907e50a53d41
>> Author: Khalid Aziz <khalid.aziz@hp.com>
>> Date:   Fri Apr 27 13:00:33 2012 -0600
>>
>>     PCI: disable Bus Master on PCI device shutdown
>>    
>>     Disable Bus Master bit on the device in pci_device_shutdown() to ensure PCI
>>     devices do not continue to DMA data after shutdown.  This can cause memory
>>     corruption in case of a kexec where the current kernel shuts down and
>>     transfers control to a new kernel while a PCI device continues to DMA to
>>     memory that does not belong to it any more in the new kernel.
>>    
>>     I have tested this code on two laptops, two workstations and a 16-socket
>>     server.  kexec worked correctly on all of them.
>>    
>>     Signed-off-by: Khalid Aziz <khalid.aziz@hp.com>
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>>
>> Without this patch, int13 works fine here! If anyone needs more
>> information, just let me know!
> Which leads to an interesting conundrum.
>
> kexec appears to be more reliable for booting another kernel with this
> patch applied.  This patch does kill the entier use case of making BIOS
> calls, and I suspect it also does nasty things to alpha bootloaders.
>
> My gut feel is that the trampoline code should reenable bus mastering
> on the devices that lie behind int13, but I don't know how practical
> that suggestion is in reality.

One could make this patch optional... e.g. let kexec tell the running kernel whether or not to disable bus mastering before booting the new one (something like 'kexec --disable-bus-mastering -l /boot/new_kernel.bin'). Don't know if this would be practicable...

Christian


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
