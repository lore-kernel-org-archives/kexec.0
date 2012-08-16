Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout-de.gmx.net ([213.165.64.23])
 by merlin.infradead.org with smtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T1zOo-000511-Kd
 for kexec@lists.infradead.org; Thu, 16 Aug 2012 12:42:07 +0000
Message-ID: <502CEA93.7090808@gmx.at>
Date: Thu, 16 Aug 2012 14:41:55 +0200
From: =?UTF-8?B?Q2hyaXN0aWFuIFNjaGF1YnNjaGzDpGdlcg==?=
 <christian.schaubschlaeger@gmx.at>
MIME-Version: 1.0
Subject: Re: Problem with kexec on i386, linux-3.5
References: <500EE046.2000705@gmx.at> <87sjbqjgi8.fsf@xmission.com>
In-Reply-To: <87sjbqjgi8.fsf@xmission.com>
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
To: kexec@lists.infradead.org
Cc: Khalid Aziz <khalid.aziz@hp.com>, "Eric W. Biederman" <ebiederm@xmission.com>



> That is a tricky issue.  Sometimes the slightest things can set
> something like this off.
>
> Somewhere someone changed something in one of the drivers that made it
> so that the hardware winds up in a state the int 13 disk driver does not
> like it after kexec.
> .
> If you want to track this down I would recommend a bisect between 3.4
> and 3.5-rc1 to see which change breaks your setup.

I bistcted that down to this patch:

commit b566a22c23327f18ce941ffad0ca907e50a53d41
Author: Khalid Aziz <khalid.aziz@hp.com>
Date:   Fri Apr 27 13:00:33 2012 -0600

    PCI: disable Bus Master on PCI device shutdown
   
    Disable Bus Master bit on the device in pci_device_shutdown() to ensure PCI
    devices do not continue to DMA data after shutdown.  This can cause memory
    corruption in case of a kexec where the current kernel shuts down and
    transfers control to a new kernel while a PCI device continues to DMA to
    memory that does not belong to it any more in the new kernel.
   
    I have tested this code on two laptops, two workstations and a 16-socket
    server.  kexec worked correctly on all of them.
   
    Signed-off-by: Khalid Aziz <khalid.aziz@hp.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


Without this patch, int13 works fine here! If anyone needs more information, just let me know!


Greetings,
Christian


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
