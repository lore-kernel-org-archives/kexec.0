Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB66EC76196
	for <kexec@archiver.kernel.org>; Mon,  3 Apr 2023 19:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6dGhqCSM5EHwTpcAQ40LkdwJ4nYqsgOKgfn0uxIjExs=; b=svuRmrOECYxg96
	elM80eN8hXwPj8zWbgD5XuUwTlK6cAkMKesC9sHJ1lzKQc8Tih1ehyFtxEQ9nu7mc+lsemnjn+63W
	yna36rExLwo0gStus7KqBZVQB/TVakYs5yMVVSs9wtHuiLg8h0J+O5lXcgUqBoax3kiqIEYhW1SNu
	bEbbYC7xItb/KxHiHjasY0ipCfRZkEvUa2g7RNKWb3W35WSgsLe0bzFjK6TT6xeC9WKGyTD6a+sOQ
	WQI3mrPRLU2tBb4GWZBOoFOt3izTHhDRHVsHzsUzHrSzAzG4bFmNa6qEtF2g1QuDN+lF/KLMyXWQG
	29F295cJzGpCOxHeKxUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjQ8T-00GSaK-1u;
	Mon, 03 Apr 2023 19:46:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjQ8R-00GSYq-32
	for kexec@bombadil.infradead.org;
	Mon, 03 Apr 2023 19:46:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=32740/cMAYm8/THAakLpza6FUQDhvi2xnglpmtIgpUI=; b=pIMB7eZAR7/JjrLaMK6dbwyjBy
	IaQEcZkxTT0HhNcfZuZV07r/Hnc8z287Dx5DDT7Sx1O5Tl0/CY2N8lpLRdxMZ89tA6+92xMknLYAH
	lW8gMJxqKtPVRzQ1dktKBZ7HiW7Cjg8dQD9cIqguVyBpFJUr+/SevM1Ain1CRY8KFr33sveSX/oYq
	wVCvoFAS9VNWhCafKHW5JOGRdAjQf/7BtFE7hk6HKETKbujUgMsPQCutFEZrXg/qEmd4oUpJHG/WN
	smWpB5KUqsrVa2m/Wr5qFBzpqxIj7mzq2sBuswLaeFvGv/OoLXbCbAZHSd6dKPbeaS7/vb4fUN9QX
	8j26IFDg==;
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjMDV-008unf-0Q
	for kexec@lists.infradead.org;
	Mon, 03 Apr 2023 15:35:36 +0000
Received: by mail-pl1-x636.google.com with SMTP id z19so28412300plo.2
        for <kexec@lists.infradead.org>; Mon, 03 Apr 2023 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680536119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32740/cMAYm8/THAakLpza6FUQDhvi2xnglpmtIgpUI=;
        b=kZSDskwVVVzdtMyx7OA2mZB85IWG3DBMQDw/p2e37xpuOpfuJGOSpD8LEYzXicYhsy
         hlJHkAuWIWaarfXIZ6aI/v+pxFUEeVIr4btwWhtr1S7aZIFM8IUKJb+YZM/NqdYHzBY2
         h9PCEegjuw17hSj0GGN89lhEUeF05TsUdFDw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32740/cMAYm8/THAakLpza6FUQDhvi2xnglpmtIgpUI=;
        b=uLC3ZSui+w4Al5pAgZatCyskoyJTGyF/4NGMXHBbxqX0AQLHRuxvqXjyhcXHMXlNyf
         Aw7DjvrOsxGst0xHjTpaAFTzyuYEcMfqA9GwSuAXAkWpbFEyyLf3cLC1sXJkv2g/+yB4
         TBLaXGYbe2w2edZmnzduonJzbkPeP5eRv888F0Bcme6yFHXERhxsflzTTu/miXgGD5Tk
         FlidiEBCDj20Vx+J4d2/zjQhGCfIGnGQb6B+i0wqlh3naud4RoK4DNEe2YseFEcQTB0H
         7spAku9iNCSOVESh7TZ3GBHAfoO9LBfha+Sb7wmHxCnsxGP0B+3ItDCh/Jz1fgfXwsAd
         yqow==
X-Gm-Message-State: AAQBX9fN3nb7hvFEBTaOLp+vHcrsqHxncCYtU4XakN2va7if+Fx1SiIg
	i/s7MUDjtyEGYa9BQr0+JTd1KPclhngsaa606eQ=
X-Google-Smtp-Source: AKy350bWkFN1ANByzpKIxsy94rIFf8nEs+36WXzWlomtR4vuxVdiF6ee2ekLf80MKW2XxQslOl3w5Q==
X-Received: by 2002:a17:90a:1a17:b0:23b:45be:a15a with SMTP id 23-20020a17090a1a1700b0023b45bea15amr38568236pjk.25.1680536119668;
        Mon, 03 Apr 2023 08:35:19 -0700 (PDT)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com. [209.85.210.177])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090abb0300b0023371cb020csm9845858pjr.34.2023.04.03.08.35.18
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:35:18 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id cu12so19436008pfb.13
        for <kexec@lists.infradead.org>; Mon, 03 Apr 2023 08:35:18 -0700 (PDT)
X-Received: by 2002:a63:a102:0:b0:513:97bc:5757 with SMTP id
 b2-20020a63a102000000b0051397bc5757mr4528550pgf.4.1680536118030; Mon, 03 Apr
 2023 08:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
 <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org> <CAGRrVHx4S0VxMQ-76i3sQQNLUBKbHr_wJdLhJ8F9D6R=UoCLAA@mail.gmail.com>
In-Reply-To: <CAGRrVHx4S0VxMQ-76i3sQQNLUBKbHr_wJdLhJ8F9D6R=UoCLAA@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 3 Apr 2023 17:35:06 +0200
X-Gmail-Original-Message-ID: <CANiDSCv5eKGgQ3f6jstoo9X0Je3T63waVrPH3nth4-280+rcdw@mail.gmail.com>
Message-ID: <CANiDSCv5eKGgQ3f6jstoo9X0Je3T63waVrPH3nth4-280+rcdw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
To: Ross Zwisler <zwisler@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Simon Horman <horms@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_163533_365285_A8E0CF48 
X-CRM114-Status: GOOD (  17.83  )
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

SGkgUm9zcwoKT24gRnJpLCAzMSBNYXIgMjAyMyBhdCAyMToxNCwgUm9zcyBad2lzbGVyIDx6d2lz
bGVyQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gVGh1LCBNYXIgMzAsIDIwMjMgYXQgMzo0NeKA
r0FNIFJpY2FyZG8gUmliYWxkYSA8cmliYWxkYUBjaHJvbWl1bS5vcmc+IHdyb3RlOgo+ID4gTWFr
ZSBzdXJlIHRoYXQgdGhlIC50ZXh0IHNlY3Rpb24gaXMgbm90IGRpdmlkZWQgaW4gbXVsdGlwbGUg
b3ZlcmxhcHBpbmcKPiA+IHNlY3Rpb25zLiBUaGlzIGlzIG5vdCBzdXBwb3J0ZWQgYnkga2V4ZWNf
ZmlsZS4KPgo+IEhvdyBkb2VzIHRoaXMgaW50ZXJhY3Qgd2l0aCBwYXRjaCAjMSBmcm9tIHRoaXMg
c2VyaWVzLCB3aGljaCBJSVVDCj4gYWxsb3dzIHVzIHRvIGhhbmRsZSB0aGUgY2FzZSB3aGVyZSB0
aGUgLnRleHQgc2VjdGlvbiBpcyBzcGxpdCBiZXR3ZWVuCj4gLnRleHQgYW5kIC50ZXh0LmhvdD8g
IERvIHdlIHN0aWxsIG5lZWQgdGhhdCBwYXRjaCwgYnV0IG9ubHkgZm9yCj4gbm9uLXg4NiBwbGF0
Zm9ybXM/ICBPciBkbyB3ZSBuZWVkIGJvdGgsIGFuZCB0aGlzIHBhdGNoIHdpbGwgbmVlZCB0byBi
ZQo+IHJlcGxpY2F0ZWQgZm9yIG90aGVyIGFyY2hlcz8KClBhdGNoIDEvMiBpcyBhIG11c3QuIFBh
dGNoIDIvMiBpcyBhIG5pY2VfdG9faGF2ZSBhbmQgd291bGQgYmUgZ3JlYXQgdG8KaGF2ZSBhIHNp
bWlsYXIgcGF0Y2ggZm9yIGV2ZXJ5IGFyY2guLi4gYnV0IEkgZG8gbm90IGZlZWwgY29uZmlkZW50
CmVub3VnaCB0byBzZW5kIGl0IGZvciBldmVyeSBhcmNoIDopCgpJZiB3ZSBoYXZlIGxpbmtlciBz
Y3JpcHRzIGZvciBhbGwgdGhlIGFyY2hlcyBkbyB3ZSBuZWVkIDEvMj8KSSB0aGluayBzbywgYmVj
YXVzZSB0aGUgdXNlciBtaWdodCB3YW50IHRvIGxvYWQgYSBrZXJuZWwgPDYuNCBidWlsdAp3aXRo
IGNsYW5nID4gMTYuCgpSZWdhcmRzIQoKCi0tIApSaWNhcmRvIFJpYmFsZGEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
