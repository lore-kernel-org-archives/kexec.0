Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sn8un-0002lx-5e
 for kexec@lists.infradead.org; Fri, 06 Jul 2012 13:50:00 +0000
Date: Fri, 6 Jul 2012 22:49:24 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Read always one vmcoreinfo file
Message-ID: <20120706134923.GA8320@verge.net.au>
References: <20120705121635.GA2007@host-192-168-1-59.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120705121635.GA2007@host-192-168-1-59.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Thu, Jul 05, 2012 at 02:16:35PM +0200, Daniel Kiper wrote:
> vmcoreinfo file could exists under /sys/kernel (valid on baremetal only)
> and/or under /sys/hypervisor (valid when Xen dom0 is running).
> Read only one of them. It means that only one PT_NOTE will be
> always created. Remove extra code for second PT_NOTE creation.
> 
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
