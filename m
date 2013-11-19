Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViZhc-00034A-0e
 for kexec@lists.infradead.org; Tue, 19 Nov 2013 01:02:04 +0000
Date: Tue, 19 Nov 2013 10:01:40 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc64: bring up new ppc64le architecture
Message-ID: <20131119010140.GA17628@verge.net.au>
References: <20131115150151.25401.49768.stgit@nimbus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131115150151.25401.49768.stgit@nimbus>
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

On Fri, Nov 15, 2013 at 04:01:51PM +0100, Laurent Dufour wrote:
> This patch provides support for the new Power PC litte endian (LE) mode. The
> LE mode only differs in the way the instructions and data are stored in memory
> thus there is no real need to duplicate the ppc64 code.
> 
> However some compilation's options, especially for the purgatory, differ
> between little and big endian mode's support. A new "SUBARCH" build variable
> is introduced which is currently only used for PPC64 to specify the
> endianness.
> 
> Another set of changes in this patch is fixing minor endianess issues in the
> ppc64 code and fix an alignment issue raised on Power7 little endian mode.
> Among these fixes, the check on the kernel binary endianess is removed,
> since we can imagine kexecing a LE kernel from a BE environment, as far as
> the specified root filesystem and initrd file are containing the right
> binaries.
> 
> This patch depends on the patch "kexec/ppc64: use common architecture
> fs2dt.c file" I sent earlier on the kexec mailing list.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Hi Laurent,

I have applied this. But could you let me know how to (cross) compile it?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
