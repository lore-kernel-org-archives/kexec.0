Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0269FC36010
	for <kexec@archiver.kernel.org>; Fri,  4 Apr 2025 05:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:MIME-Version:Date:Message-ID:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ytiwc9QXzR9VaVB1US+GOGp83Z98Cx/zqNhgfzVo6k=; b=UxmAKCV9Byt016FIRlUbOIg9/I
	7SMNYrB0Obt8MiCAT9mIaPgswZdfJ6vVSQlye4nz7IgP3NkYkRjoRvu1q+I4w+5iMOv0HoGaU3sXX
	SxnR1moxJLXWqZDbhMylcMFCzos3qLUtcT1dJ9VdRXyllvHdJmsIgjapKJIlAO1tlQNcESxAr0gs0
	1onv4MPbJhgd6QwTddZJW3cST/xEw1Bl69htCfgyGOsANp+HY7h6h8361/5M+x5F/jomMrsRGeFCf
	K3mH0xxMVHeG9Zx9hi6+Y6bwUTDPsmKh+R/pgLBylDhWUIJvObUtPgWqAJ5EWf9RkKTEKvrjHr/RR
	YaHTu8Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Zwg-0000000Ap68-2YO7;
	Fri, 04 Apr 2025 05:50:26 +0000
Received: from s1.g1.infrastructure.qtmlabs.xyz ([107.172.1.117])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Zwe-0000000Ap2z-16XA
	for kexec@lists.infradead.org;
	Fri, 04 Apr 2025 05:50:25 +0000
Content-Type: multipart/mixed; boundary="------------08L6YdHquZUpv03HEHpbPDhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1743745810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ytiwc9QXzR9VaVB1US+GOGp83Z98Cx/zqNhgfzVo6k=;
	b=HkWrS4lG4mKe4eli15RrfKo6WsOqx2JmVjBov6gUuHXf8P0/0dCu5wzDoMpKWSdaJkQJqP
	TQApk0DgsMM5F5ZTl6tEN0lxx9g/Z4TYTPawLFlDNv5KNidgOR9CTNzr7hI9+wsj/38vi0
	/aQj0iYD4KKdP6VoR7xsZJk12F4sWv90H+HmA3WLohwOBqoJfsQwzPJXJiJTbY1A79Ifuw
	OA0+unqYbrODdbLBy1o7cwk+nUwvctiBsAXi6sV+4FXaKyJVyw1olTBsYWakIY5EAT9Q3Q
	6BSjTAGnOKXd51gCSFMzKCXgoLeuYrTZ3ZNSQ9V19vtJlS0LpK4skaU4gY4j/w==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=msizanoen@qtmlabs.xyz
Message-ID: <4081fbd9-0a5f-49d6-9553-4f964bf5ef27@qtmlabs.xyz>
Date: Fri, 4 Apr 2025 12:50:03 +0700
MIME-Version: 1.0
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
From: msizanoen <msizanoen@qtmlabs.xyz>
To: Roberto Ricci <io@r-ricci.it>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
 ytcoode@gmail.com, kexec@lists.infradead.org, linux-pm@vger.kernel.org,
 akpm@linux-foundation.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <Z4WFjBVHpndct7br@desktop0a> <Z4WGSMdF6seQm9GV@desktop0a>
 <b9f6ed5a-74b9-47c0-b073-9922dbe6119b@qtmlabs.xyz>
 <Z-8E-LLs1dFWfn6J@desktop0a>
 <691be719-7d4c-4cb1-87d6-cca7834547fe@qtmlabs.xyz>
 <004d85e4-d23d-43af-87ca-8d037abba51d@qtmlabs.xyz>
Content-Language: en-US
In-Reply-To: <004d85e4-d23d-43af-87ca-8d037abba51d@qtmlabs.xyz>
X-Spamd-Bar: +
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_225024_380662_5DDE8607 
X-CRM114-Status: GOOD (  14.57  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This is a multi-part message in MIME format.
--------------08L6YdHquZUpv03HEHpbPDhB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Here's an updated version of the patch that better handles pathological 
e820 tables.

On 4/4/25 11:56, msizanoen wrote:
> Also, can you reproduce this issue with a target kernel (the kernel 
> being kexec-ed) that has one of the patches attached (select the 
> correct one according to your kernel version) applied, with either 
> kexec_load or kexec_file_load?
>
> On 4/4/25 09:54, msizanoen wrote:
>> Can you send the dmesg logs for this case (6.13 + mentioned patch 
>> series backported as target kernel, using kexec_load)?
>>
>> On 4/4/25 05:00, Roberto Ricci wrote:
>>> On 2025-04-01 19:59 +0700, msizanoen wrote:
>>>> [snip]
>>>> It seems like `e820__register_nosave_regions` is erroneously 
>>>> marking some
>>>> kernel memory as nosave in the presence of sub-page e820 regions. 
>>>> In theory
>>>> backporting
>>>> https://lore.kernel.org/all/20250214090651.3331663-1-rppt@kernel.org/ 
>>>> should
>>>> be sufficient to avoid this but a fix for the actual root cause is
>>>> preferred.
>>> When using kexec_file_load, this patch series fixes the issue not only
>>> in theory but also in practice.
>>> But the issue with kexec_load (see
>>> https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
>>> ), which might be related, is not fixed.
--------------08L6YdHquZUpv03HEHpbPDhB
Content-Type: text/x-patch; charset=UTF-8; name="for-6.14-and-earlier-v2.diff"
Content-Disposition: attachment; filename="for-6.14-and-earlier-v2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9lODIwLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
ZTgyMC5jCmluZGV4IDQ4OTNkMzBjZTQzOC4uNWQ5NjNkZjYzYjdhIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvZTgyMC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9lODIwLmMKQEAg
LTc1NCwyMiArNzU0LDIxIEBAIHZvaWQgX19pbml0IGU4MjBfX21lbW9yeV9zZXR1cF9leHRl
bmRlZCh1NjQgcGh5c19hZGRyLCB1MzIgZGF0YV9sZW4pCiB2b2lkIF9faW5pdCBlODIwX19y
ZWdpc3Rlcl9ub3NhdmVfcmVnaW9ucyh1bnNpZ25lZCBsb25nIGxpbWl0X3BmbikKIHsKIAlp
bnQgaTsKLQl1bnNpZ25lZCBsb25nIHBmbiA9IDA7CisJdTY0IGxhc3RfYWRkciA9IDA7CiAK
IAlmb3IgKGkgPSAwOyBpIDwgZTgyMF90YWJsZS0+bnJfZW50cmllczsgaSsrKSB7CiAJCXN0
cnVjdCBlODIwX2VudHJ5ICplbnRyeSA9ICZlODIwX3RhYmxlLT5lbnRyaWVzW2ldOwogCi0J
CWlmIChwZm4gPCBQRk5fVVAoZW50cnktPmFkZHIpKQotCQkJcmVnaXN0ZXJfbm9zYXZlX3Jl
Z2lvbihwZm4sIFBGTl9VUChlbnRyeS0+YWRkcikpOwotCi0JCXBmbiA9IFBGTl9ET1dOKGVu
dHJ5LT5hZGRyICsgZW50cnktPnNpemUpOwotCiAJCWlmIChlbnRyeS0+dHlwZSAhPSBFODIw
X1RZUEVfUkFNICYmIGVudHJ5LT50eXBlICE9IEU4MjBfVFlQRV9SRVNFUlZFRF9LRVJOKQot
CQkJcmVnaXN0ZXJfbm9zYXZlX3JlZ2lvbihQRk5fVVAoZW50cnktPmFkZHIpLCBwZm4pOwor
CQkJY29udGludWU7CiAKLQkJaWYgKHBmbiA+PSBsaW1pdF9wZm4pCi0JCQlicmVhazsKKwkJ
aWYgKGxhc3RfYWRkciA8IGVudHJ5LT5hZGRyKQorCQkJcmVnaXN0ZXJfbm9zYXZlX3JlZ2lv
bihQRk5fVVAobGFzdF9hZGRyKSwgUEZOX0RPV04oZW50cnktPmFkZHIpKTsKKworCQlsYXN0
X2FkZHIgPSBlbnRyeS0+YWRkciArIGVudHJ5LT5zaXplOwogCX0KKworCXJlZ2lzdGVyX25v
c2F2ZV9yZWdpb24oUEZOX1VQKGxhc3RfYWRkciksIGxpbWl0X3Bmbik7CiB9CiAKICNpZmRl
ZiBDT05GSUdfQUNQSQo=
--------------08L6YdHquZUpv03HEHpbPDhB
Content-Type: text/x-patch; charset=UTF-8; name="for-master-v2.diff"
Content-Disposition: attachment; filename="for-master-v2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9lODIwLmMgYi9hcmNoL3g4Ni9rZXJuZWwv
ZTgyMC5jCmluZGV4IDU3MTIwZjA3NDljYy4uNjU2ZWQ3YWJkMjhkIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvZTgyMC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9lODIwLmMKQEAg
LTc1MywyMiArNzUzLDIxIEBAIHZvaWQgX19pbml0IGU4MjBfX21lbW9yeV9zZXR1cF9leHRl
bmRlZCh1NjQgcGh5c19hZGRyLCB1MzIgZGF0YV9sZW4pCiB2b2lkIF9faW5pdCBlODIwX19y
ZWdpc3Rlcl9ub3NhdmVfcmVnaW9ucyh1bnNpZ25lZCBsb25nIGxpbWl0X3BmbikKIHsKIAlp
bnQgaTsKLQl1bnNpZ25lZCBsb25nIHBmbiA9IDA7CisJdTY0IGxhc3RfYWRkciA9IDA7CiAK
IAlmb3IgKGkgPSAwOyBpIDwgZTgyMF90YWJsZS0+bnJfZW50cmllczsgaSsrKSB7CiAJCXN0
cnVjdCBlODIwX2VudHJ5ICplbnRyeSA9ICZlODIwX3RhYmxlLT5lbnRyaWVzW2ldOwogCi0J
CWlmIChwZm4gPCBQRk5fVVAoZW50cnktPmFkZHIpKQotCQkJcmVnaXN0ZXJfbm9zYXZlX3Jl
Z2lvbihwZm4sIFBGTl9VUChlbnRyeS0+YWRkcikpOwotCi0JCXBmbiA9IFBGTl9ET1dOKGVu
dHJ5LT5hZGRyICsgZW50cnktPnNpemUpOwotCiAJCWlmIChlbnRyeS0+dHlwZSAhPSBFODIw
X1RZUEVfUkFNKQotCQkJcmVnaXN0ZXJfbm9zYXZlX3JlZ2lvbihQRk5fVVAoZW50cnktPmFk
ZHIpLCBwZm4pOworCQkJY29udGludWU7CiAKLQkJaWYgKHBmbiA+PSBsaW1pdF9wZm4pCi0J
CQlicmVhazsKKwkJaWYgKGxhc3RfYWRkciA8IGVudHJ5LT5hZGRyKQorCQkJcmVnaXN0ZXJf
bm9zYXZlX3JlZ2lvbihQRk5fVVAobGFzdF9hZGRyKSwgUEZOX0RPV04oZW50cnktPmFkZHIp
KTsKKworCQlsYXN0X2FkZHIgPSBlbnRyeS0+YWRkciArIGVudHJ5LT5zaXplOwogCX0KKwor
CXJlZ2lzdGVyX25vc2F2ZV9yZWdpb24oUEZOX1VQKGxhc3RfYWRkciksIGxpbWl0X3Bmbik7
CiB9CiAKICNpZmRlZiBDT05GSUdfQUNQSQo=

--------------08L6YdHquZUpv03HEHpbPDhB--

