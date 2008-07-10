Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KGrzw-0008C6-Tl
	for kexec@lists.infradead.org; Thu, 10 Jul 2008 08:59:33 +0000
Message-Id: <4875CF72.9060306@mxs.nes.nec.co.jp>
Date: Thu, 10 Jul 2008 17:59:30 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Improve error handing when SIZE(nodemask_t)
	is undefined
References: <20080709134801.149fbdb4@halley.suse.de>	<487562F0.8020606@mxs.nes.nec.co.jp>
	<20080710105157.2af29b21@halley.suse.de>
In-Reply-To: <20080710105157.2af29b21@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2100830314=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

--===============2100830314==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> * Ken'ichi Ohmichi [2008-07-10 10:16]:
>>> +	if (SIZE(nodemask_t) == NOT_FOUND_LONG_VALUE) {
>>> +		ERRMSG("SIZE(nodemask_t) undefined.\n");
>> I like the following message of the same form as another message.
>>
>> ERRMSG("Can't get the size of nodemask_t.\n");
> 
> Sounds fine, thanks.

Thank you for the response.
I merged this patch into DEVEL tree, and I'll merge it into
the next release too.


Thanks
Ken'ichi Ohmichi


--===============2100830314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2100830314==--
