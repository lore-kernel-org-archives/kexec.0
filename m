Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC392C04A6A
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O2qcqeubLmw6qhrQh+SXaZNsy1GVcmrgYz/dl6c5FPM=; b=KB99HnX4q7Fw7U
	ZeU33UlaaUkhlCvJgZinSqcdgvMVe9h4rntaxwe1risaFneX1h9NdDAPp2BOTiTaGXr8lOHfMKur+
	FDh0bmbMkWahYTYxb9/zVrmBjZNcoWY+YueKs/qIDKiKl+OEQn9w38wp2TFfeH/YYYuGXsIPywf/u
	PdY6+KaRTI/N13+WpXzSF65GAUWw/Z/SoHR/SpA020SxviuBUxJXBaH7/zR+3OhvXAZh2fuXq5x5m
	3uVKFnsnMUFnr3GtYq3iNcMQhNblgbjm0vohRPE9rdXZrFUWq9o3FoidVsDlzVvzs3Sx4Q+gPmE78
	bIFrX1Z50MEWSIGlpQBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRe1n-00Ak8J-1O;
	Thu, 03 Aug 2023 19:30:31 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRe1g-00Ak7i-1Q
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 19:30:29 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 58E9A207F594;
	Thu,  3 Aug 2023 12:30:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 58E9A207F594
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1691091021;
	bh=TKSKfqlVS6X4NQLJSx6LD4t4ILTBcwpO2TA3mdti8zY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TJa7+o0FiIKVVPzEyvc8YOgLBAortchjyrMZXATUI8sdXSO35hqiwGrrZy2mFOD/W
	 ZXj7AyuztmuJGP/x+xf6D5+eklbKi975XllNOuXXXSRVGK0QegEFROzR9B8Q+mvgLL
	 +vBGWUj8ZffKQ5m/PGiYd6zV5l0HZbXtAq+hAPYk=
Message-ID: <7913a162-3da3-61b4-49ce-8e762da47966@linux.microsoft.com>
Date: Thu, 3 Aug 2023 12:30:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, zohar@linux.ibm.com, noodles@fb.com,
 bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
 vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de, jgg@ziepe.ca,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
 <dd126081-3216-c15e-124e-ef137b376cdb@linux.microsoft.com>
 <CUIRWHEMXL38.29Z2XR564KV33@suppilovahvero>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CUIRWHEMXL38.29Z2XR564KV33@suppilovahvero>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_123027_102319_436D6879 
X-CRM114-Status: GOOD (  11.68  )
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

Ck9uIDgvMy8yMyAwMTo0MywgSmFya2tvIFNha2tpbmVuIHdyb3RlOgo+IE9uIFRodSBBdWcgMywg
MjAyMyBhdCAxMjowNCBBTSBFRVNULCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4+IEJ0dywgdGhl
IGZ1bmN0aW9uIHRwbTJfcGNyX3JlYWQgaXMgbm90IGV4cG9zZWQgZGlyZWN0bHkgdG8gdGhlIG90
aGVyCj4+IHN1YnN5c3RlbXMgKGxpa2UgSU1BKS7CoCBJdCBpcyBleHBvc2VkIHZpYSB0cG1fcGNy
X3JlYWQuCj4+Cj4+IERvIHlvdSB3YW50IHRvIGV4cG9zZSB0cG0yX3Bjcl9yZWFkIGRpcmVjdGx5
LAo+PiBvciBkbyB5b3Ugd2FudCBtZSB0byB1cGRhdGUgdGhlIGZ1bmN0aW9uIHNpZ25hdHVyZSBv
ZiB0cG1fcGNyX3JlYWQgYXMgd2VsbD8KPiBBcyBsb25nIGFzIHlvdSBtZW50aW9uIHRoYXQgJ3Vw
ZGF0ZV9jbnQnIGNhdXNlcyBkaXZlZ2VuY2UgaW4gdGhlCj4gaW4ta2VybmVsIEFQSSwgYW5kIHRo
ZXJlZm9yZSB0cG1bMTJdX3Bjcl9yZWFkKCkgY2Fubm5vdCBiZSB1bmRlciB0aGUKPiBzYW1lIG9y
Y2hlc3RyYXRvci4KWXVwLiBJIHdpbGwgbWVudGlvbiB0aGF0IGluIHRoZSBkZXNjcmlwdGlvbi9j
b21tZW50Lgo+Cj4gSWYgeW91IHRha2UgdGhpcyBwYXRoLCBwbGVhc2UgaW1wbGVtZW50IGEgcHJl
Y3Vyc29yeSBwYXRjaCwgd2hpY2gKPiByZXBsYWNlIHRoZSBleGlzdGluZyBjYWxsIHNpdGVzIHdp
dGggc29tZSBzZXF1ZW5jZSBvZiB0cG1bMTJdX3Bjcl9yZWFkKCkKPiBhbmQgdHBtX2lzX3RwbTIo
KSBjYWxscy4KU3VyZS7CoCBJIHdpbGwgYWRkIGEgcHJlY3Vyc29yeSBwYXRjaCB3aGljaCB3aWxs
IHJlcGxhY2UgdGhlIGV4aXN0aW5nCmNhbGwgc2l0ZXMuCgpUaGFua3MgZm9yIGNvbmZpcm1pbmcg
dGhlIGFwcHJvYWNoLgoKflR1c2hhcgo+IEJSLCBKYXJra28KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
