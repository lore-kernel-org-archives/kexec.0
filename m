Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([143.182.124.37])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TJ8Hy-0007zi-JX
 for kexec@lists.infradead.org; Tue, 02 Oct 2012 19:37:55 +0000
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v2 0/2] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <20121002074434.204.47750.sendpatchset@indoh>
Date: Tue, 02 Oct 2012 12:37:44 -0700
In-Reply-To: <20121002074434.204.47750.sendpatchset@indoh> (Takao Indoh's
 message of "Tue, 2 Oct 2012 16:49:56 +0900 (JST)")
Message-ID: <m2mx04wtpz.fsf@firstfloor.org>
MIME-Version: 1.0
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, vgoyal@redhat.com

Takao Indoh <indou.takao@jp.fujitsu.com> writes:

> These patches reset PCIe devices at boot time to address DMA problem on
> kdump with iommu. When "reset_devices" is specified, a hot reset is
> triggered on each PCIe root port and downstream port to reset its
> downstream endpoint.

Great. I've been pondering this for a long time, but you did finally
implement it. I hope this will make kdump a lot more reliable at least
on the systems that support per port reset.

Now the only question is: why make it a option and not default?

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
