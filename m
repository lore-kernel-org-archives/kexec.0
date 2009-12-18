Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NLlB8-0003gQ-LM
	for kexec@lists.infradead.org; Fri, 18 Dec 2009 22:20:11 +0000
From: Roland Dreier <rdreier@cisco.com>
Subject: Re: kexec reboot broken with ioatdma?
References: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>
	<20091216224912.GC16219@verge.net.au>
	<aday6l27c7w.fsf@roland-alpha.cisco.com> <4B296930.9020704@intel.com>
	<adatyvq7bbi.fsf@roland-alpha.cisco.com>
	<1261174241.16958.6.camel@dwillia2-linux.ch.intel.com>
Date: Fri, 18 Dec 2009 14:20:02 -0800
In-Reply-To: <1261174241.16958.6.camel@dwillia2-linux.ch.intel.com> (Dan
	Williams's message of "Fri, 18 Dec 2009 15:10:41 -0700")
Message-ID: <adafx773ox9.fsf@roland-alpha.cisco.com>
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
To: Dan Williams <dan.j.williams@intel.com>
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


 > Subject: ioat2,3: put channel hardware in known state at init
 > 
 > Put the ioat2 and ioat3 state machines in the halted state with all
 > errors cleared.

Yes, with this applied I was able to kexec reboot from a kernel with
ioatdma loaded and have ioatdma work in the new kernel.  So:

Tested-by: Roland Dreier <rolandd@cisco.com>

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
