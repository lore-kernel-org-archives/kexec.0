Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WAbQ1-00084T-Mq
 for kexec@lists.infradead.org; Tue, 04 Feb 2014 08:31:46 +0000
Date: Tue, 4 Feb 2014 17:31:23 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RESEND PATCH] kexec/ppc64 ELF ABIv2 ABI support
Message-ID: <20140204083123.GD30621@verge.net.au>
References: <20140203143749.7503.74213.stgit@nimbus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140203143749.7503.74213.stgit@nimbus>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On Mon, Feb 03, 2014 at 03:37:49PM +0100, Laurent Dufour wrote:
> When building in PPC64 little endian mode, the compiler is now using the
> new ABI v2. Among other changes, this new ABI removes the function
> descriptors and changes the way the TOC address is computed when entering a
> C function.
> 
> The purgatory assembly part where the dot symbols are removed, and ELF
> relocation code are impacted in this patch.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
