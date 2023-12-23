Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A30DC3DA6E
	for <kexec@archiver.kernel.org>; Sat, 23 Dec 2023 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i+NsxPYvCOqC0IYPqoFKtULTtvt/PgiNZLRhuJbxIzE=; b=KgLv5r16APwmk0
	qJDjyS/oEFD+EeHSQA6RMZb9nAan+oEEHeqeSWNp1x2W20oxz2uOOx+LWjI0DYpVUEUOgtCUU3jPP
	x5UsRkg6zK17XDM+nTKV2Lw6cv25FmdiNR/yBA8frNUF5EYnbuDUP/9/o6YKqdEuLUWkeKtGsXD8j
	kgD6G/9YqDFYVPoGIa0YVe2YL5Bw/h3Du3TWcbHZMPCnp0MLLpYpqthZn6Tf5jWo9EHFlXoF2thaQ
	UJsxotv0olW+zn/+J10LQS+LH7VlYDw9dtBS0AFkLECk88VX1YwegLNizDSddK/kVLdLJg4Fyf4Mg
	Clx1f9NizZlY49d+nuvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rH3xO-0086sB-0L;
	Sat, 23 Dec 2023 15:30:30 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rH3xL-0086rc-1R;
	Sat, 23 Dec 2023 15:30:28 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3333b46f26aso2475175f8f.1;
        Sat, 23 Dec 2023 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703345425; x=1703950225; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRh4LSoHPvR5hdO5Fh4hn7/CMtmNDbR5Zs1aa9AeKus=;
        b=N7RVjaoiD1Udw58fHgk8xMXjV3vQKeE1DPErps7LhVTX1VgEDkqQsteVBpHFJ2zQ5K
         6PwFzB7DTLd53mqeS+F7TXa3Vpy6YSTI8XX4wuV2spc0zKszQ9CttAnclyZjvv5vVDPU
         pcntdFTuPgRgg4xFZA/8MWMnvQyKmV7kJCbcCSVr9gCIr8iUsIO3HYAYJSRGlwXpAJwV
         WcqFV3hyeGcilbOX34enW5CAjgvMqV1kKmZvaZN8A+QXO0Ittr1om4TNS1V/57IBw3z+
         36RSs67NtZDM090+PlsddIUB46EvR+HZ6oQY2LP9aGTL8bScMcRuXq8xGwTXfzReXWdk
         eDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703345425; x=1703950225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRh4LSoHPvR5hdO5Fh4hn7/CMtmNDbR5Zs1aa9AeKus=;
        b=KfREE7GEeHwZmwTj0mKKyrz63uCu8aAjYsXMauLG/1W6I3NMEMDsaZP5ye7jn0tb8r
         jY7SN7AjgNdBa8OCEzzUGDujOXaqfGfOHUw9ZmRha/mwxf3RkkgF//qv7C8Jm6TjfIPJ
         Wl2G03eLSyKxXdrFUpAsl3qyl4Ewh58MwXeeHboQ33hMQjZbrqxgYxi6vYMhEDvJxpXj
         muugJmGxeQm4099AcDuaHFn6U24D0clroIa+knuoWZmIWfxy0pR68j+vr+cBPYFt4deJ
         6Z0EWfeOpavdXppmy2tjdrkjnOlHaJhpD9JqOAwkThn4nHaFvJ2g9FrTHnZ40zlCYIqZ
         LeVw==
X-Gm-Message-State: AOJu0YzvgIT5c3P/4M8eUmIPDGKmVzSRtuE1Cg7Z6aeoIxVlxaVC8fL8
	BHOZ97U8NeM7v6xqDmev4g6nYkmR2hDG1DfVwLU=
X-Google-Smtp-Source: AGHT+IEdfVGa/VwDeS9ks0Tsxsmh8hu0lbBLVkXTWtxNMMhXDGu1jTLRO9WwzGyAMnf101w7LiNfXUf6rf/woEX5aug=
X-Received: by 2002:adf:e790:0:b0:333:41a0:ef39 with SMTP id
 n16-20020adfe790000000b0033341a0ef39mr1807515wrm.105.1703345424949; Sat, 23
 Dec 2023 07:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20231221130930.32634-1-ruipengqi7@gmail.com> <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
 <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com>
 <6fe05804-da74-45cd-a6f1-df4644671d99@linaro.org> <CADHLONE2YnBJGJUp2-vn_XEpc7+quTMWF7y1zpV0ygeL2VpQxA@mail.gmail.com>
In-Reply-To: <CADHLONE2YnBJGJUp2-vn_XEpc7+quTMWF7y1zpV0ygeL2VpQxA@mail.gmail.com>
From: ruipeng qi <ruipengqi7@gmail.com>
Date: Sat, 23 Dec 2023 23:30:13 +0800
Message-ID: <CADHLONHHZAeubePPfZbG1N0Nv3ZJM5OWaJWqchBUpiN5Q27UdQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, zalbassam@google.com, dianders@chromium.org, 
	mark.rutland@arm.com, lecopzer.chen@mediatek.com, maz@kernel.org, 
	arnd@arndb.de, yury.norov@gmail.com, brauner@kernel.org, mcgrof@kernel.org, 
	maninder1.s@samsung.com, michael.christie@oracle.com, samitolvanen@google.com, 
	linux-arm-kernel@lists.infradead.org, qiruipeng@lixiang.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231223_073027_491441_D6F6BD03 
X-CRM114-Status: UNSURE (   8.74  )
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

T24gU2F0LCBEZWMgMjMsIDIwMjMgYXQgMTE6MTPigK9QTSBydWlwZW5nIHFpIDxydWlwZW5ncWk3
QGdtYWlsLmNvbT4gd3JvdGU6Cgo+ID4gSSBkb24ndCBzZWUgYSBwcm9ibGVtIHdoeSBtaW5pZHVt
cCBjYW5ub3QgZG8gaXQuCj4gUWNvbSBtaW5pZHVtcCBhbGxvd3Mgb25lIGtlcm5lbCBjbGllbnQg
dG8gcmVnaXN0ZXIgaXRzIHJlZ2lvbiB0byBkdW1wLCBhbmQgdGhlbgo+IGRyaXZlciB3aWxsIGNy
ZWF0ZSBhbmQgbWFpbnRhaW4gb25lIGVsZiBoZWFkIGZvciBpdC4KPiBCdXQgb3NkdW1wIHdpbGwg
ZHVtcCB0aG91c2FuZHMgb2Ygbm9uLWNvbnRpbnVvdXMgcmVnaW9ucy4gSWYgeW91IHJlZ2lzdGVy
IG9uZQo+IGJ5IG9uZSwgYW5kIGFkZCBhbiBlbGYgaGVhZCBmb3IgZWFjaCwgaXQgd2lsbCBjYXVz
ZSBoZWF2eSBvdmVyaGVhZC4gU28gaXQgc3RvcmUKPiBkYXRhIGluIGJpbmFyeSwgYW5kIHJlYXNz
ZW1ibGUgYSBzdGFuZGFyZCBlbGYgZm9ybWF0IGZpbGUgb2ZmbGluZSBmb3IgZGVidWcuCj4KT3Nk
dW1wIHdpbGwgb25seSBkdW1wIHVzZWZ1bCBkYXRhLCB3aGljaCBtYXkgaGF2ZSBiZWVuIGFsbG9j
YXRlZCBiZWZvcmUgYnV0CmZyZWVkIG5vdy4gSW4gYSB3b3JkLCB1c2VmdWwgZGF0YSBhcmUgY2hh
bmdpbmcgYWxsIHRoZSB0aW1lLiBJIHRoaW5rIHRoaXMgaXMgbm90CnN1aXRhYmxlIGZvciBRY29t
IG1pbmlkdW1wJ3MgZnJhbWV3b3Jr44CCCgpCZXN0IFJlZ2FyZHMKUnVpcGVuZwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
