Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54D1C0015E
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 08:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Message-Id:To:
	From:Subject:Cc:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dTJb80Sy8yFDOccB28gtTPPm5XIJTLjfWg3A8jvyQg4=; b=yla/q58cPxyb6W
	vGRaSFy7rgIZFu7acc3vcqM3vZbAoqrojmn6v7zSxJB8N9rCyg5XAZQCp2T1ReFGeCH89dkRLHkoX
	Y5571UQ6yVz76aynBvPOywloTORtkEnI7SRdwNgwwB5hAEqwtbqKlqlsH223J2Rk+G5ryMii9DhCa
	9m0jVchR6QfMBd6H69TDygWB0q02uRkMIEEKaYstKPytALcM0iRRz7vVwsG/UhdhIa6xrt2/qoqju
	pHZly8nC0yTqxIpT1y+xeoED6WPUsgXT2jcm4m/5AE9k7Iz2+YAXvnO/+q5d161iJbp3sL+Z2sVD7
	5X12NRwYtJJDOa55x5qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRTvy-0073xm-1o;
	Thu, 03 Aug 2023 08:43:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRTvu-0073xF-1C
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 08:43:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 363B461C4B;
	Thu,  3 Aug 2023 08:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286F2C433C8;
	Thu,  3 Aug 2023 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691052224;
	bh=AOLcJ1KhDLBUtJkrbox+j2nDyJDRZd0wvc7q6oNEZ84=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=oecah8j38u05dygko8uIB5G9QKEi6ghHOE0ekaFXtkj0pFDBi0dmUinbfSb+kFYuC
	 3hDEX+ur50/KCCLz3B9MXq2yQrlijYdliuhrQrk93MhBCfrkCIS+zGtRl1v2yGSldM
	 R6vEqv1x6STh1V3Cli5ApR1K7KCwjaIFKRabpxpcnz4i5MLLytCLygJdjl+2nwYuu9
	 RdS4OnF9/M20dZKFFUtl1E/J+Kk8JIcl6QycW8t1Hl6ZjWM9zvqoSvWzFMfEe0sCMH
	 vJekB2+bQjs3Ug7st63UwWwMF7Vfyv2w7aJujhoKKiBhIm5w7h4AIkuSaLMHFu2Ith
	 b9ic6xWikVyfg==
Mime-Version: 1.0
Date: Thu, 03 Aug 2023 11:43:37 +0300
Cc: <code@tyhicks.com>, <nramas@linux.microsoft.com>, <paul@paul-moore.com>
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Tushar Sugandhi" <tusharsu@linux.microsoft.com>, <zohar@linux.ibm.com>,
 <noodles@fb.com>, <bauermann@kolabnow.com>, <ebiederm@xmission.com>,
 <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <kexec@lists.infradead.org>,
 <linux-integrity@vger.kernel.org>
Message-Id: <CUIRWHEMXL38.29Z2XR564KV33@suppilovahvero>
X-Mailer: aerc 0.14.0
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
 <dd126081-3216-c15e-124e-ef137b376cdb@linux.microsoft.com>
In-Reply-To: <dd126081-3216-c15e-124e-ef137b376cdb@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_014346_469758_7486ABA7 
X-CRM114-Status: UNSURE (   8.07  )
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

T24gVGh1IEF1ZyAzLCAyMDIzIGF0IDEyOjA0IEFNIEVFU1QsIFR1c2hhciBTdWdhbmRoaSB3cm90
ZToKPiBCdHcsIHRoZSBmdW5jdGlvbiB0cG0yX3Bjcl9yZWFkIGlzIG5vdCBleHBvc2VkIGRpcmVj
dGx5IHRvIHRoZSBvdGhlcgo+IHN1YnN5c3RlbXMgKGxpa2UgSU1BKS7CoCBJdCBpcyBleHBvc2Vk
IHZpYSB0cG1fcGNyX3JlYWQuCj4KPiBEbyB5b3Ugd2FudCB0byBleHBvc2UgdHBtMl9wY3JfcmVh
ZCBkaXJlY3RseSwKPiBvciBkbyB5b3Ugd2FudCBtZSB0byB1cGRhdGUgdGhlIGZ1bmN0aW9uIHNp
Z25hdHVyZSBvZiB0cG1fcGNyX3JlYWQgYXMgd2VsbD8KCkFzIGxvbmcgYXMgeW91IG1lbnRpb24g
dGhhdCAndXBkYXRlX2NudCcgY2F1c2VzIGRpdmVnZW5jZSBpbiB0aGUKaW4ta2VybmVsIEFQSSwg
YW5kIHRoZXJlZm9yZSB0cG1bMTJdX3Bjcl9yZWFkKCkgY2Fubm5vdCBiZSB1bmRlciB0aGUKc2Ft
ZSBvcmNoZXN0cmF0b3IuCgpJZiB5b3UgdGFrZSB0aGlzIHBhdGgsIHBsZWFzZSBpbXBsZW1lbnQg
YSBwcmVjdXJzb3J5IHBhdGNoLCB3aGljaApyZXBsYWNlIHRoZSBleGlzdGluZyBjYWxsIHNpdGVz
IHdpdGggc29tZSBzZXF1ZW5jZSBvZiB0cG1bMTJdX3Bjcl9yZWFkKCkKYW5kIHRwbV9pc190cG0y
KCkgY2FsbHMuCgpCUiwgSmFya2tvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
