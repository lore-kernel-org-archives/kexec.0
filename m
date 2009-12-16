Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NL2gF-0002gz-Qx
	for kexec@lists.infradead.org; Wed, 16 Dec 2009 22:49:20 +0000
Date: Thu, 17 Dec 2009 09:49:12 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec reboot broken with ioatdma?
Message-ID: <20091216224912.GC16219@verge.net.au>
References: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>
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

On Wed, Dec 16, 2009 at 01:32:11PM -0800, Roland Dreier wrote:
> I have a system with IOAT hardware, and rebooting with kexec fails with
> the latest 2.6.32-git kernel.  I haven't really tried earlier kernels,
> but I suspect the issue comes from the ioatdma driver being autoloaded now.
> 
> The reboot gets stuck at:
> 
>   ioatdma 0000:00:16.0: Self-test copy timed out, disabling
>   ioatdma 0000:00:16.0: Freeing 2 in use descriptors!
>   ioatdma 0000:00:16.0: Intel(R) I/OAT DMA Engine init failed
> 
> so presumably the IOAT hardware is left in a bad state that the ioatdma
> driver in the kexec'ed new kernel can't handle.
> 
> I notice that long ago, there was a commit 428ed602 ("I/OAT: fix I/OAT
> for kexec") that added a shutdown method to clean things up so kexec
> worked, and then more recently there was 4fac7fa5 ("ioat: do not perform
> removal actions at shutdown") that got rid of the shutdown hook.
> 
> I'm not sure what the correct fix is here: fix the shutdown order so
> everyone drops all references to IOAT stuff before IOAT is shutdown, or
> add some code to the ioatdma driver so it resets the hardware on startup
> so the new kernel can deal with an unspecified state.

Hi Roland,

from a kexec point of view I believe that the preferred option is the
former - shutdown the device so it can be initialised using standard paths
in the second kernel.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
