Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WexKb-0000dM-O9
 for kexec@lists.infradead.org; Tue, 29 Apr 2014 01:59:38 +0000
Date: Tue, 29 Apr 2014 10:59:13 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ppc64/purgatory: Device tree values should be
 read/stored in Big Endian
Message-ID: <20140429015913.GA454@verge.net.au>
References: <20140428102650.5128.70350.stgit@nimbus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140428102650.5128.70350.stgit@nimbus>
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
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On Mon, Apr 28, 2014 at 12:26:50PM +0200, Laurent Dufour wrote:
> The purgatory code reads the device tree's version and stores if needed the
> currently running CPU number. These 2 values are stored in Big Endian
> format in the device tree and should be byte swapped when running in Little
> Endian mode.
> 
> Without this fix, when running in SMP environment, kexec or kdump kernel may
> fail booting with the following message :
> Failed to identify boot CPU
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
