Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgusO-0007Y3-LJ
	for kexec@lists.infradead.org; Wed, 02 Apr 2008 04:47:09 +0000
Message-Id: <47F30FC8.7040408@mxs.nes.nec.co.jp>
Date: Wed, 02 Apr 2008 13:47:04 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [Patch] fix error case of xen
References: <A7C89354154DF3takebe_akio@jp.fujitsu.com>	<47F1D054.9080307@mxs.nes.nec.co.jp>
	<ACC89460E5F00Dtakebe_akio@jp.fujitsu.com>
In-Reply-To: <ACC89460E5F00Dtakebe_akio@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1890193655=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Akio Takebe <takebe_akio@jp.fujitsu.com>
Cc: kexec-ml <kexec@lists.infradead.org>

--===============1890193655==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Takebe-san,

Akio Takebe wrote:
>> I guess that the above code is not enough. If handle_xen() succeeds,
>> it should return TRUE instead of COMPLETED like the attached patch, right ?
> 
> You're right!
> Your patch looks good, thank you very much for your review.

Thank you for the comment.
I'll release the next makedumpfile which includes it.


Thanks
Ken'ichi Ohmichi


--===============1890193655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1890193655==--
