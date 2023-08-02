Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C733C04A6A
	for <kexec@archiver.kernel.org>; Wed,  2 Aug 2023 03:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WxNag5Yj9ch8vOLxDZp87OmN7ak5H2DO+FZcHYv48Ec=; b=vmITW8+q3TZFML
	Gx4u8NXSjiYfLZ8sxpR5P3sq0vb+gpLyBnyuXj3qD8ZTDvl6bMtWVh5htmzYbD8dfhk3vDYvJS4hP
	Frf7nzEwTi83TI9JdtEcJWJ82rKda3z0bMAzgOqFufkAkDhm+sflYQGvJGAV0LT+O5S3NfoUsK7H1
	5mqXrf37Zj2DOlFLG6bUDOE9KHK+tAyfan6ua7UtZ9itM8C9uxTImrcEcrO/I6A6rnLcyK3cxf2bs
	0ZxCxqaFIWuaBWrnyGr/EWmjV88muW9M/Eu9s50CKLQKqcXnrwXCDu3aEDCG84lMXJrGNhcjANQbG
	qYxV8VehhHQZvWS3wLcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qR30K-003ukz-2c;
	Wed, 02 Aug 2023 03:58:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qR30E-003ukQ-31
	for kexec@lists.infradead.org;
	Wed, 02 Aug 2023 03:58:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5C061796;
	Wed,  2 Aug 2023 03:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5E8C433C8;
	Wed,  2 Aug 2023 03:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690948705;
	bh=Z93Cm/pqJCTfoBFO1+c0PbkRrs7zUpJNV0ZkQnxbF1k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=swjGqCCfdAbWZI/FIIpImPv9ppSKsNhhrBj0qPHd9vV4kE3hlDDfC0l0nEFih3nqW
	 goJUDznUpSJjVgzejLLd+yZYjrziWOlsC1d3EBDMHHBdVJAeYzE6f9cy61TDq576bT
	 ZFVXS3obEyjab1VNYncWUU8zuG1EFaoEN+rLMtzce4L1+ztPgmaQaQixvKFxYUx9n4
	 VK9ixu9BRGIzTUlnmL72h56WBoVNLr1IrWOS0FFElviR+BXMQGW7P91XqrcPAWr6Mg
	 orOO5cXVp85fBPadNwwPRFwzTHsfp3de5pzKCh2C7fTWhe/Br9XrP3P8h4itQhmpg/
	 okNDYgRgV1KTw==
Mime-Version: 1.0
Date: Wed, 02 Aug 2023 06:58:18 +0300
Message-Id: <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
Cc: <code@tyhicks.com>, <nramas@linux.microsoft.com>, <paul@paul-moore.com>
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Tushar Sugandhi" <tusharsu@linux.microsoft.com>, <zohar@linux.ibm.com>,
 <noodles@fb.com>, <bauermann@kolabnow.com>, <ebiederm@xmission.com>,
 <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <kexec@lists.infradead.org>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
In-Reply-To: <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_205827_018188_674DFB13 
X-CRM114-Status: GOOD (  15.00  )
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

T24gV2VkIEF1ZyAyLCAyMDIzIGF0IDEyOjAxIEFNIEVFU1QsIFR1c2hhciBTdWdhbmRoaSB3cm90
ZToKPiBUaGFua3MgZm9yIHRoZSByZXNwb25zZSBKYXJra28uCj4KPiBPbiA4LzEvMjMgMTI6MDIs
IEphcmtrbyBTYWtraW5lbiB3cm90ZToKPiA+IFRoZSBzaG9ydCBzdW1tYXJ5IGlzIGNyeXB0aWMg
dG8gc2F5IHRoZSBsZWFzdC4KPiBEbyB5b3UgbWVhbiB0aGUgcGF0Y2ggc3ViamVjdCBsaW5lLCBv
ciB0aGUgZGVzY3JpcHRpb24gYmVsb3c/CgpJdCBpcyBpbiB0aGUgcHJvY2VzcyBkb2N1bWVudGF0
aW9uOgoKaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92Ni4zL3Byb2Nlc3Mvc3VibWl0
dGluZy1wYXRjaGVzLmh0bWwjdGhlLWNhbm9uaWNhbC1wYXRjaC1mb3JtYXQKCj4gPiAidXBkYXRl
IGNvdW50ZXIiIGRvZXMgbm90IG1hcCBpdCB0byBoYXZlIGFueXRoaW5nIHRvIGRvIHdpdGggUENS
cy4KPiBBZ3JlZWQuwqAgSSBub3RpY2VkIHRoYXQgd2hlbiBJIHdhcyB0ZXN0aW5nIHRoZSBwYXRj
aGVzLgo+IFRoZSB1cGRhdGUgY291bnRlciBpcyBzYW1lIGZvciBhbGwgUENScy7CoCBJdCB3YXMg
YWxzbyB0aGUgc2FtZSBmb3IKPiB0aGUgdHdvIGhhc2ggYWxnbydzIEkgdGVzdGVkIGl0IGZvciAo
U0hBMSBhbmQgU0hBMjU2KS4gQnV0IHRoZSBzcGVjCj4gZGVzY3JpcHRpb24gYW5kIEtlcm5lbCBp
bXBsZW1lbnRhdGlvbiByZXF1aXJlcyB0byBwYXNzIHRoZQo+IHBjcl9pZHggYW5kIGhhc2ggYWxn
byB0byBQQ1JfUmVhZCBjb21tYW5kIHRvIGdldCB0aGUgdXBkYXRlIGNvdW50ZXIuCgpJIHdhcyBy
ZWZlcnJpbmcgdG8gdGhlIGZhY3QgdGhhdCBUUE0yX1BDUl9SZWFkIGRvZXMgbm90IGhhdmUgYSBm
aWVsZApjYWxsZWQgInVwZGF0ZSBjb3VudGVyIiBpbiBpdHMgcmVzcG9uc2UgYnV0IGl0IGhhcyBh
IGZpZWxkIGNhbGxlZAoicGNyVXBkYXRlQ291bnRlciIuIFBsZWFzZSByZWZlciB0byB0aGlncyB0
aGF0IGFjdHVhbGx5IGV4aXN0LgoKSW4gdGhlIGxvbmcgZGVzY3JpcHRpb24geW91IGFyZSBpbiBz
b21lIG9jY2FzaW9ucyByZWZlcnJpbmcgdG8gdGhlIHNhbWUKb2JqZWN0IGFzOgoKMS4gInVwZGF0
ZSBjb3VudGVyIgoyLiAicGNyVXBkYXRlQ291bnRlciIKMy4gIlBjclVwZGF0ZUNvdW50ZXIiCgpU
aGlzIGlzIGFtYmlndW91cyBhbmQgd3JvbmcuCgpGcm9tIGxvbmcgZGVzY3JpcHRpb24gSSBzZWUg
emVybyBtb3RpdmF0aW9uIHRvIGFjayB0aGlzIGNoYW5nZSwgZXhjZXB0CnNvbWUgaGVyZXNheSBh
Ym91dCBJTUEgcmVxdWlyaW5nIGl0LiBXaHkgZG9lcyBJTUEgbmVlZCB1cGRhdGVfY250IGFuZAp3
aHkgdGhpcyBpcyBub3QgZG9jdW1lbnRlZCB0byB0aGUgbG9uZyBkZXNjcmlwdGlvbj8KCj4gQnV0
IEkgY2FuIHVwZGF0ZSB0cG0yX3Bjcl9yZWFkKCkgaWYgeW91IGFyZSBvayB3aXRoIGl0Lgo+IFBs
ZWFzZSBsZXQgbWUga25vdy4KCllvdSBjYW4gYWRkICJ1MzIgKnVwZGF0ZV9jbnQiLgoKQlIsIEph
cmtrbwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
