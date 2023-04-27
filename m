Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B937C77B73
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JtdxdQ5kdE+TnICEQC1WRjBuSQNVYqyEin5iTIDVN7I=; b=3tMrtFfLjRnUa0
	EZ4nwT++uXwwIZIuT4rdj/KHt6bXUEqlorjI/KqnCyOpxyDVJSY82UfpoOwI1YNxfvzKdTkl71k7h
	+MdcdAh5e1Sz7zct/je7X3bIZytSoYUqzEVGOOPjdWVaeIOi+gfn9j7TPCOi4vvs3j7WdKRLxylee
	R3RWkteKRwGQ3BhWIlKavNBUn72IL+iaY3gM186sC+vRUxTU2s3eh4iAK+zPQYd08Axsjd+3qmfMI
	CI9dIguZrGkbludiBgQt1fGBhxpKM9+M5itcHMa7E8wZtrAWDmxbG01f49FfGd8aB3j89hkFw23SG
	nnIY2pWu+kAEO3gjepIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pryHy-0063jr-1S;
	Thu, 27 Apr 2023 09:51:46 +0000
Received: from mail.neston24.com ([37.187.225.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pryHu-0063iP-1G
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 09:51:44 +0000
Received: by mail.neston24.com (Postfix, from userid 1002)
	id E725621F20; Thu, 27 Apr 2023 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neston24.com; s=mail;
	t=1682589093; bh=5T/I5ALH265FnsfRMA5qkcy2CLiS4J17pa3P6HzpuT0=;
	h=Date:From:To:Subject:From;
	b=ddihj81cEWv5G1plmXR1+7C79WUtG29isnIZPe6Jm1uAHQjQHY78JKKYsAlf/nmIt
	 cg+BCLzatyDLTmzhxXM5rOxYsj0FihS5WvI67UpUx+lITEN4Mc2H5jJ1ZGZCJilpOV
	 XKhVQNTsMDePZIXUMpMIu2e4PFP2dozOjrEEh5IDov0UzEKSbiSz9+pPcw06+EEy9r
	 9Srwv/UQpvI1l7B6VGh34SlBUq3pSGtq9aWmSdMMqmHx7MJ34tGr4TcmZpxxDNxZgQ
	 XfDUDSxHBnsN0YXg/aKrgWDe8ids00mr8wH4wrD7Xi4sQ/Fmkv614HfitcE58oUmjw
	 fDgyaPyI5V0QA==
Received: by mail.neston24.com for <kexec@lists.infradead.org>; Thu, 27 Apr 2023 09:51:00 GMT
Message-ID: <20230427090647-0.1.6j.clig.0.jpazlfk14i@neston24.com>
Date: Thu, 27 Apr 2023 09:51:00 GMT
From: =?UTF-8?Q?"Leo=C5=A1_Sl=C3=A1dek"?= <leos.sladek@neston24.com>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Fotovoltaick=C3=A9_rozvodnice?=
X-Mailer: mail.neston24.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_025143_184706_A629CF3E 
X-CRM114-Status: UNSURE (   0.63  )
X-CRM114-Notice: Please train this message.
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

RG9icsO9IGRlbiwKCm9icmFjw61tIHNlIG5hIFbDoXMgam3DqW5lbSBkbG91aG9sZXTDqWhvIHbD
vXJvYmNlIGZvdG92b2x0YWlja8O9Y2ggcm96dm9kbmljIHVyxI1lbsO9Y2ggcHJvCnNvdWtyb23D
qSBpIHByxa9teXNsb3bDqSBwb3XFvml0w60uCgpEb2TDoXbDoW1lIGZvdG92b2x0YWlja8OpIHJv
enZvZG5pY2UgbmEgemFrw6F6a3UgYSBqc21lIHNjaG9wbmkgcmVhbGl6b3ZhdCBpIHR5IG5lam7D
oXJvxI1uxJtqxaHDrQpwb8W+YWRhdmt5IGluc3RhbGHEjW7DrWNoIGZpcmVtLCB2ZWxrb29iY2hv
ZMWvIGEgZGlzdHJpYnV0b3LFry4KClZ5dcW+w612w6FtZSBuZWprdmFsaXRuxJtqxaHDrSBrb21w
b25lbnR5IGEgbWF0ZXJpw6FseSwgxI3DrW3FviBkb3NhaHVqZW1lIHZ5xaHFocOtIG9kb2xub3N0
LCBzdGFiaWxpdHUKcHJvdm96dSBhIG9jaHJhbnUgcHJvdGkgdm9kxJssIHZsa3UsIHByYWNodSBh
IG7DoXJhesWvbS4KClYgbmHFoWVtIHNvcnRpbWVudHUganNvdSB0YWvDqSBvbWV6b3ZhxI1lIHDF
mWVwxJt0w60gQUMvREMsIGt0ZXLDqSB6YWppxaHFpXVqw60gb2NocmFudQpmb3Rvdm9sdGFpY2vD
vWNoIG5hcMOhamVjw61jaCBpbnN0YWxhY8OtIHDFmWVkIG5lZ2F0aXZuw61taSBlZmVrdHkgcMWZ
ZXDEm3TDrSBhIGNocsOhbsOtIHphxZnDrXplbsOtIHDFmWVkCmVmZWt0eSBwxa9zb2JlbsOtIHDF
mWVwxJt0w60gYSBibGVza292w71jaCBwcm91ZMWvLgoKQ2hjZXRlIHNpIHZ5emtvdcWhZXQgbmHF
oWUgxZllxaFlbsOtPwoKClMgcG96ZHJhdmVtCkxlb8WhIFNsw6FkZWsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
