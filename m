Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B01C61D85
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GJxN93BqYHWb2HdneyawV+VduJ431cMoVi+jSZjK2Go=; b=BcSOpJ9ryGHcdM
	YB0Q0SWezbzWqy8Wu3u16vKyJakeNDAaYKdGZQl7zKN8I1/rctz2vR4CAZkE/VLZm6gLUcUQRp0Sw
	WOw4loI9vjr4KY/tdAp4gcB3p1fKM0NfC43sw0VZSqXqRx2QyD7ClnBrDsYmGMdMV5LkuNFrn8WyE
	zK4YsO2Z2cm+wgZLwyNMz5o+cu2H+mfV/Ju0urry5wt4u88VRAVZEsV5kI41lsf1yRcjz0f5ajxgo
	qTlH/wSHMCs47mGthafAC+MF7jCQlzZPs5cDrJBmwYJ3JoeONnOO0sJkdVj7/oxq1fOkJPOCOByiR
	rAufSmoRm7h7yzR+S+ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6505-00486D-3C;
	Thu, 23 Nov 2023 08:23:53 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6501-00484V-2s
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 08:23:51 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2856254bd74so341622a91.2
        for <kexec@lists.infradead.org>; Thu, 23 Nov 2023 00:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700727826; x=1701332626; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxyQvllrMD+S9nUR2i6XqgEe1Uz/MXq2oi0l9PmN/sI=;
        b=Dun52iCmt2lDIYhKtW8CH/Cpfn7wXJPiwAERjBFcYEOE9Kq771yoDy+FsAwaUt1xcr
         MDBhgiF3rBUFQ3sRhuzAQnTPUMjWtbsnh4YgzejzP40LCFYEs7hbIN7JkUnkSYshJGfs
         nhiJ8OM9bF6+aTyBhd2XPVfG/RsISRZVHNBf6klKdwOSl0D/bCM0Gacw9RvGMXxSwAGT
         XucKAOspj9rMssIbMu23/T9Gu6aqXDzI+Jf82Ay+MYUasPMqJPj/FcH0CnP/UJID6nmu
         Fh3vqXhs3lyVWHsn5oJ5c6pXghlGf+rwloeFzr/1QHhBFkrik+ho83hPxMVF4ajf/U7N
         nwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700727826; x=1701332626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxyQvllrMD+S9nUR2i6XqgEe1Uz/MXq2oi0l9PmN/sI=;
        b=OXTkrXpdIO8Kp8AqbnyS3JseNYzBeJexrLIM5NAJxGDeE3WaaabaNmTm+j8jIjlvAS
         8tMW8Dy//2dMh18dBomqILwZqvfBz+Gmn9+xMLfuDyBoAeF3W8E0cwcwMzwIWDZ3lzcd
         e7wNjDdm01NsKnV/uwYPLBW8nkhII9orawcIWeC4W+l6ZbIjenRxPULZ+yONmyu/V4wG
         b8E1+/5pSdOviXE0TtvSGjlF362huG74SkpSAyP25Iogm0Gexnu+a5N6HYUDtGkdMIFD
         Bw0ehNFs7XMb43Plaitn2WJMd1Fh9Q40q4tTclRlI6pXwN5JNTCWQF09BKmOsgCZlyoT
         w6WA==
X-Gm-Message-State: AOJu0YxEGp98Cn62PO/bKIb3GwzhdbERP01878zVKA/c68AjNfe3FxzA
	TaodWZfOcI2WEMZurwc7Md/s8cyVMHz6UGiAPQnlZg==
X-Google-Smtp-Source: AGHT+IFi7qsrLCSSOcApqa1ERtzIeHUoDbf3aFgi2HK5T0smIgc+93Gp6aWh+OLekkrorVduK4kKcUAuqv35kcpbqDE=
X-Received: by 2002:a17:90b:3803:b0:27d:882f:e6c5 with SMTP id
 mq3-20020a17090b380300b0027d882fe6c5mr4440955pjb.9.1700727825600; Thu, 23 Nov
 2023 00:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20231123073652.507034-1-bhe@redhat.com> <20231123073652.507034-2-bhe@redhat.com>
In-Reply-To: <20231123073652.507034-2-bhe@redhat.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Thu, 23 Nov 2023 08:23:34 +0000
Message-ID: <CALrw=nEO3A2MPeSXhO3=cPdrAFB07sQcnjNN5V5jj2YcqAZ+bQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
	akpm@linux-foundation.org, eric_devolder@yahoo.com, 
	kernel-team <kernel-team@cloudflare.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_002349_932934_51A4381E 
X-CRM114-Status: GOOD (  21.60  )
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

T24gVGh1LCBOb3YgMjMsIDIwMjMgYXQgNzozN+KAr0FNIEJhb3F1YW4gSGUgPGJoZUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IElnbmF0IEtvcmNoYWdpbiBjb21wbGFpbmVkIHRoYXQgYSBwb3RlbnRp
YWwgY29uZmlnIHJlZ3Jlc3Npb24gd2FzCj4gaW50cm9kdWNlZCBieSBjb21taXQgODljZGU0NTU5
MTVmICgia2V4ZWM6IGNvbnNvbGlkYXRlIGtleGVjIGFuZAo+IGNyYXNoIG9wdGlvbnMgaW50byBr
ZXJuZWwvS2NvbmZpZy5rZXhlYyIpLiBCZWZvcmUgdGhlIGNvbW1pdCwKPiBDT05GSUdfQ1JBU0hf
RFVNUCBoYXMgbm8gZGVwZW5kZW5jeSBvbiBDT05GSUdfS0VYRUMuIEFmdGVyIHRoZSBjb21taXQs
Cj4gQ1JBU0hfRFVNUCBzZWxlY3RzIEtFWEVDLiBUaGF0IGVuZm9yY2VzIHN5c3RlbSB0byBoYXZl
IENPTkZJR19LRVhFQz15Cj4gYXMgbG9uZyBhcyBDT05GSUdfQ1JBU0hfRFVNUD1ZIHdoaWNoIHBl
b3BsZSBtYXkgbm90IHdhbnQuCj4KPiBJbiBJZ25hdCdzIGNhc2UsIGhlIHNldHMgQ09ORklHX0NS
QVNIX0RVTVA9eSwgQ09ORklHX0tFWEVDX0ZJTEU9eSBhbmQKPiBDT05GSUdfS0VYRUM9biBiZWNh
dXNlIGtleGVjX2xvYWQgaW50ZXJmYWNlIGNvdWxkIGhhdmUgc2VjdXJpdHkgaXNzdWUgaWYKPiBr
ZXJuZWwvaW5pdHJkIGhhcyBubyBjaGFuY2UgdG8gYmUgc2lnbmVkIGFuZCB2ZXJpZmllZC4KPgo+
IENSQVNIX0RVTVAgaGFzIHNlbGVjdCBvZiBLRVhFQyBiZWNhdXNlIEVyaWMsIGF1dGhvciBvZiBh
Ym92ZSBjb21taXQsCj4gbWV0IGEgTEtQIHJlcG9ydCBvZiBidWlsZCBmYWlsdXJlIHdoZW4gcG9z
dGluZyBwYXRjaCBvZiBlYXJsaWVyIHZlcnNpb24uCj4gUGxlYXNlIHNlZSBiZWxvdyBsaW5rIHRv
IGdldCBkZXRhaWwgb2YgdGhlIExLUCByZXBvcnQ6Cj4KPiAgICAgaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzNlOGVlY2QxLWEyNzctMmNmYi02OTBlLTVkZTJlYjdiOTg4ZUBvcmFjbGUuY29t
L1QvI3UKPgo+IEluIGZhY3QsIHRoYXQgTEtQIHJlcG9ydCBpcyB0cmlnZ2VyZWQgYmVjYXVzZSBh
cm0ncyA8YXNtL2tleGVjLmg+IGlzCj4gd3JhcHBlZCBpbiBDT05GSUdfS0VYRUMgaWZkZWZmZXJ5
IHNjb3BlLiBUaGF0IGlzIHdyb25nLiBDT05GSUdfS0VYRUMKPiBjb250cm9scyB0aGUgZW5hYmxp
bmcvZGlzYWJsaW5nIG9mIGtleGVjX2xvYWQgaW50ZXJmYWNlLCBidXQgbm90IGtleGVjCj4gZmVh
dHVyZS4gUmVtb3ZpbmcgdGhlIHdyb25nbHkgYWRkZWQgQ09ORklHX0tFWEVDIGlmZGVmZmVyeSBz
Y29wZSBpbgo+IDxhc20va2V4ZWMuaD4gb2YgYXJtIGFsbG93cyB1cyB0byBkcm9wIHRoZSBzZWxl
Y3QgS0VYRUMgZm9yIENSQVNIX0RVTVAuCgpIbS4uLiBXaXRoIHRoZSBwYXRjaCwgd2hlbiBjcm9z
cyBjb21waWxpbmcgZm9yIGFybSBhbmQKQ09ORklHX0tFWEVDX0NPUkU9eQojIENPTkZJR19LRVhF
QyBpcyBub3Qgc2V0CkNPTkZJR19DUkFTSF9EVU1QPXkKCkkgZ2V0IHRoZSBmb2xsb3dpbmcgbGlu
a2VyIGVycm9yIGF0IHRoZSBlbmQ6CgogIENBTEwgICAgc2NyaXB0cy9jaGVja3N5c2NhbGxzLnNo
CiAgVVBEICAgICBpbmNsdWRlL2dlbmVyYXRlZC91dHN2ZXJzaW9uLmgKICBDQyAgICAgIGluaXQv
dmVyc2lvbi10aW1lc3RhbXAubwogIExEICAgICAgLnRtcF92bWxpbnV4LmthbGxzeW1zMQphcm0t
bGludXgtZ251ZWFiaS1sZDoga2VybmVsL2tleGVjX2NvcmUubzogaW4gZnVuY3Rpb24gYGtpbWFn
ZV9mcmVlJzoKa2V4ZWNfY29yZS5jOigudGV4dCsweGY1Yyk6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYG1hY2hpbmVfa2V4ZWNfY2xlYW51cCcKYXJtLWxpbnV4LWdudWVhYmktbGQ6IGtlcm5lbC9r
ZXhlY19jb3JlLm86IGluIGZ1bmN0aW9uIGBfX2NyYXNoX2tleGVjJzoKa2V4ZWNfY29yZS5jOigu
dGV4dCsweDE1YmMpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBtYWNoaW5lX2NyYXNoX3NodXRk
b3duJwphcm0tbGludXgtZ251ZWFiaS1sZDoga2V4ZWNfY29yZS5jOigudGV4dCsweDE1YzQpOiB1
bmRlZmluZWQgcmVmZXJlbmNlCnRvIGBtYWNoaW5lX2tleGVjJwphcm0tbGludXgtZ251ZWFiaS1s
ZDoga2VybmVsL2tleGVjX2NvcmUubzogaW4gZnVuY3Rpb24gYGtlcm5lbF9rZXhlYyc6CmtleGVj
X2NvcmUuYzooLnRleHQrMHgxYTA0KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgbWFjaGluZV9r
ZXhlYycKbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLnZtbGludXg6Mzc6IHZtbGludXhd
IEVycm9yIDEKbWFrZVsxXTogKioqIFsvaG9tZS9pZ25hdC9naXQvbGludXgtdXBzdHJlYW0vTWFr
ZWZpbGU6MTE1NDogdm1saW51eF0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjIzNDogX19z
dWItbWFrZV0gRXJyb3IgMgoKPiBTaWduZWQtb2ZmLWJ5OiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0
LmNvbT4KPiAtLS0KPiAgYXJjaC9hcm0vaW5jbHVkZS9hc20va2V4ZWMuaCB8IDQgLS0tLQo+ICBr
ZXJuZWwvS2NvbmZpZy5rZXhlYyAgICAgICAgIHwgMSAtCj4gIDIgZmlsZXMgY2hhbmdlZCwgNSBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9rZXhlYy5o
IGIvYXJjaC9hcm0vaW5jbHVkZS9hc20va2V4ZWMuaAo+IGluZGV4IGU2MjgzMmRjYmE3Ni4uYTgy
ODdlN2FiOWQ0IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2tleGVjLmgKPiAr
KysgYi9hcmNoL2FybS9pbmNsdWRlL2FzbS9rZXhlYy5oCj4gQEAgLTIsOCArMiw2IEBACj4gICNp
Zm5kZWYgX0FSTV9LRVhFQ19ICj4gICNkZWZpbmUgX0FSTV9LRVhFQ19ICj4KPiAtI2lmZGVmIENP
TkZJR19LRVhFQwo+IC0KPiAgLyogTWF4aW11bSBwaHlzaWNhbCBhZGRyZXNzIHdlIGNhbiB1c2Ug
cGFnZXMgZnJvbSAqLwo+ICAjZGVmaW5lIEtFWEVDX1NPVVJDRV9NRU1PUllfTElNSVQgKC0xVUwp
Cj4gIC8qIE1heGltdW0gYWRkcmVzcyB3ZSBjYW4gcmVhY2ggaW4gcGh5c2ljYWwgYWRkcmVzcyBt
b2RlICovCj4gQEAgLTgyLDYgKzgwLDQgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgcGFnZSAqYm9v
dF9wZm5fdG9fcGFnZSh1bnNpZ25lZCBsb25nIGJvb3RfcGZuKQo+Cj4gICNlbmRpZiAvKiBfX0FT
U0VNQkxZX18gKi8KPgo+IC0jZW5kaWYgLyogQ09ORklHX0tFWEVDICovCj4gLQo+ICAjZW5kaWYg
LyogX0FSTV9LRVhFQ19IICovCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9LY29uZmlnLmtleGVjIGIv
a2VybmVsL0tjb25maWcua2V4ZWMKPiBpbmRleCA3YWZmMjhkZWQyZjQuLjFjYzNiMWM1OTVkNyAx
MDA2NDQKPiAtLS0gYS9rZXJuZWwvS2NvbmZpZy5rZXhlYwo+ICsrKyBiL2tlcm5lbC9LY29uZmln
LmtleGVjCj4gQEAgLTk3LDcgKzk3LDYgQEAgY29uZmlnIENSQVNIX0RVTVAKPiAgICAgICAgIGRl
cGVuZHMgb24gQVJDSF9TVVBQT1JUU19LRVhFQwo+ICAgICAgICAgc2VsZWN0IENSQVNIX0NPUkUK
PiAgICAgICAgIHNlbGVjdCBLRVhFQ19DT1JFCj4gLSAgICAgICBzZWxlY3QgS0VYRUMKPiAgICAg
ICAgIGhlbHAKPiAgICAgICAgICAgR2VuZXJhdGUgY3Jhc2ggZHVtcCBhZnRlciBiZWluZyBzdGFy
dGVkIGJ5IGtleGVjLgo+ICAgICAgICAgICBUaGlzIHNob3VsZCBiZSBub3JtYWxseSBvbmx5IHNl
dCBpbiBzcGVjaWFsIGNyYXNoIGR1bXAga2VybmVscwo+IC0tCj4gMi40MS4wCj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
