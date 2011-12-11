Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RZebr-0000dQ-5T
 for kexec@lists.infradead.org; Sun, 11 Dec 2011 08:18:11 +0000
Date: Sun, 11 Dec 2011 17:17:57 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: s390: Do not create ELF header by default
Message-ID: <20111211081757.GH6004@verge.net.au>
References: <1323438139.3253.2.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1323438139.3253.2.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On Fri, Dec 09, 2011 at 02:42:19PM +0100, Michael Holzheu wrote:
> Hello Simon,
> 
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> For s390 we have two modes for kdump:
> 
> For the first mode, as on all other architectures, the kexec tool creates
> the ELF header and the 2nd kernel processes it for /proc/vmcore setup.
> 
> This mode has the disadvantage that for memory and CPU hotplug the kdump
> kernel has to be reloaded by the kexec tool. For s390 this is a real problem
> because we have a cpuplugd daemon that sets CPUs online and offline
> according to the current workload. So CPU online/offline events occur very
> often.
> 
> For the second mode on s390, the ELF header is created by the kdump kernel.
> This is done automatically when the kernel is booted in kdump mode
> and no "elfcorehdr" kernel parameter is specified. On s390 the kdump kernel
> can get all necessary information to build the ELF header. We can get
> the memory map, all CPU registers, and vmcoreinfo 
> 
> With this patch a compile switch WITH_ELF_HEADER is introduced. When the
> macro is defined, kexec will create the ELF header and add the "elfcorehdr"
> kernel parameter. If it is not specified (default), no header is created.
> 
> For s390 we want to have the 2nd mode as default because it has only
> advantages for us.

Thanks Michael,

applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
