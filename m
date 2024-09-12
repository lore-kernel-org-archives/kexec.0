Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E725EED601
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LtVvFzVXXmEAgcKJk6dRYI4XMVV/d/u3ZzgceecVahg=; b=HxhEjW3SQfOi9V
	QCNZcgAlHmO5X80+TSidr6DJ/IN4d4MH2gfRr0lUBtSAcxhNw9n550fnOeAN5x+g56gdy8Xwf4YR7
	JfLER6+j1/qXDXrzftAY6oAfhMzGfE9N3YJd/PcLYMq4v7xJGBQpmYNUdLpOBj5Ee9BF6WxO0gTQ3
	PlgG8JVE3ex1X0fb9CwkZhM/pYdZepJIFEorT2+GXDt4sNkYerzZv/yD85s2R3zR65qApU2RIENqd
	Y/OZanxDTZ+v++0ErSc4LA5RwLgX9pduolelktBUp1Bx75Q9jb51f3oUCFCzUtHI1aiZ3JOXiP4E+
	W78R6NK08P6XcrSUDakg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soiyU-0000000D2LA-2ieY;
	Thu, 12 Sep 2024 12:31:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohp6-0000000Co9L-1ll9
	for kexec@bombadil.infradead.org;
	Thu, 12 Sep 2024 11:17:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=udqUp2dBMuH8FikDBmFuVSTqfSs+UwH1MG42wpMB/w0=; b=Dl0AIdJkqeCPlmteq1NfEuucD3
	VMe1iey8fNt5XYGbsz9VDN9WMybnHwUYM50WDgK3SGv0BC+Fjwh5sAlhNQ5Mm6fI+tQvOaD30iXlu
	yssyNtoPDvcVZ2xC7aCUquL+g0tOQu1vZzpq0OT+4528dDnfoRWk4neUcjXfP/20k3XiF9z+boZVr
	HMQQiTQhDDq8pMBR/DdMzqg8jhueDcq+DURph56BoNdMczvejvhO72DTonU8l2pehA7LsqMNA/3gq
	uC+czeA+RllRxDEV6sVnZYhRCoUsM2aLYFlzva2l+ix2VFCLLevyeWnRTRmqYIJyCNjgjTaglELvD
	8P54tbWQ==;
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sohp2-00000000RUq-2at7
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 11:17:14 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so111729966b.3
        for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726139828; x=1726744628; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udqUp2dBMuH8FikDBmFuVSTqfSs+UwH1MG42wpMB/w0=;
        b=Cx/UnLV8Bsx8PSXq2WE1DM2Gp0SiHEbqOWCYt00NnmvUVZH5A5oXoYbrb7f2MkSoVd
         i098Nz9feObi9nQtlg1qeaYIsejxrzG1VYNfDR7GjbU9jpJFQVVQN3+1jnaQ5Btijb2G
         oqMybUoafgqYDGpBrN4/2nmwbnDuwnV4Zg589fikLkCatMoJB5cvYF9AARhKprUlD8M4
         dbJvc1s+Ey2iVCvwNfCo3GNpThGMkN6WhdWnzM+1wQL2l1kdQaa4/aQIwyt7icl3dJRN
         h3w9hSEwyBhhQU945I4WJTE9mZRdBy1qyiPKIMX4ZE0G2eQhWStZENiSeo+kRWd3ZNL4
         zUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726139828; x=1726744628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udqUp2dBMuH8FikDBmFuVSTqfSs+UwH1MG42wpMB/w0=;
        b=VjIGE1/7sZjEa5hbJT1TTAT5ufD8NF6ggksBZ/m8hiViXxAooY85KNyumAQbqO25HK
         e9EO/tkgnNQ7P9zvX7b5+JsXyXwSmrYAgi8wBZf51yHRTNLY0+VGAM9MPGQ/8DsHhP0i
         wlt9M4fyCdVY8YyNhy4TpuhRi0+2FbJd8iFWM44OMnZ8xtS8qsDLabwVodjkE8zvb+Kq
         J5+3t+yKQBLtFQyWo05TT5Kw70J/yxdR704uxYaAGRvLaDRdGTxmuP8uxrT34uH6+Qd5
         sOvUwsEnRBhDx+a292kc3lQ4VPOp/+/rim9aOhci4i342p6dKhUSTjbmoxcs5TsZOCqp
         jVcw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8bcn9quPXWUjvq/Olu5TtXoS3TUL/c5FwEcN/+EiPEmbSItlUnIzNHX6sFFdD5z662n66g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9RX5G8xR6E2wl2JhL36nMMRgrC3ZXncJ62NWJy7/PrQPhtYqD
	W/u5DUBPzzGyEUp70BTO0+0loIqYa3pIa0iw0qA15Gt0qsMk5BxL
X-Google-Smtp-Source: AGHT+IG8eEbLacNT0/CFp+OSUG23KZhYQVEMcQQAWrhz2GEG2iBTsKC89UtLDqZKQLHhu8M12nUMBA==
X-Received: by 2002:a17:907:724c:b0:a86:8863:2bf0 with SMTP id a640c23a62f3a-a90296c42fdmr233020366b.48.1726139827591;
        Thu, 12 Sep 2024 04:17:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:5725])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25953275sm733979466b.70.2024.09.12.04.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 04:17:07 -0700 (PDT)
Message-ID: <542e0a32-5dfd-4894-b08b-f4cdc49705bc@gmail.com>
Date: Thu, 12 Sep 2024 12:17:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org,
 ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
 tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, leitao@debian.org, rmikey@meta.com,
 gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_121712_836471_1F8F39E1 
X-CRM114-Status: GOOD (  24.29  )
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

CgpPbiAxMi8wOS8yMDI0IDExOjUxLCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiBPbiBUaHUsIDEy
IFNlcHQgMjAyNCBhdCAxMjoyMywgVXNhbWEgQXJpZiA8dXNhbWFhcmlmNjQyQGdtYWlsLmNvbT4g
d3JvdGU6Cj4+Cj4+Cj4+Cj4+IE9uIDExLzA5LzIwMjQgMTI6NTEsIEFyZCBCaWVzaGV1dmVsIHdy
b3RlOgo+Pj4gT24gV2VkLCAxMSBTZXB0IDIwMjQgYXQgMTI6NDEsIFVzYW1hIEFyaWYgPHVzYW1h
YXJpZjY0MkBnbWFpbC5jb20+IHdyb3RlOgo+Pj4+Cj4+Pj4gTG9va2luZyBhdCB0aGUgVFBNIHNw
ZWMgWzFdCj4+Pj4KPj4+PiBJZiB0aGUgQUNQSSBUUE0yIHRhYmxlIGNvbnRhaW5zIHRoZSBhZGRy
ZXNzIGFuZCBzaXplIG9mIHRoZSBQbGF0Zm9ybQo+Pj4+IEZpcm13YXJlIFRDRyBsb2csIGZpcm13
YXJlIOKAnHBpbnPigJ0gdGhlIG1lbW9yeSBhc3NvY2lhdGVkIHdpdGggdGhlCj4+Pj4gUGxhdGZv
cm0gRmlybXdhcmVUQ0cgbG9nLCBhbmQgcmVwb3J0cyB0aGlzIG1lbW9yeSBhcyDigJxSZXNlcnZl
ZOKAnSBtZW1vcnkKPj4+PiB2aWEgdGhlIElOVCAxNWgvRTgyMCBpbnRlcmZhY2UuCj4+Pj4KPj4+
PiBJdCBsb29rcyBsaWtlIHRoZSBmaXJtd2FyZSBzaG91bGQgcGFzcyB0aGlzIGFzIHJlc2VydmVk
IGluIGU4MjAgbWVtb3J5Cj4+Pj4gbWFwLiBIb3dldmVyLCBpdCBkb2Vzbid0IHNlZW0gdG8uIFRo
ZSBmaXJtd2FyZSBiZWluZyB0ZXN0ZWQgb24gaXM6Cj4+Pj4gZG1pZGVjb2RlIC1zIGJpb3MtdmVy
c2lvbgo+Pj4+IGVkazItMjAyNDAyMTQtMi5lbDkKPj4+Pgo+Pj4+IFdoZW4gdGhpcyBhcmVhIGlz
IG5vdCByZXNlcnZlZCwgaXQgY29tZXMgdXAgYXMgdXNhYmxlIGluCj4+Pj4gL3N5cy9maXJtd2Fy
ZS9tZW1tYXAuIFRoaXMgbWVhbnMgdGhhdCBrZXhlYywgd2hpY2ggdXNlcyB0aGF0IG1lbW1hcAo+
Pj4+IHRvIGZpbmQgdXNhYmxlIG1lbW9yeSByZWdpb25zLCBjYW4gc2VsZWN0IHRoZSByZWdpb24g
d2hlcmUgZWZpLnRwbV9sb2cKPj4+PiBpcyBhbmQgb3ZlcndyaXRlIGl0IGFuZCByZWxvY2F0ZV9r
ZXJuZWwuCj4+Pj4KPj4+PiBIYXZpbmcgYSBmaXggaW4gZmlybXdhcmUgY2FuIGJlIGRpZmZpY3Vs
dCB0byBnZXQgdGhyb3VnaC4gQXMgYSBzZWNvbmRhcnkKPj4+PiBmaXgsIHRoaXMgcGF0Y2ggbWFy
a3MgdGhhdCByZWdpb24gYXMgcmVzZXJ2ZWQgaW4gZTgyMF90YWJsZV9maXJtd2FyZSBpZiBpdAo+
Pj4+IGlzIGN1cnJlbnRseSBFODIwX1RZUEVfUkFNIHNvIHRoYXQga2V4ZWMgZG9lc24ndCB1c2Ug
aXQgZm9yIGtlcm5lbCBzZWdtZW50cy4KPj4+Pgo+Pj4+IFsxXSBodHRwczovL3RydXN0ZWRjb21w
dXRpbmdncm91cC5vcmcvd3AtY29udGVudC91cGxvYWRzL1BDLUNsaWVudFBsYXRmb3JtX1Byb2Zp
bGVfZm9yX1RQTV8ycDBfU3lzdGVtc192NDlfMTYxMTE0X3B1YmxpYy1yZXZpZXcucGRmCj4+Pj4K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPgo+
Pj4KPj4+IEkgd291bGQgZXhwZWN0IHRoZSBFRkkgbWVtb3J5IG1hcCB0byBFODIwIGNvbnZlcnNp
b24gaW1wbGVtZW50ZWQgaW4KPj4+IHRoZSBFRkkgc3R1YiB0byB0YWtlIGNhcmUgb2YgdGhpcy4K
Pj4+Cj4+Cj4+IFNvIEkgaGF2ZSBiZWVuIG1ha2luZyBhIHByb3RvdHlwZSB3aXRoIEVGSSBzdHVi
LCBhbmQgdGhlIHVuZmluaXNoZWQgdmVyc2lvbiBpcyBsb29raW5nIGxpa2UgYQo+PiBob3JyaWJs
ZSBoYWNrLgo+Pgo+PiBUaGUgb25seSB3YXkgdG8gZG8gdGhpcyBpbiBsaWJzdHViIGlzIHRvIHBh
c3MgbG9nX3RibCBhbGwgdGhlIHdheSBmcm9tIGVmaV9yZXRyaWV2ZV90Y2cyX2V2ZW50bG9nCj4+
IHRvIGVmaV9zdHViX2VudHJ5IGFuZCBmcm9tIHRoZXJlIHRvIHNldHVwX2U4MjAuCj4+IFdoaWxl
IGdvaW5nIHRocm91Z2ggdGhlIGVmaSBtZW1vcnkgbWFwIGFuZCBjb252ZXJ0aW5nIGl0IHRvIGU4
MjAgdGFibGUgaW4gc2V0dXBfZTgyMCwgeW91IGhhdmUgdG8gY2hlY2sKPj4gaWYgbG9nX3RibCBm
YWxscyBpbiBhbnkgb2YgdGhlIHJhbmdlcyBhbmQgaWYgdGhlIHJhbmdlIGlzIEU4MjBfVFlQRV9S
QU0uIElmIHRoYXQgY29uZGl0aW9uIGlzIHNhdGlzZmllZCwKPj4gdGhlbiB5b3UgaGF2ZSB0byBz
cGxpdCB0aGF0IHJhbmdlIGludG8gMy4gaS5lLiB0aGUgRTgyMF9UWVBFX1JBTSByYW5nZSBiZWZv
cmUgdHBtX2xvZywgdGhlIHRwbV9sb2cKPj4gRTgyMF9UWVBFX1JFU0VSVkVEIHJhbmdlLCBhbmQg
dGhlIEU4MjBfVFlQRV9SQU0gcmFuZ2UgYWZ0ZXIuIFRoZXJlIGFyZSBubyBoZWxwZXIgZnVuY3Rp
b25zLCBzbyB0aGlzCj4+IHNwbGl0dGluZyBpbnZvbHZlcyBwbGF5aW5nIHdpdGggYSBsb3Qgb2Yg
cG9pbnRlcnMsIGFuZCBpdCBsb29rcyBxdWl0ZSB1Z2x5LiBJIGJlbGlldmUgZG9pbmcgdGhpcwo+
PiB3YXkgaXMgbW9yZSBsaWtlbHkgdG8gaW50cm9kdWNlIGJ1Z3MuCj4+Cj4+IElmIHdlIGFyZSBo
YXZpbmcgdG8gY29tcGVuc2F0ZSBmb3IgYW4gRUZJIGJ1Zywgd291bGQgaXQgbWFrZSBzZW5zZSB0
byBkbyBpdCBpbiB0aGUgd2F5IGRvbmUKPj4gaW4gUkZDIGFuZCBkbyBpdCBpbiBrZXJuZWwgcmF0
aGVyIHRoYW4gbGlic3R1Yj8gSXQgaXMgc2ltcGxlIGFuZCB2ZXJ5IGxpa2VseSB0byBiZSBidWcg
ZnJlZS4KPj4KPiAKPiBJIGRvbid0IHNlZSBob3cgdGhpcyBjb3VsZCBiZSBhbiBFRkkgYnVnLCBn
aXZlbiB0aGF0IGl0IGRvZXMgbm90IGRlYWwKPiB3aXRoIEU4MjAgdGFibGVzIGF0IGFsbC4KCgpF
RkkgcGFzc2VzIG1lbW9yeSBkZXNjcmlwdG9ycyB0byBsaWJzdHViLCBsaWJzdHViIGNvbnZlcnRz
IGl0IHRvIGU4MjAuCgpJIGJlbGlldmUgdGhlIHJpZ2h0IGJlaGF2aW91ciBzaG91bGQgYmUgdGhh
dCBFRkkgY3JlYXRlcyBhbiBFRklfUkVTRVJWRURfVFlQRSByZWdpb24gZm9yIAp0aGF0IFRQTSBs
b2cgbWVtb3J5LiBUaGVuIGxpYnN0dWIgd291bGQgYXV0b21hdGljYWxseSBjb252ZXJ0IHRoYXQg
RUZJX1JFU0VSVkVEX1RZUEUKdG8gRTgyMF9UWVBFX1JFU0VSVkVEIGluIHNldHVwX2U4MjAgWzFd
LgoKWzFdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEwLjkvc291cmNlL2Ry
aXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIveDg2LXN0dWIuYyNMNTczCgoKCgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
