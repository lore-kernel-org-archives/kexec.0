Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640A9EB64DC
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 04:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hlX/oBfnufdoMiG4/0+N3zYoP/wUa9JhNbXXWBnID6c=; b=35E37HfAV0piyY
	J0hJbDr+lYG3m/v2r3JPl6QqXC8LzAo5M6cNhfHrKMQCtQ+2dj8x1jXYNPwBwF+qW79BzXJ7vt9/C
	eGe459PUrP0XjxrfY/N/Ax1/l+pb0hIcB9zJ73Oq66rHEZXPZzDV3IyzgyjWB2Q8SsWK4pIVF295l
	PJJ5AR50IeY9s6SSvrTVajOrR+9Ks0R1ufhU+sNryOK2N6/Tjk6RJNYuECZDt0EsgFIIKQUuZ1jPx
	/HZbYQSaf7UAzkuXrXPyJPtlb0/PHVBLI+L+dv6Iw6p9TiukQrwfgw/pcKaSPn4WqC5KB07d4cdEy
	heDH3JAIemZZyZUJjKMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4dC-00DZLG-06;
	Tue, 11 Jul 2023 04:05:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ4d8-00DZJs-20
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 04:05:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689048337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sanp52G7qe4emaxcQItrkn4g0y24nEg66UbSkbqz794=;
	b=e+Z9cLEzq+yZ4M+eUzzHl1G9CV6nL7emo9Qy+kzQciQ9BDP/ymVgNPUOLVUaaisUVpYQED
	w1yU5zwUEOTdjmAp/6m5g32Y33Y7I3hqd8PZhvt+mTJAExxHB9b2kVvZTUgl94LqRTxsoG
	JtaYX65U+J+9kvga/ayGgt4vfGpasAI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-Yfa5UYHjNiqruSrjTRkO3A-1; Tue, 11 Jul 2023 00:05:36 -0400
X-MC-Unique: Yfa5UYHjNiqruSrjTRkO3A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6351121aa10so55607886d6.0
        for <kexec@lists.infradead.org>; Mon, 10 Jul 2023 21:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689048336; x=1691640336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sanp52G7qe4emaxcQItrkn4g0y24nEg66UbSkbqz794=;
        b=kZFJLzi7kf2qUU9rM0llpAEVPao89FViqEEhlvZ7hhkds6kL0R8WNII57M6bzp4gvA
         7ZnBK73CdOGXqQ1ODew0RFSLJBSTuhc5QFgjlE9dfu8j4a+ryl+HrYJULy/bdgJdj8ux
         aJjB9MjMQbgdesRbRdV1ZYe1R9/p1YrAj5YIqmlcXekMCB7Ne272f5Dl7zOVg9VKHDb4
         Zms9Nge8fPCI5XZr7LoVqIomN+WSz7YEW+RuAipAElLfGB13NHEf4FMq2MLb0HJYobbL
         A3B2VgMYACCg+YIFR/aQMIYhKOg+UBQDDUB04KcpbkXOPvwGq1mkIdiM4rn4TOw2CNVn
         YwkQ==
X-Gm-Message-State: ABy/qLYUt3RQ5CSheP2iTlifHmfw29OLv52CaGGBDZr/MdISAmOYjL7i
	KTBJf9iQ44x2yqi+ZtXf0MW/nlAS1LjAAzNLEl86dSQY7OAvkNcArB8G3j6nM43fGE1mFMiBydU
	F8rmxPHAS5//fPrMK/jV1t0/Ox9T4mgMbA8pH
X-Received: by 2002:a0c:e44d:0:b0:62d:ef66:ff1c with SMTP id d13-20020a0ce44d000000b0062def66ff1cmr12076663qvm.24.1689048335876;
        Mon, 10 Jul 2023 21:05:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGTtnbv4lplqsuwMA0lcF/2QRhbSnqCLDEDGVhD6GZ6v3vRL7xgj3ixm6UdOxJvERNjVYrT8Aw+QUQlev+2Ls=
X-Received: by 2002:a0c:e44d:0:b0:62d:ef66:ff1c with SMTP id
 d13-20020a0ce44d000000b0062def66ff1cmr12076645qvm.24.1689048335643; Mon, 10
 Jul 2023 21:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230708020259.1343736-1-ming.lei@redhat.com> <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de> <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
In-Reply-To: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 11 Jul 2023 12:05:24 +0800
Message-ID: <CAF+s44T5Hn5ikNq+YMp2Nucb6rBT=e4VHW8WN8YDhZHe9JmqGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, 
	Thomas Gleixner <tglx@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_210538_754757_39A70D8C 
X-CRM114-Status: GOOD (  21.50  )
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

SGkgTWluZywKCkhhdmluZyBubyBbUEFUQ0ggMS8yXSBibGstbXE6IGFkZCBibGtfbXFfbWF4X25y
X2h3X3F1ZXVlcygpIGluIGluYm94LgpTbyBJIHJlcGx5IGhlcmUuCgpBdCBmaXJzdCBnbGFuY2Us
IEkgdGhpbmsgdGhhdCAgdGhlIGNwdSBob3QgcGx1ZyBjYWxsYmFjayBob29rIHNob3VsZApiZSB0
aGUgcmVtZWR5IGZvciB0aGUgbmV3bHkgaW50cm9kdWNlZCBibGtfbXFfbWF4X25yX2h3X3F1ZXVl
cygpLAphbHRob3VnaCBpdCBpcyBtb3JlIGNvbXBsaWNhdGVkLgoKQ29uc2lkZXIgdGhlIHNjZW5l
IHdoZXJlIG5yX2NwdXM9NCwgd2hpY2ggY2FuIHNwZWVkIHVwIHRoZSBkdW1waW5nCnByb2Nlc3Ms
IHRoZSBibGtfbXFfbWF4X25yX2h3X3F1ZXVlcygpIGNhbiBub3QgdXRpbGl6ZSB0aGUgb3RoZXIg
dGhyZWUKY3B1cy4KCgpUaGFua3MsCgpQaW5nZmFuCgpPbiBNb24sIEp1bCAxMCwgMjAyMyBhdCA1
OjE24oCvUE0gTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9u
LCBKdWwgMTAsIDIwMjMgYXQgMDg6NDE6MDlBTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3Jv
dGU6Cj4gPiBPbiBTYXQsIEp1bCAwOCwgMjAyMyBhdCAxMDowMjo1OUFNICswODAwLCBNaW5nIExl
aSB3cm90ZToKPiA+ID4gVGFrZSBibGstbXEncyBrbm93bGVkZ2UgaW50byBhY2NvdW50IGZvciBj
YWxjdWxhdGluZyBpbyBxdWV1ZXMuCj4gPiA+Cj4gPiA+IEZpeCB3cm9uZyBxdWV1ZSBtYXBwaW5n
IGluIGNhc2Ugb2Yga2R1bXAga2VybmVsLgo+ID4gPgo+ID4gPiBPbiBhcm0gYW5kIHBwYzY0LCAn
bWF4Y3B1cz0xJyBpcyBwYXNzZWQgdG8ga2R1bXAgY29tbWFuZCBsaW5lLCBzZWUKPiA+ID4gYERv
Y3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2R1bXAva2R1bXAucnN0YCwgc28gbnVtX3Bvc3NpYmxl
X2NwdXMoKQo+ID4gPiBzdGlsbCByZXR1cm5zIGFsbCBDUFVzLgo+ID4KPiA+IFRoYXQncyBzaW1w
bHkgYnJva2VuLiAgUGxlYXNlIGZpeCB0aGUgYXJjaCBjb2RlIHRvIG1ha2Ugc3VyZQo+ID4gaXQg
ZG9lcyBub3QgcmV0dXJuIGEgYm9ndXMgbnVtX3Bvc3NpYmxlX2NwdXMgdmFsdWUgZm9yIHRoZXNl
Cj4KPiBUaGF0IGlzIGRvY3VtZW50ZWQgaW4gRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVt
cC9rZHVtcC5yc3QuCj4KPiBPbiBhcm0gYW5kIHBwYzY0LCAnbWF4Y3B1cz0xJyBpcyBwYXNzZWQg
Zm9yIGtkdW1wIGtlcm5lbCwgYW5kICJtYXhjcHU9MSIKPiBzaW1wbHkga2VlcCBvbmUgb2YgQ1BV
IGNvcmVzIGFzIG9ubGluZSwgYW5kIG90aGVycyBhcyBvZmZsaW5lLgo+Cj4gU28gQ2Mgb3VyIGFy
Y2goYXJtICYgcHBjNjQpICYga2R1bXAgZ3V5cyB3cnQuIHBhc3NpbmcgJ21heGNwdXM9MScgZm9y
Cj4ga2R1bXAga2VybmVsLgo+Cj4gPiBzZXR1cHMsIG90aGVyd2lzZSB5b3UnbGwgaGF2ZSB0byBw
YXBlciBvdmVyIGl0IGluIGFsbCBraW5kIG9mCj4gPiBkcml2ZXJzLgo+Cj4gVGhlIGlzc3VlIGlz
IG9ubHkgdHJpZ2dlcmVkIGZvciBkcml2ZXJzIHdoaWNoIHVzZSBtYW5hZ2VkIGlycSAmCj4gbXVs
dGlwbGUgaHcgcXVldWVzLgo+Cj4KPiBUaGFua3MsCj4gTWluZwo+Cj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGtleGVjIG1haWxpbmcgbGlzdAo+
IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
