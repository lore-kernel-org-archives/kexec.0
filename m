Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]
 helo=tx2outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TtYmI-00087V-8x
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 07:11:47 +0000
From: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: [PATCH 3/3] ppc/uImage: Add support for RAM Disks
Date: Fri, 11 Jan 2013 07:11:35 +0000
Message-ID: <70CC66F5C30A414DADDA6973E4CA391A820296@039-SN1MPN1-002.039d.mgd.msft.net>
References: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
 <20130111064203.11490.72998.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20130111064203.11490.72998.stgit@suzukikp.in.ibm.com>
Content-Language: en-US
Content-ID: <A58C94F2D362D849A06ABBB3E1D8125E@mgd.freescale.com>
MIME-Version: 1.0
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
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
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: "mat@brain-dump.org" <mat@brain-dump.org>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "horms@verge.net.au" <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "lethal@linux-sh.org" <lethal@linux-sh.org>

On Fri, Jan 11, 2013 at 12:42 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wrote:
> From: Suzuki K. Poulose <suzuki@in.ibm.com>
>
> Handle the RAM Disks in uImage format

As opposed to simple ext2.gz ramdisk?

-M

>
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> ---
>  kexec/arch/ppc/kexec-uImage-ppc.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
> index eaea3c1..58935c0 100644
> --- a/kexec/arch/ppc/kexec-uImage-ppc.c
> +++ b/kexec/arch/ppc/kexec-uImage-ppc.c
> @@ -46,6 +46,26 @@ void uImage_ppc_usage(void)
>         );
>  }
>
> +char* slurp_ramdisk_ppc(const char *filename, off_t *r_size)
> +{
> +       struct Image_info img;
> +       off_t size;
> +       const unsigned char *buf =
> +                       (const unsigned char *)slurp_file(filename, &size);
> +
> +       /* Check if this is a uImage RAMDisk */
> +       if (buf != (void*)0 &&
> +               uImage_probe(buf, size, IH_ARCH_PPC) == IH_TYPE_RAMDISK) {
> +               if (uImage_load(buf, size, &img) != 0)
> +                       die ("uImage: Reading %ld bytes from %s failed\n", size, filename);
> +               buf = img.buf;
> +               size = img.len;
> +       }
> +
> +       *r_size = size;
> +       return buf;
> +}
> +
>  int uImage_ppc_probe(const char *buf, off_t len)
>  {
>         int type;
> @@ -196,7 +216,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
>         blob_buf = fixup_dtb_init(info, blob_buf, &blob_size, load_addr, &dtb_addr);
>
>         if (ramdisk) {
> -               seg_buf = slurp_file(ramdisk, &seg_size);
> +               seg_buf = slurp_ramdisk_ppc(ramdisk, &seg_size);
>                 /* Load ramdisk at top of memory */
>                 hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
>                                 0, dtb_addr + blob_size, max_addr, -1);
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
