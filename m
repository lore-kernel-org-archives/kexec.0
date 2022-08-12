Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D75C00140
	for <kexec@archiver.kernel.org>; Fri, 12 Aug 2022 18:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OluSBqZvs9/Ty5yWXyPDfN2fEfmcRlVY2w6XJ6BqYzg=; b=zJ8K+FQ3xbJOXc
	IdaBsl0vKHl12/eI+qb7jY/pgQw7nOQA6I25+o8gFURCrEpkwwxqolwN6jDFSELl6Ajfx3rHqn0GZ
	pzD71uJiJ02UoYx5S3DkrJTKM7TASXodj7CIEjY6M5y+umbxDZVVguSQdJpiXi8ypa9p5kLeDic2X
	kcgo240u5/MMkFJlBZS6KG95vdP63DDcV+Mj8CbXe9dSZ2qrcXMbcsOyZTX1Xn5hdbnDzakwb6oxG
	7EX8RLvvt/fAyLEm8xcKJKbNM0igmrlBuwX9Bs88HRz148x/QpMEHkDn/e6e49lwlWZU9wwxiSroI
	1R4n+/CLF1Jsl9eaNuOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMZPB-00C636-Gq; Fri, 12 Aug 2022 18:29:09 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMZP9-00C5zY-0e
	for kexec@lists.infradead.org; Fri, 12 Aug 2022 18:29:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25B892076B;
	Fri, 12 Aug 2022 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1660328943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPX04jbC0BQlROGb55mEQeAkYdO/pUMQJcyP6P8yDMg=;
	b=Dnk3QtxahbVc8N9Wb+mg3LWpIqkL3j324Xp+zLN1b3scdy/6qC3SQRFK8mueXE9dOR3bzD
	kJVAa0mCRV10Ey1xRS0KdJiaA9Wz8rqTWrRnCe1cOw0qo+FQTx1rfRhSaWUJljn9CEbQwD
	xzFf5Tca5Jc7aJLzQhyTBqFAUhyiUPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1660328943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPX04jbC0BQlROGb55mEQeAkYdO/pUMQJcyP6P8yDMg=;
	b=RKeJHxsr+7BAG6RlGp765vCQzZKzbcl/KDPcaPksygxZXVLn3ATBYyju64TDEMjTHB+oX2
	LKozQGXN/hssDQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14F5C13AAE;
	Fri, 12 Aug 2022 18:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Is0VBe+b9mLdIgAAMHmgww
	(envelope-from <bp@suse.de>); Fri, 12 Aug 2022 18:29:03 +0000
Date: Fri, 12 Aug 2022 20:28:58 +0200
From: Borislav Petkov <bp@suse.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
	nasastry@in.ibm.com, mpe@ellerman.id.au,
	Jonathan McDowell <noodles@fb.com>,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v7 3/6] x86/kexec: Carry forward IMA measurement log on
 kexec
Message-ID: <Yvab6lC9BUbmp4a8@zn.tnic>
References: <20220812164305.2056641-1-stefanb@linux.ibm.com>
 <20220812164305.2056641-4-stefanb@linux.ibm.com>
 <YvaJc7bQjz61Y1jj@zn.tnic>
 <935988a4-c245-7cb1-4e14-bc99d39220a1@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <935988a4-c245-7cb1-4e14-bc99d39220a1@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_112907_278919_2BE4BD89 
X-CRM114-Status: UNSURE (   7.62  )
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

T24gRnJpLCBBdWcgMTIsIDIwMjIgYXQgMDE6MTQ6MzhQTSAtMDQwMCwgU3RlZmFuIEJlcmdlciB3
cm90ZToKPiBZZXMsIHNvIHRoaXMgc2VyaWVzIGNhbiBiZSB0ZXN0ZWQgYnkga3JvYm90LgoKWW91
IG1lYW4gSW50ZWwncyAwZGF5IHJvYm90PwoKSSBiZWxpZXZlIHRoYXQgdGhpbmcgaGFzIGJ5IG5v
dyBlbm91Z2ggbG9naWMgdG8gZmlndXJlIG91dCB3aGljaCBicmFuY2gKdG8gYmFzZSBwYXRjaGVz
IG9udG9wLiBPciBtYXliZSB0aGVyZSdzIHNvbWUgbWFnaWMgaW5jYW50YXRpb24gdG8gdGVsbApp
dCB3aGljaCBiYXNlIGNvbW1pdCB0byB1c2Ugc28gdGhhdCB5b3UgY2FuIHNpbXBseSBkbyB5b3Vy
IHBhdGNoZXMgb250b3AKb2YgbGF0ZXN0IGxpbnV4LW5leHQgaW5zdGVhZCBvZiBoYXZpbmcgdG8g
Y2FycnkgdXBzdHJlYW1lZCBwYXRjaGVzLgoKQWxzbywgdGhlcmUncyBhIGxpdHRsZSBwb2ludCBp
biB0ZXN0aW5nIGFnYWluc3QgNS4xOSB3aGVuIHlvdSB3YW5uYSB0ZXN0Cml0IGFnYWluc3QgdjYu
MC1yYzEuLi4KCi0tIApSZWdhcmRzL0dydXNzLAogICAgQm9yaXMuCgpTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHZXJtYW55IEdtYkgKR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRyZXcg
TWNEb25hbGQsIE1hcnRqZSBCb3VkaWVuIE1vZXJtYW4KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJn
KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
