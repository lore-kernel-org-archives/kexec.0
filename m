Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W96Y0-0006bg-UO
 for kexec@lists.infradead.org; Fri, 31 Jan 2014 05:21:49 +0000
Date: Fri, 31 Jan 2014 14:21:24 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec/ppc64 fix device tree endianess issues for
 memory attributes
Message-ID: <20140131052124.GA25099@verge.net.au>
References: <20140130150622.11156.39497.stgit@nimbus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140130150622.11156.39497.stgit@nimbus>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>

On Thu, Jan 30, 2014 at 04:06:22PM +0100, Laurent Dufour wrote:
> All the attributes exposed in the device tree are in Big Endian format.
> 
> This patch add the byte swap operation for some entries which were not yet
> processed, including those fixed by the following kernel's patch :
> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-January/114720.html
> 
> To work on PPC64 Little Endian mode, kexec now requires that the kernel's
> patch mentioned above is applied on the kexecing kernel.
> 
> Tested on ppc64 LPAR (kexec/dump) and ppc64le in a Qemu/KVM guest (kexec)
> 
> Changes from v1 :
>  * add processing of the following entries :
>    - ibm,dynamic-reconfiguration-memory
>    - chosen/linux,kernel-end
>    - chosen/linux,crashkernel-base & size
>    - chosen/linux,memory-limit
>    - chosen/linux,htab-base & size
>    - linux,tce-base & size
>    - memory@/reg
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
