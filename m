Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200B3C001DF
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EIljgxq0KiuL/PxHx8XufiloE0KwbQ1x34biy6L+CyM=; b=CB9F+nZbfYoF7/
	JIUg08deiUBIcsD0HGYTmBOjgu0I79VYf3whfqacInZSVxsme3Zmgz7Y2PwVQng7Y+W2a3Qc11KBu
	TcyrHCF2aul+qDQcT8POKhmb6KGnrWL5Jn6KMa6qDldbW8G3watRqY+PylDO6jQyskfRuSE8uFQuZ
	g53+bCjOFNOJ0WOHPFc+iunqaIb2KgyiuyD8rlY7VRJh3e1jAhNMdsXLHJ9LqHv7ut9AZCpLGGsoE
	kFbqlKS6Co56FhopoJDWcIVavEfakqBRe1kui0P2AvWjQdnNYu68V1+uxSYOkCLsK7w8Rpzfq5NvR
	qGePGww97LLrgbIZhOjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtxQq-0035zq-2o;
	Fri, 20 Oct 2023 21:53:24 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtxQj-0035z1-0w
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 21:53:22 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7046320B74C0;
	Fri, 20 Oct 2023 14:53:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7046320B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1697838796;
	bh=plFbNIXHlGBEFstPge8t77v40f9VEzwt7+PBAdejGv4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P2pEODlh3mQTQQTrTMdm6cOy0U86thZH8Pmfd84wUw09NaRqR7scGZNgOwm2NWGs+
	 MdIqpNdAiMGMovMatiAckGHC3++lVgijwH3pDlQGlNh8lth7Fg4TosZHgspoQjNPGI
	 TYKccM71hgxMUCxrAzlFD8tQWRoirwT3s7Fuo/RA=
Message-ID: <262bd4e0-e6c9-90fe-a072-4accea2154a3@linux.microsoft.com>
Date: Fri, 20 Oct 2023 14:53:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/7] ima: make the memory for events between kexec load
 and exec configurable
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-7-tusharsu@linux.microsoft.com>
 <a8828617-a296-8498-5e1f-b75a089916e0@linux.ibm.com>
 <55585644-2170-d462-4d64-ca3a963b30fe@linux.microsoft.com>
 <15a12e79-2e90-28f7-ffa3-ff470c673099@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <15a12e79-2e90-28f7-ffa3-ff470c673099@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_145317_350186_E0515EB6 
X-CRM114-Status: UNSURE (   7.05  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CgpPbiAxMC8yMC8yMyAxNDoxNiwgU3RlZmFuIEJlcmdlciB3cm90ZToKPiBObywgd2hhdCBJIG1l
YW4gaXMgeW91IHNob3VsZCBhc2sgdGhlIHVzZXIgZm9yIGhvdyBtYW55IGV4dHJhIGtpbG9ieXRl
cyAKPiAoa2IpIHRvIGFsbG9jYXRlIC0gbm90IGFzayBmb3IgcGFnZXMuCj4gCj4gCj4gIMKgwqAg
U3RlZmFuCk9rLiBXaWxsIGRvLgpJIHdpbGwgYWxpZ24gdGhlIGlucHV0IGNvbmZpZyB2YWx1ZSB0
byB0aGUgUEFHRV9TSVpFIGFzIHdlbGwuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
