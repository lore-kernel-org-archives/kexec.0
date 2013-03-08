Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDpX6-0004q8-SD
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 05:07:55 +0000
Date: Fri, 8 Mar 2013 06:07:43 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/4] kexec: Support for uImage RAMDISK
Message-ID: <20130308050743.GA22687@verge.net.au>
References: <20130306083331.18627.82812.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130306083331.18627.82812.stgit@suzukikp.in.ibm.com>
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
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: msm@freescale.com, bigeasy@linutronix.de, lethal@linux-sh.org, kexec@lists.infradead.org

On Wed, Mar 06, 2013 at 02:07:35PM +0530, Suzuki K. Poulose wrote:
> The following series adds support and APIs for 
> handling uImage formatted RAMDISK. The support for PPC
> has been implemented.
> 
> Changes since V1:
>   * Do not uncompress RAMDISK uImage (Pointed by Sebastian)
>   * Introduce new APIs uImage_probe_kernel/uImage_probe_ramdisk to be
>     used by the arch specific code.
>   * Fix coding style related issues pointed by Sebastian.
>   * Add a new patch for fixing payload length calculation and also
>     fix a vulnerability where the image is manipulated.
>     (catches only the file size related changes. When
>      compiled with zlib, CRC check is enabled by
>      default and the contents are verified.)
> 
>  TODO: Implement crc check in kexec, if ZLIB is not compiled in
> 
> ---
> 
> Suzuki K. Poulose (4):
>       kexec/uImage: Introduce uImage_probe_kernel
>       kexec/uImage: Fix the payload length in uImage_load
>       kexec/uImage: Recognize uImage RAM Disks
>       ppc/uImage: Add support for RAM Disks

Thanks, all 4 patches applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
