Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R4rfm-0002L7-Pc
	for kexec@lists.infradead.org; Sat, 17 Sep 2011 09:58:59 +0000
Date: Sat, 17 Sep 2011 18:58:53 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH]  kexec-tools: s390: Find correct address for ramdisk
Message-ID: <20110917095852.GG22218@verge.net.au>
References: <1316177164.3507.10.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1316177164.3507.10.camel@br98xy6r>
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
Cc: kexec@lists.infradead.org

On Fri, Sep 16, 2011 at 02:46:04PM +0200, Michael Holzheu wrote:
> Hello Simon,
> 
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> When the kernel image size is larger than 8 MiB on s390, we currently
> can't load the ramdisk, because it is loaded to the fix address 8 MiB
> (RAMDISK_ORIGIN_ADDR) per default.
> 
> With this patch the ramdisk is loaded behind the image with an 1 MiB
> alignment. To be compatible with older kernels we still load
> the ramdisk to 8 MiB, if the kernel is smaller than 8 MiB.

Thanks, I have queued this up.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
