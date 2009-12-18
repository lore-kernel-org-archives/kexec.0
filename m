Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sj-iport-1.cisco.com ([171.71.176.70])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NLlN6-0006hn-MG
	for kexec@lists.infradead.org; Fri, 18 Dec 2009 22:32:33 +0000
From: Roland Dreier <rdreier@cisco.com>
Subject: Re: kexec reboot broken with ioatdma?
References: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>
	<20091216224912.GC16219@verge.net.au>
	<aday6l27c7w.fsf@roland-alpha.cisco.com> <4B296930.9020704@intel.com>
	<adatyvq7bbi.fsf@roland-alpha.cisco.com>
	<1261174241.16958.6.camel@dwillia2-linux.ch.intel.com>
	<adafx773ox9.fsf@roland-alpha.cisco.com>
	<1261175000.16958.8.camel@dwillia2-linux.ch.intel.com>
Date: Fri, 18 Dec 2009 14:32:25 -0800
In-Reply-To: <1261175000.16958.8.camel@dwillia2-linux.ch.intel.com> (Dan
	Williams's message of "Fri, 18 Dec 2009 15:23:20 -0700")
Message-ID: <adabphv3ocm.fsf@roland-alpha.cisco.com>
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


 > What was that, all of 8 minutes to turn that test around! :-) Nice.

Well, a kexec reboot takes < 30 seconds, and this is a *very* fast box,
so rebuilding the kernel is another 30 seconds.  So I was really just
slacking off for about 7 of those minutes :)

 - R.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
