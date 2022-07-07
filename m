Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF7CC433EF
	for <kexec@archiver.kernel.org>; Thu,  7 Jul 2022 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8L/+0qfyHaej7GPJxnDf2EdOKqWxW0yjtZDARjxEK+c=; b=5D6vJNJJPr25yJ
	gN2OZXOBzc5UaFNgAcEK1aGEdwMJiTkj679F9SRLkmWBb3CRxIhCigjDhkOkBdsOX/w6fHkiy+Nds
	JL4YvL4RoWdzxUiD9za/po9xHIWrF19EKPpQdHAlBHLYHWC4ubZh6U/KvxakIA+M/B2f4X1b2RyAR
	AGR8lDbuguOoKH9oNCNU5FEOznuEPavLUjw8Hdq6AHAJI7FakEwweo4mNnPbFG2DjgaCvreAvtxrG
	lvrFYHWWC1wePRq8WcJD8ui5+Enp667iCozVRRJnisX53ZzubZdCCsXGx0uLl1e7JxtA+AIESchBb
	g1OPgEMrt1o7P5RA+iww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9b6o-000gYp-3w; Thu, 07 Jul 2022 23:40:34 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9b6k-000gWs-MS
	for kexec@lists.infradead.org; Thu, 07 Jul 2022 23:40:32 +0000
Received: by mail-wm1-x333.google.com with SMTP id h131-20020a1c2189000000b003a2cc290135so201045wmh.2
        for <kexec@lists.infradead.org>; Thu, 07 Jul 2022 16:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lpm5T5rrAKH4mSookDRGpy+67Q9o6aKuYw1+9EoK1vQ=;
        b=KbGt49C9L59Bpvx1m1Ad3LlnQbW/JZFrzQsv5EblzyBkQ9StrftKOHLk00Cgp17eWV
         xmFdWqHX1JAT6vJMmadhxu8XPg3UxRpveHwFJc8Di+aPaT/JEV8x84Ab2yWru7dcLsZS
         l4aBQwOIFMlfD9LWt3Odc6HlB478R4au3yWbekprQy4lYEWHxthrjZtKxWfxLeIGQWHJ
         ExAF0qTUC4tKQ1pFyi9mFFutI1lERYIjiWyduti1cVLEmjnkenWhHvNO065llo6UFw3v
         222bugfioJW1PIy0wHfZ1JujYxqI07UFid569YdDRc+d73HmMFxk/NtOvKN2Zt3Ot6EO
         hksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpm5T5rrAKH4mSookDRGpy+67Q9o6aKuYw1+9EoK1vQ=;
        b=ovkzfgS5FhO3PkAqmK8F84QwqUKbDSHI5roy+PXbxmPrTjjDUVVLJy1qYYP43K7pNI
         GOyDdijmzyqc1VvT7Ii92CNXpcGeAk+nEEaAfQvNuV5lUkNPGTGfpWNj9L5qWWJBRyIh
         G5KLfcXWOETcyDw5zlXbv0ZAmIrZrfHWeWeKJo6AU8TaxbD33mqW5lmV1EVIWSXSZg6I
         ISzF0z/1J+ET4m+QZTM65EmU+TQtnckCvBtowGA/kyCRmQl8NjMzFSVEkukedAl1gCoi
         v8OlC+VsNW2shut/0hMgJ1dmitZf5CaS1BWW9VCzOdysgGxvIE3VyOMMXqIyBAJVWxAC
         0D1g==
X-Gm-Message-State: AJIora9TrMGlxYgLjhA3O2jbehPt+GGvIZJjk9qEkyZuwJEgLYmFfjxN
	rBm8s2KI9cFqNKJ3LHPMonjq1qcDAUs=
X-Google-Smtp-Source: AGRyM1uIddC9eip6lfVZ65ltrxoHMS/51LDdcQmBhhU1DC6ST66K64iAhEXXDGC2WzpO1Yh2n1+S+A==
X-Received: by 2002:a7b:ce8a:0:b0:3a1:8ead:2ae5 with SMTP id q10-20020a7bce8a000000b003a18ead2ae5mr355455wmj.100.1657237228520;
        Thu, 07 Jul 2022 16:40:28 -0700 (PDT)
Received: from opensuse.localnet (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b0039c41686421sm289124wmg.17.2022.07.07.16.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:40:27 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] kexec: Replace kmap() with kmap_local_page()
Date: Fri, 08 Jul 2022 01:40:14 +0200
Message-ID: <4410443.LvFx2qVVIh@opensuse>
In-Reply-To: <20220707184939.6086-1-fmdefrancesco@gmail.com>
References: <20220707184939.6086-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_164030_794482_6DE99F4B 
X-CRM114-Status: GOOD (  12.49  )
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

T24gZ2lvdmVkw6wgNyBsdWdsaW8gMjAyMiAyMDo0OTozOSBDRVNUIEZhYmlvIE0uIERlIEZyYW5j
ZXNjbyB3cm90ZToKPiBUaGUgdXNlIG9mIGttYXAoKSBhbmQga21hcF9hdG9taWMoKSBhcmUgYmVp
bmcgZGVwcmVjYXRlZCBpbiBmYXZvciBvZgo+IGttYXBfbG9jYWxfcGFnZSgpLgo+IAo+IFdpdGgg
a21hcF9sb2NhbF9wYWdlKCksIHRoZSBtYXBwaW5ncyBhcmUgcGVyIHRocmVhZCwgQ1BVIGxvY2Fs
IGFuZCBub3QKPiBnbG9iYWxseSB2aXNpYmxlLiBGdXJ0aGVybW9yZSwgdGhlIG1hcHBpbmdzIGNh
biBiZSBhY3F1aXJlZCBmcm9tIGFueQo+IGNvbnRleHQgKGluY2x1ZGluZyBpbnRlcnJ1cHRzKS4K
PiAKPiBUaGVyZWZvcmUsIHVzZSBrbWFwX2xvY2FsX3BhZ2UoKSBpbiBhaW8uYyBiZWNhdXNlIHRo
ZXNlIG1hcHBpbmdzIGFyZSBwZXIKPiB0aHJlYWQsIENQVSBsb2NhbCwgYW5kIG5vdCBnbG9iYWxs
eSB2aXNpYmxlLgo+IAo+IFRlc3RlZCBvbiBhIFFFTVUgKyBLVk0gMzItYml0cyBWTSBib290aW5n
IGEga2VybmVsIHdpdGggSElHSE1FTTY0R0IKPiBlbmFibGVkLgo+IAo+IFN1Z2dlc3RlZC1ieTog
SXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEZhYmlvIE0u
IERlIEZyYW5jZXNjbyA8Zm1kZWZyYW5jZXNjb0BnbWFpbC5jb20+Cj4gLS0tCj4gIGtlcm5lbC9r
ZXhlY19jb3JlLmMgfCA4ICsrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCj4KUGxlYXNlIGRpc2NhcmQgdGhpcyB2ZXJzaW9uIGJlY2F1c2Ug
dGhlcmUgaXMgYSBzbWFsbCBlcnJvciBpbiB0aGUgY29tbWl0IAptZXNzYWdlIGR1ZSB0byBiYWQg
Y29weSBhbmQgcGFzdGUuIFZlcnNpb24gMiBpcyBhdCAKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC8yMDIyMDcwNzIzMTU1MC4xNDg0LTEtZm1kZWZyYW5jZXNjb0BnbWFpbC5jb20vCgpUaGFu
a3MsCgpGYWJpbwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
