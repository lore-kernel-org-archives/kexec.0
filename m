Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NL3Ve-0004ul-Kb
	for kexec@lists.infradead.org; Wed, 16 Dec 2009 23:42:26 +0000
From: Roland Dreier <rdreier@cisco.com>
Subject: Re: kexec reboot broken with ioatdma?
References: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>
	<20091216224912.GC16219@verge.net.au>
	<aday6l27c7w.fsf@roland-alpha.cisco.com>
	<20091216233613.GA22449@verge.net.au>
Date: Wed, 16 Dec 2009 15:42:20 -0800
In-Reply-To: <20091216233613.GA22449@verge.net.au> (Simon Horman's message of
	"Thu, 17 Dec 2009 10:36:13 +1100")
Message-ID: <adapr6e7ag3.fsf@roland-alpha.cisco.com>
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


 > If its reset in a standard path, then yes that seems sensible to me.
 > I'm mainly concerned about avoiding something along the lines of:
 > 
 > 	if (is_booting_from_kexec)
 > 		reset_hw();

I think we all agree... the idea is to change from

	init_hw()
	{
		/* assume hw is in pristine state */
		do_init();
	}

to

	init_hw()
	{
		/* hw is in unknown state */
		reset_hw();
		do_init();
	}

 - R.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
