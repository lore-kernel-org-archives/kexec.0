Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NmZiV-0000s0-Cw
	for kexec@lists.infradead.org; Tue, 02 Mar 2010 21:33:24 +0000
Date: Wed, 3 Mar 2010 08:33:21 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/kdump: RMO region does not exist in drconf memory
Message-ID: <20100302213321.GC5297@verge.net.au>
References: <201003021609.50188.chandru@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201003021609.50188.chandru@in.ibm.com>
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
To: Chandru <chandru@in.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>

On Tue, Mar 02, 2010 at 04:09:49PM +0530, Chandru wrote:
> The RMO region can only exist in '/memory@0' node in the device tree.
> While adding support for '/ibm,dynamic-reconfiguration-memory' in
> kexec-tools, I incorrectly extended the code of '/memory@' nodes to
> drconf memory with the assumption that what applies to '/memory@'
> nodes would also apply to drconf memory. This is incorrect and
> hence removing the code from kexec-tools now.
> 
> With this code in place, kexec on kexec fails. The first kexec
> works because '/memory@0' node is read after drconf memory and
> that correctly sets rmo_base and rmo_top from '/memory@0' node.
> While in the kexec'ed kernel, '/ibm,dynamic-reconfiguration-memory'
> is read after '/memory@xxx' nodes and this incorrectly sets both
> rmo_base and rmo_top from drconf memory.

Thanks, applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
