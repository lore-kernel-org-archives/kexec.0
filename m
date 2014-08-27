Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([103.22.144.67])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XMUWB-0001nj-A5
 for kexec@lists.infradead.org; Wed, 27 Aug 2014 04:07:31 +0000
Date: Wed, 27 Aug 2014 14:06:30 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/5]: ipr: kexec boot speed improvements
Message-ID: <20140827140630.1f0ee455@kryten>
In-Reply-To: <53D6B2A4.4010102@linux.vnet.ibm.com>
References: <53D6B2A4.4010102@linux.vnet.ibm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Brian King <brking@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Wendy Xiong <wenxiong@linux.vnet.ibm.com>, linux-scsi <linux-scsi@vger.kernel.org>, "James E.J. Bottomley" <JBottomley@parallels.com>

Hi Brian,

> Currently when performing a kexec boot with an ipr adapter,
> the adapter gets shutdown completely, flushing all write
> cache, as well as performing a full hardware reset of the card
> during the shutdown phase of the old kernel. This forces
> the new kernel to then wait for the adapter firmware to
> reinitialize, which slows down kexec boot. There is no
> need to do all of this on the newer ipr adapters, since they
> support the ability to cancel outstanding error buffers.
> 
> This patch adds a special case for kexec boot to simply
> cancel these outstanding error buffers, and as long as
> there is no other I/O outstanding to the adapter, which
> there shouldn't be, place the adapter into a state
> where it has no memory of any DMA addresses from the old
> kernel, then disable the device. This significantly
> speeds up kexec boot, particularly in configurations with
> multiple ipr adapters.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---

This reduces boot time on my box from 80 seconds to 34 seconds. ppc64
kernel developers (who boot boxes continually) thank you!

Tested-by: Anton Blanchard <anton@samba.org>

Anton

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
