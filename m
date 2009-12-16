Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NL3Pl-0004Bp-Mb
	for kexec@lists.infradead.org; Wed, 16 Dec 2009 23:36:22 +0000
Date: Thu, 17 Dec 2009 10:36:13 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec reboot broken with ioatdma?
Message-ID: <20091216233613.GA22449@verge.net.au>
References: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>
	<20091216224912.GC16219@verge.net.au>
	<aday6l27c7w.fsf@roland-alpha.cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aday6l27c7w.fsf@roland-alpha.cisco.com>
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
To: Roland Dreier <rdreier@cisco.com>
Cc: Dan Williams <dan.j.williams@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, Dec 16, 2009 at 03:04:03PM -0800, Roland Dreier wrote:
> 
>  > from a kexec point of view I believe that the preferred option is the
>  > former - shutdown the device so it can be initialised using standard paths
>  > in the second kernel.
> 
> OK... however I'm not suggesting a separate kexec initialization path,
> simply adding a reset of the device in the standard initialization.
> This would be fairly normal for other types of device; for example, the
> BIOS may have left a NIC in an undefined state due to network boot.  Of
> course BIOS is unlikely to use an IOAT DMA engine but the principle of
> limiting assumptions about platform state still stands I think.

If its reset in a standard path, then yes that seems sensible to me.
I'm mainly concerned about avoiding something along the lines of:

	if (is_booting_from_kexec)
		reset_hw();

> >From a quick look, it seems tricky to get a clean shutdown of IOAT stuff
> since there doesn't seem to be a clean ordering that makes sure the
> ioatdma stuff is shutdown after everything using it.
> 
>  - R.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
