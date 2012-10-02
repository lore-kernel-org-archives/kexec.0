Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TJ8Of-00084m-Nq
 for kexec@lists.infradead.org; Tue, 02 Oct 2012 19:44:51 +0000
Date: Tue, 2 Oct 2012 15:44:29 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/2] Reset PCIe devices to address DMA problem on
 kdump with iommu
Message-ID: <20121002194429.GG758@redhat.com>
References: <20121002074434.204.47750.sendpatchset@indoh>
 <m2mx04wtpz.fsf@firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m2mx04wtpz.fsf@firstfloor.org>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: martin.wilck@ts.fujitsu.com, Takao Indoh <indou.takao@jp.fujitsu.com>, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de

On Tue, Oct 02, 2012 at 12:37:44PM -0700, Andi Kleen wrote:
> Takao Indoh <indou.takao@jp.fujitsu.com> writes:
> 
> > These patches reset PCIe devices at boot time to address DMA problem on
> > kdump with iommu. When "reset_devices" is specified, a hot reset is
> > triggered on each PCIe root port and downstream port to reset its
> > downstream endpoint.
> 
> Great. I've been pondering this for a long time, but you did finally
> implement it. I hope this will make kdump a lot more reliable at least
> on the systems that support per port reset.
> 
> Now the only question is: why make it a option and not default?

Do you mean why to hide it behind "reset_devices" kernel parameter?

One thing still is concerning is how to avoid double resets. We probably
will not want first bus resets and then driver loads and does another
reset after seeing "reset_devices".

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
