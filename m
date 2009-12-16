Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NL3DT-0002F2-IL
	for kexec@lists.infradead.org; Wed, 16 Dec 2009 23:23:39 +0000
From: Roland Dreier <rdreier@cisco.com>
Subject: Re: kexec reboot broken with ioatdma?
References: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>
	<20091216224912.GC16219@verge.net.au>
	<aday6l27c7w.fsf@roland-alpha.cisco.com> <4B296930.9020704@intel.com>
Date: Wed, 16 Dec 2009 15:23:29 -0800
In-Reply-To: <4B296930.9020704@intel.com> (Dan Williams's message of "Wed, 16
	Dec 2009 16:11:44 -0700")
Message-ID: <adatyvq7bbi.fsf@roland-alpha.cisco.com>
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


 > I agree that is more robust if the init path copes with hardware
 > arriving in an unknown state.  I'll look into adding a channel reset
 > in the init path (something that should probably have been there since
 > the beginning).

Great, let me know and I'll try it on my system with kexec.

Thanks,
  Roland

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
