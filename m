Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NL2ud-0006p2-9b
	for kexec@lists.infradead.org; Wed, 16 Dec 2009 23:04:11 +0000
From: Roland Dreier <rdreier@cisco.com>
Subject: Re: kexec reboot broken with ioatdma?
References: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>
	<20091216224912.GC16219@verge.net.au>
Date: Wed, 16 Dec 2009 15:04:03 -0800
In-Reply-To: <20091216224912.GC16219@verge.net.au> (Simon Horman's message of
	"Thu, 17 Dec 2009 09:49:12 +1100")
Message-ID: <aday6l27c7w.fsf@roland-alpha.cisco.com>
MIME-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: Dan Williams <dan.j.williams@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org


 > from a kexec point of view I believe that the preferred option is the
 > former - shutdown the device so it can be initialised using standard paths
 > in the second kernel.

OK... however I'm not suggesting a separate kexec initialization path,
simply adding a reset of the device in the standard initialization.
This would be fairly normal for other types of device; for example, the
BIOS may have left a NIC in an undefined state due to network boot.  Of
course BIOS is unlikely to use an IOAT DMA engine but the principle of
limiting assumptions about platform state still stands I think.

From a quick look, it seems tricky to get a clean shutdown of IOAT stuff
since there doesn't seem to be a clean ordering that makes sure the
ioatdma stuff is shutdown after everything using it.

 - R.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
