Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1Quhkj-0000V4-5x
	for kexec@lists.infradead.org; Sat, 20 Aug 2011 09:22:05 +0000
Date: Sat, 20 Aug 2011 18:21:57 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 0/2] s390: Patch series for s390 kdump support
Message-ID: <20110820092157.GA24619@verge.net.au>
References: <20110819130949.289522258@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110819130949.289522258@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, hbabu@us.ibm.com, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org, vgoyal@redhat.com

On Fri, Aug 19, 2011 at 03:09:49PM +0200, Michael Holzheu wrote:
> Hello Simon,
> 
> The following two patches add s390 kdump support (64 bit only) to the
> kexec-tools:
> [0] Add s390 kdump support
> [1] Allow to call verify_sha256_digest() from kernel

Thanks, applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
