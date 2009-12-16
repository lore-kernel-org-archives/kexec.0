Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NL323-00005Y-0C
	for kexec@lists.infradead.org; Wed, 16 Dec 2009 23:11:51 +0000
Message-ID: <4B296930.9020704@intel.com>
Date: Wed, 16 Dec 2009 16:11:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
Subject: Re: kexec reboot broken with ioatdma?
References: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>	<20091216224912.GC16219@verge.net.au>
	<aday6l27c7w.fsf@roland-alpha.cisco.com>
In-Reply-To: <aday6l27c7w.fsf@roland-alpha.cisco.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Roland Dreier <rdreier@cisco.com>
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Roland Dreier wrote:
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

I agree that is more robust if the init path copes with hardware 
arriving in an unknown state.  I'll look into adding a channel reset in 
the init path (something that should probably have been there since the 
beginning).

> From a quick look, it seems tricky to get a clean shutdown of IOAT stuff
> since there doesn't seem to be a clean ordering that makes sure the
> ioatdma stuff is shutdown after everything using it.

The engines may be in use by multiple subsytems (net, raid) so 
coordinating shutdown ordering would indeed be a pain.

--
Dan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
