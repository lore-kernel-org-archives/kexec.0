Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TNoMs-0004AF-PB
 for kexec@lists.infradead.org; Mon, 15 Oct 2012 17:22:21 +0000
Message-ID: <1350321429.7065.97.camel@rhapsody>
Subject: Re: [PATCH v4 1/2] x86, pci: Reset PCIe devices at boot time
From: Khalid Aziz <khalid@gonehiking.org>
Date: Mon, 15 Oct 2012 11:17:09 -0600
In-Reply-To: <20121015065526.2832.90867.sendpatchset@indoh>
References: <20121015065516.2832.42378.sendpatchset@indoh>
 <20121015065526.2832.90867.sendpatchset@indoh>
Mime-Version: 1.0
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
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com

On Mon, 2012-10-15 at 16:00 +0900, Takao Indoh wrote:
> This patch resets PCIe devices at boot time by hot reset when
> "reset_devices" is specified.
> 
> Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
> ---
>  arch/x86/include/asm/pci-direct.h |    1 
>  arch/x86/kernel/setup.c           |    3 
>  arch/x86/pci/early.c              |  344 ++++++++++++++++++++++++++++
>  include/linux/pci.h               |    2 
>  init/main.c                       |    4 
>  5 files changed, 352 insertions(+), 2 deletions(-)
> 


Looks good.

Reviewed-by: Khalid Aziz <khalid@gonehiking.org>

--
Khalid


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
