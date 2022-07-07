Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE74C433EF
	for <kexec@archiver.kernel.org>; Thu,  7 Jul 2022 23:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2xbc+2CNQLPn41pOfv4pMUM/DLoJ2MO2pF4XLP7Y12s=; b=Nu5iPyQmxPiHre
	8N4SHldc0fYkIxA9Bfic8qTo7FyRXBLa2Jzp7cmt/rA7B9x/qz4liHKCsyn4qB4/amSIuD5Trp9xA
	pnGy5xwV0S+NjMulU8x6My0MJjhDPuM+05GLxL/Lq8NTnK10dTDhxb/RAWRz0N8QiIPyeuYVSWmaU
	hRPLGlAaJpz6TirvzKMHcVgr9rE33AGszKGxloj+VKErKdAWeVQAias+i3un4ym1PnmkzuyDTAgV/
	6BdtrcvaJKJeKXJz6py2kB8KGzs23pbG9eiTOt5uagDub02N9w76OitDWdx2mJgIL9Bpr0ugxOzt0
	8P8iMVtUVnh3+CMJh7yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9bGq-000hD5-Sa; Thu, 07 Jul 2022 23:50:56 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9bGn-000hCl-Hy
	for kexec@lists.infradead.org; Thu, 07 Jul 2022 23:50:55 +0000
Received: by mail-wr1-x431.google.com with SMTP id bk26so13303120wrb.11
        for <kexec@lists.infradead.org>; Thu, 07 Jul 2022 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=glYe1llh4n+rbmi4V6B2Mqs1aDtdgNFAYvpdpFFTObI=;
        b=hL30sFUur8jowhJ/PnVIbYIsyLpopzsMOvsJBK3DhwljDzNEAfLiR9YMt8eNiqru2W
         Y54TBRmud0yAxOtxKrcLM/lBEmBTPFfhqpTZIFKKQM1mRmnc9nsZZVBzUhRCxcINaNT7
         v/8K/xSA+GDMsuACrJfO52FIrnJ1U2utcwxAVwLQWCENk4GZMuFJGqBrBRYPF8PgwQWT
         flcbzln7ESjK/rGyUkAlbD7LrEZadmIibFx0/HZLekMcDHZA2hxa+bUoNCwkIJKzoja1
         SgSe8DD7E+tCYNP+18qYpSoTQd4xfrxRPPyfnGhE8Fyao6HYyWvtmC5+z4G6wjzAC9+k
         TBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=glYe1llh4n+rbmi4V6B2Mqs1aDtdgNFAYvpdpFFTObI=;
        b=wZ88U7B5YYlP4f+eclKVZSzVQZZSlVeLbH/nRb9PYZK3CDZqH0KnT2QRkjRo4Cfq94
         DxTc6sp17T4e8QMQQTdUYmONx9ZubJULF9a478VQTAqUDGW/igM+NDcmHaYvbxj1Pr6J
         1+xXl387NRQ6gtOBhB1XMpiF+KSnbIbRBVD6MHktf3l/7AAsS2WOA6gyffshQ/fbTWwJ
         ajqMgkmzQBdwiNCwKwbLf1upWgavuwk1tbc7AkCiKaRvAOPnBE6CCq/3kgBVtuplvS99
         pDqoHCIag4ZDgvuUDbX3qquj0Ngvz9SY1utyCVYMSLreoC4+nhYQp51X38urfOF5q0I+
         TTNA==
X-Gm-Message-State: AJIora85a/Lt+ECh+QWirL9VH+9Xex77PyLOw3rZKdAKP0K2S5CXfUZS
	X9TszScRCQL++GeloSCXCnoBrqNLvJw=
X-Google-Smtp-Source: AGRyM1sSdCcr35K5RyBzPf0V7hYBTlp5T0J5GxBVERguvefZ4eTGHoDCDnyXkLYFdwWiw6ZIHut4+w==
X-Received: by 2002:a5d:48cf:0:b0:210:1229:2e7 with SMTP id p15-20020a5d48cf000000b00210122902e7mr370752wrs.567.1657237850487;
        Thu, 07 Jul 2022 16:50:50 -0700 (PDT)
Received: from opensuse.localnet (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c23ca00b003a2c67aa6c0sm348158wmb.23.2022.07.07.16.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:50:49 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] kexec: Replace kmap() with kmap_local_page()
Date: Fri, 08 Jul 2022 01:50:35 +0200
Message-ID: <3183776.44csPzL39Z@opensuse>
In-Reply-To: <20220707231412.1404-1-fmdefrancesco@gmail.com>
References: <20220707231412.1404-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_165053_649402_B76601CA 
X-CRM114-Status: GOOD (  13.21  )
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

T24gdmVuZXJkw6wgOCBsdWdsaW8gMjAyMiAwMToxNDoxMiBDRVNUIEZhYmlvIE0uIERlIEZyYW5j
ZXNjbyB3cm90ZToKPiBUaGUgdXNlIG9mIGttYXAoKSBhbmQga21hcF9hdG9taWMoKSBhcmUgYmVp
bmcgZGVwcmVjYXRlZCBpbiBmYXZvciBvZgo+IGttYXBfbG9jYWxfcGFnZSgpLgo+IAo+IFdpdGgg
a21hcF9sb2NhbF9wYWdlKCksIHRoZSBtYXBwaW5ncyBhcmUgcGVyIHRocmVhZCwgQ1BVIGxvY2Fs
IGFuZCBub3QKPiBnbG9iYWxseSB2aXNpYmxlLiBGdXJ0aGVybW9yZSwgdGhlIG1hcHBpbmdzIGNh
biBiZSBhY3F1aXJlZCBmcm9tIGFueQo+IGNvbnRleHQgKGluY2x1ZGluZyBpbnRlcnJ1cHRzKS4K
PiAKPiBUaGVyZWZvcmUsIHVzZSBrbWFwX2xvY2FsX3BhZ2UoKSBpbiBrZXhlY19jb3JlLmMgYmVj
YXVzZSB0aGVzZSBtYXBwaW5ncyAKYXJlCj4gcGVyIHRocmVhZCwgQ1BVIGxvY2FsLCBhbmQgbm90
IGdsb2JhbGx5IHZpc2libGUuCj4gCj4gVGVzdGVkIG9uIGEgUUVNVSArIEtWTSAzMi1iaXRzIFZN
IGJvb3RpbmcgYSBrZXJuZWwgd2l0aCBISUdITUVNNjRHQgo+IGVuYWJsZWQuCj4gCj4gU3VnZ2Vz
dGVkLWJ5OiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTog
RmFiaW8gTS4gRGUgRnJhbmNlc2NvIDxmbWRlZnJhbmNlc2NvQGdtYWlsLmNvbT4KPiAtLS0KPiAK
PiB2MS0+djI6IEEgc2VudGVuY2Ugb2YgdGhlIGNvbW1pdCBtZXNzYWdlIGNvbnRhaW5lZCBhbiBl
cnJvciBkdWUgdG8gYQo+IG1pc3Rha2UgaW4gY29weS1wYXN0aW5nIGZyb20gYSBwcmV2aW91cyBw
YXRjaC4gUmVwbGFjZSAiYWlvLmMiIHdpdGgKPiAia2V4ZWNfY29yZS5jIi4KPiAKPiAga2VybmVs
L2tleGVjX2NvcmUuYyB8IDggKysrKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKPiAKU29ycnksIGFub3RoZXIgZXJyb3IuLi4gUGxlYXNlIGRp
c2NhcmQgdGhpcyBwYXRjaCBiZWNhdXNlIHRoZSB2ZXJzaW9uIApudW1iZXIgaXMgbWlzc2luZyBp
biB0aGUgc3ViamVjdC4KClRoZSBzZWNvbmQgdmVyc2lvbiwgaG9wZWZ1bGx5IGZpbmFsIGFuZCBj
b3JyZWN0LCBpcyBhdApodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIwNzA3MjMxNTUw
LjE0ODQtMS1mbWRlZnJhbmNlc2NvQGdtYWlsLmNvbS8KClRoYW5rIHlvdSwKCkZhYmlvCgoKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
