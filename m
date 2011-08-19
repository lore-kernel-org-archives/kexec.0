Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QuDfT-0003T8-JE
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 01:14:40 +0000
Date: Fri, 19 Aug 2011 10:14:32 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 0/3] kdump: Add external kdump entry point for s390
	stand-alone dump tools
Message-ID: <20110819011431.GB20747@verge.net.au>
References: <20110729123944.562622201@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110729123944.562622201@linux.vnet.ibm.com>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org, vgoyal@redhat.com

On Fri, Jul 29, 2011 at 02:39:44PM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> I finished the patches that add the stand-alone dump tools support on
> top of the recently sent v2 patch series. The following three patches
> implement the program check idea that we have discussed recently:
> 
> [1] kdump: Add new machine_kexec_finish() architecture callback
> [2] s390: Add external kdump entry point for s390 stand-alone dump tools
> [3] kexec-tools: Emit program check on s390 for checksum failure

Hi Michael,

in general I am fine with these patches and happy to merge them
although I am a little unclear about the status of the kernel side of
things. Please let me know if you would like me to merge the kexec-tools
patches now or wait a bit (for an updated version?).

Also, if you could give me any pointers on how to obtain an s390
cross-compiling environment for x86_64 I would be most grateful.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
