Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94365C4332F
	for <kexec@archiver.kernel.org>; Sat, 11 Nov 2023 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fB8zwJ10roNLnGRGthvjNV+IpKfD2fMWLm0OnUjk0qo=; b=m9/w9nSm6nbSaO
	uk0zdxG6AXeQG1U+Tq8wDVQQGC+2O3hZOQWY/eQnrUBLz5zmO+jZo0vi856RKOWiSC0Szst1lnqso
	hn7YVPXPcDGKnzUuohFHiMJR5I4zCGl0D6WYAWd2Yc9M7J6304IBnoM03+3jXwjODdR1DrWBq0mZi
	FBJAjpbdzAFBd/tBSlLOslDKpQBPdMkfInusHXRWZP9/BhUUFUwHFNCvJ+4mNYOfz7NaD3QY/p0fu
	tCSutBsGB7RGB5itI1jovLOdWXZ1cCWFg+aKWTSWBf0T63Zb/wnO4ONi4qseNHO2/oIISUEI5Dra9
	oEj8mrxfmV6tEnWbFBMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1sZi-00BFEf-0r;
	Sat, 11 Nov 2023 18:19:18 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1sZf-00BFEG-0o
	for kexec@lists.infradead.org;
	Sat, 11 Nov 2023 18:19:17 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so1794599f8f.0
        for <kexec@lists.infradead.org>; Sat, 11 Nov 2023 10:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1699726753; x=1700331553; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AwX19YfB6xOhuhaF7AppkIuMTVamx0JcuT0ZkB4r4gk=;
        b=acVuwx74XCew+eV+4cUz9wrHpdJreHUPaPPfQmZ4r2g2UGFUhDGvsep3Uqx0dry8kz
         RSGTUi3GIJndlqqWGus6kiibXpu1wssOV/mxhIA3Zj7FKVQlyvjCM0btz3m30YvDSXWG
         NplNNmt9lTlt9fLhS4vKZ0jQoH3S9ttDVOiuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699726753; x=1700331553;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwX19YfB6xOhuhaF7AppkIuMTVamx0JcuT0ZkB4r4gk=;
        b=LcThAtfslgaQr0fEKEALREGrrkLzHAd1i9JQOm5ZEGVRYwzITiDZEXPRiRlZaouhWK
         TaZ/fnDVwx35TWkRUHx3aIxeeHBr8mcCGCQ7tZXIIuoin19WU8YOYwi+Tlpc63k3Q8NQ
         WmiJbV0Uc7OLrGVF7mFgpaoAdkW1GJAe+S/X6lcfNVxO71h66USFGuEqKhUoLysjqlBS
         hN46GIdNJsejE5Vq7IcLL4o9WnhR8BOHLs9cGTt8nxOc/18+IOTaVSCn2WmdnY9QGRpf
         wDRmCDJ9UNXhBE8E418VIX3bG/Z+UcnhQnMxdLZhhq6RSZs6kV22y2aayWuWErTPEki7
         PpJg==
X-Gm-Message-State: AOJu0YxopMXigz44N8I5CBqPP8NzgUdmyO02LszTMJI0gR7hz4QwBg1p
	vWS242jnzc59o4PsuC2M28PZuQ==
X-Google-Smtp-Source: AGHT+IHg5soWlnqBqQeGVF4JBHuusXQx/LK1k/VZf2vI1qK7tIwInDyjuvITGYsQf3WL7k0RSZyESQ==
X-Received: by 2002:a5d:5a87:0:b0:32f:7d50:62f8 with SMTP id bp7-20020a5d5a87000000b0032f7d5062f8mr7611665wrb.3.1699726753314;
        Sat, 11 Nov 2023 10:19:13 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-107-252.as13285.net. [92.26.107.252])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c1d8b00b003fe15ac0934sm6453897wms.1.2023.11.11.10.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 10:19:13 -0800 (PST)
Message-ID: <a16d44c5-2e1a-4e9a-8ca1-c7ca564f61cd@citrix.com>
Date: Sat, 11 Nov 2023 18:19:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-GB
To: Eric Biggers <ebiggers@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org,
 dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, luto@amacapital.net,
 nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20231110222751.219836-1-ross.philipson@oracle.com>
 <20231110222751.219836-7-ross.philipson@oracle.com>
 <20231111174435.GA998@sol.localdomain>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20231111174435.GA998@sol.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231111_101915_639320_DB8E020C 
X-CRM114-Status: GOOD (  11.26  )
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

T24gMTEvMTEvMjAyMyA1OjQ0IHBtLCBFcmljIEJpZ2dlcnMgd3JvdGU6Cj4gT24gRnJpLCBOb3Yg
MTAsIDIwMjMgYXQgMDU6Mjc6NDRQTSAtMDUwMCwgUm9zcyBQaGlsaXBzb24gd3JvdGU6Cj4+ICBh
cmNoL3g4Ni9ib290L2NvbXByZXNzZWQvZWFybHlfc2hhMS5jICAgfCAxMiArKysrCj4+ICBsaWIv
Y3J5cHRvL3NoYTEuYyAgICAgICAgICAgICAgICAgICAgICAgfCA4MSArKysrKysrKysrKysrKysr
KysrKysrKysrCj4gSXQncyBzdXJwcmlzaW5nIHRvIHN0aWxsIHNlZSB0aGlzIG5ldyB1c2Ugb2Yg
U0hBLTEgYWZ0ZXIgc28gbWFueSBwZW9wbGUgb2JqZWN0ZWQKPiB0byBpdCBpbiB0aGUgdjYgcGF0
Y2hzZXQuICBJdCdzIGFsc28gZnJ1c3RyYXRpbmcgdGhhdCB0aGUgU0hBLTEgc3VwcG9ydCBpcyBz
dGlsbAo+IGJlaW5nIG9iZnVzY2F0ZWQgYnkgYmVpbmcgY29tYmluZWQgaW4gb25lIHBhdGNoIHdp
dGggU0hBLTIgc3VwcG9ydCwgcGVyaGFwcyBpbgo+IGFuIGF0dGVtcHQgdG8gY29uZmxhdGUgdGhl
IHR3byBhbGdvcml0aG1zIGFuZCBhdm9pZCBoYXZpbmcgdG8gZ2l2ZSBhIHJhdGlvbmFsZQo+IGZv
ciB0aGUgaW5jbHVzaW9uIG9mIFNIQS0xLiAgRmluYWxseSwgbmV3IGZ1bmN0aW9ucyBzaG91bGQg
bm90IGJlIGFkZGVkIHRvCj4gbGliL2NyeXB0by9zaGExLmMgdW5sZXNzIHRob3NlIGZ1bmN0aW9u
cyBoYXZlIG11bHRpcGxlIHVzZXJzLgoKVGhlIHJhdGlvbmFsIHdhcyBnaXZlbi7CoCBMZXQgbWUg
cmVpdGVyYXRlIGl0LgoKVGhlcmUgYXJlIHJlYWwgVFBNcyBpbiB0aGUgd29ybGQgdGhhdCBjYW4n
dCB1c2UgU0hBLTIuwqAgVGhlIHVzZSBvZiBTSEEtMQppcyBuZWNlc3NhcnkgdG8gc3VwcG9ydCBE
UlRNIG9uIHN1Y2ggc3lzdGVtcywgYW5kIHRoZXJlIGFyZSByZWFsIHVzZXJzCm9mIHN1Y2ggY29u
ZmlndXJhdGlvbnMuCgpEUlRNIHdpdGggU0hBLTEtb25seSBpcyBhIGRhbW5zaWdodCBiZXR0ZXIg
dGhhbiBubyBEVFJNLCBldmVuIGlmIFNIQS0xCmlzIGdldHRpbmcgYSBsaXR0bGUgbG9uZyBpbiB0
aGUgdG9vdGguCgpTbyB1bmxlc3MgeW91IGhhdmUgYSBjcmVkaWJsZSBwbGFuIHRvIHVwZ3JhZGUg
ZXZlcnkgbm9uLVNIQS0yIFRQTSBpbiB0aGUKd29ybGQsIHlvdSBhcmUgZGVsaWJlcmF0ZWx5IGJy
ZWFraW5nIHBhcnQgb2YgdGhlIHVzZWNhc2UgcGF5aW5nIGZvciB0aGUKZWZmb3J0IG9mIHRyeWlu
ZyB0byB1cHN0cmVhbSBEUlRNIHN1cHBvcnQgaW50byBMaW51eC4KCn5BbmRyZXcKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
