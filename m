Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CB5D1359C
	for <kexec@archiver.kernel.org>; Mon, 28 Oct 2024 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=um/IPJrZnOlLshBAf6VuCJNRYyA0P28S/0Jt/k8GLyk=; b=KBWjqWKcdCYcoY
	YdZft7ADu0humpKbr/STs1wkUSKKgs0W86WGxaDtVw9gX0OCanWwnDywXgBa7bo0mpNEbZdY9gSpy
	AMbWWk20Yf1VVB+kIQjxV3hqRkVBQG4zMqmSJsXlK0CsfIFtwMlvCvdcbBNxGRCcT9dKk318CY2TO
	V2BPOOMH9+M2PZMMN5RJZS/eGLaIp/TCCubnNYQ4/HFr16Ao07teeli0KhicYyti/fr+BD+RAGGwu
	gL9wcrnqIjDZy6QGbBCQhuhek8vjFzUUVGodLuqPYW4kmnwesLaRIJvqK59XLH+PdW8XKOCRD2UrW
	Qx60JUtXSUgKi/T9L1ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5OPz-0000000AeIT-48qO;
	Mon, 28 Oct 2024 12:00:19 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5NJg-0000000AScA-2s83;
	Mon, 28 Oct 2024 10:49:46 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5cbb719839eso3706264a12.2;
        Mon, 28 Oct 2024 03:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730112582; x=1730717382; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BADti5TEboUpz7hQZAwm95LJ4r/iBnqor7lFpH91gUs=;
        b=CiRm2cRaLIY8yXwQhOWdqcJ6m0RYpo0yr/Lyj7TvfbCkDU8dAnxaYIsyjBB00oNCME
         6zd+NPp8355nj0HL2YLT3GXVNoL05W6kaeucqIC/xuL5oNYVEcL9eXUVoAs1bNe8EEqv
         7TCJmrglxqZvQxM5Ma4oCjCXDw0+r02LptcscrPGJH7BOLQem7Tq2V3Iv0L206GKX6IH
         9bA2LPUcsSY/o7zoxJPAT7M7OIM3klc168IYDKoIrVLxHug5pzjE9tKBUnDnj6GFGU60
         bJ1GkVwsGUMAwWyiWGaMU72n+XijP5aRby3PdrSqNZ4kS4w4t7/aWNk4Xci2aclSiLy3
         SCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730112582; x=1730717382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BADti5TEboUpz7hQZAwm95LJ4r/iBnqor7lFpH91gUs=;
        b=qdecB4Pev+dQyxPCcvrS9Q1VPVQQy+qSpKk93zOV75APlxQ86oS+cJoa6rder+leFV
         aVRb44LIIpikN7oJYIhxo9hlg7Pgn7M795tZqXgZDaxkCY3kjCw/9XvCcpLSw85COi2H
         eusb9bHQ7HiP1EyuHl5B0vUd7APj/Z/TpVXz9pGez7yp1Nay/3zjCD2LS+TMBjV/gYLo
         uv4cfYGBaSW6st+TnlSqdVOIF5mEdTAv33yDu9Gudx7ddsFp4WmkjJFK9B+HFKoocWsc
         TSiHorePVX7l5+1HbJSdnkW9FI8I2Ca+jNFyan4jCh9YJgtSoEs48eGbMnc2PVfSWIEE
         27Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUvEzscbC9tjHUWTPSMvA/dQGz3hb3Lx+TYaFchyTxmC/HElJFJT3QNe+Hty97PzSBd6inp9piyRH6TMSY=@lists.infradead.org, AJvYcCX13b5qXtbg8TQYcZNjQvnQU8wrsa3IZ1CWiKygd9IpFV9REzdbK5EJViKSGwKztazOSFYDZVHFRrrxxJT/F+4eRA==@lists.infradead.org, AJvYcCX7ez5ueG4k+2DSG3z8XadXpIQuGXfxNSKYNfeKHcgbOYPKrf74xd2oies7Jzm0sMpJMFt2Ug==@lists.infradead.org
X-Gm-Message-State: AOJu0YysjJi8kb/6vTiD6U/meP77t15g/X8RWNgLxIUdt6/L95hrdW+U
	mBt5yHU5EO3E3EiCljy/YhyhG8QvNaQ0GUwvCQb7+rVJMvUQgB7Q
X-Google-Smtp-Source: AGHT+IEm+HFLbPsaDOWlAHThJ3+XtoGjdhXujglmfhVMP7yNqtZqIoTJpMUXVSYjXbaSqnnT3/SHtw==
X-Received: by 2002:a05:6402:5202:b0:5c9:5cff:3cc2 with SMTP id 4fb4d7f45d1cf-5cbbfa71a66mr5776613a12.29.1730112582021;
        Mon, 28 Oct 2024 03:49:42 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:1494])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6258683sm3063919a12.20.2024.10.28.03.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 03:49:41 -0700 (PDT)
Message-ID: <71decb01-4241-4fb0-bc38-187e180d6ee5@gmail.com>
Date: Mon, 28 Oct 2024 10:49:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] of/fdt: add dt_phys arg to early_init_dt_scan and
 early_init_dt_verify
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org,
 catalin.marinas@arm.com, tglx@linutronix.de, chris@zankel.net,
 saravanak@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-openrisc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-csky@vger.kernel.org
References: <20241023171426.452688-1-usamaarif642@gmail.com>
 <CAL_JsqLBuzRYgnYHCdbdO4wneFNPe5_iEfbehvKK5M7bBuiyfA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAL_JsqLBuzRYgnYHCdbdO4wneFNPe5_iEfbehvKK5M7bBuiyfA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_034944_747397_3DD0A289 
X-CRM114-Status: GOOD (  16.14  )
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

CgpPbiAyNS8xMC8yMDI0IDIzOjE1LCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBXZWQsIE9jdCAy
MywgMjAyNCBhdCAxMjoxNOKAr1BNIFVzYW1hIEFyaWYgPHVzYW1hYXJpZjY0MkBnbWFpbC5jb20+
IHdyb3RlOgo+Pgo+PiAgX19wYSgpIGlzIG9ubHkgaW50ZW5kZWQgdG8gYmUgdXNlZCBmb3IgbGlu
ZWFyIG1hcCBhZGRyZXNzZXMgYW5kIHVzaW5nCj4+IGl0IGZvciBpbml0aWFsX2Jvb3RfcGFyYW1z
IHdoaWNoIGlzIGluIGZpeG1hcCBmb3IgYXJtNjQgd2lsbCBnaXZlIGFuCj4+IGluY29ycmVjdCB2
YWx1ZS4gSGVuY2Ugc2F2ZSB0aGUgcGh5c2ljYWwgYWRkcmVzcyB3aGVuIGl0IGlzIGtub3duIGF0
Cj4+IGJvb3QgdGltZSB3aGVuIGNhbGxpbmcgZWFybHlfaW5pdF9kdF9zY2FuIGZvciBhcm02NCBh
bmQgdXNlIGl0IGF0IGtleGVjCj4+IHRpbWUgaW5zdGVhZCBvZiBjb252ZXJ0aW5nIHRoZSB2aXJ0
dWFsIGFkZHJlc3MgdXNpbmcgX19wYSgpLgo+Pgo+PiBSZXBvcnRlZC1ieTogQnJlbm8gTGVpdGFv
IDxsZWl0YW9AZGViaWFuLm9yZz4KPj4gU3VnZ2VzdGVkLWJ5OiBNYXJrIFJ1dGxhbmQgPG1hcmsu
cnV0bGFuZEBhcm0uY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2
NDJAZ21haWwuY29tPgo+PiBGaXhlczogYWMxMGJlNWNkYmZhICgiYXJtNjQ6IFVzZSBjb21tb24g
b2Zfa2V4ZWNfYWxsb2NfYW5kX3NldHVwX2ZkdCgpIikKPiAKPiBUaGlzIGxvb2tzIGZpbmUsIGJ1
dCB3aGF0IGlzIHRoZSBzeW1wdG9tIHdpdGhvdXQgdGhpcyBjb21wYXJlZCB0bwo+IGJlZm9yZSB0
aGUgYWJvdmUgY2hhbmdlPyBUaGUgb3JpZ2luYWwgY29kZSBpbiB0aGUgcmVmZXJlbmNlZCBjb21t
aXQKPiBhYm92ZSBkaWRuJ3QgcmVtb3ZlIHRoZSByZXNlcnZhdGlvbiBhdCBhbGwuIFVubGVzcyB0
aGUgY3VycmVudCBjb2RlCj4gZG9lcyBzb21ldGhpbmcgd29yc2UsIHRoaXMgaXMgbmV3IGZ1bmN0
aW9uYWxpdHkgbW9yZSB0aGFuIGEgZml4IChmb3IKPiBzdGFibGUpLgo+IAo+IFJvYgoKQWZ0ZXIg
dGhlIHNlcmllcyBpbiBbMV0gd2FzIG1lcmdlZCwgd2UgYWx3YXlzIGdldCBhIHdhcm5pbmcgd2hl
biBrZXhlY2luZwphIGRlYnVnIGtlcm5lbCwgd2hpY2ggd2FzIHJlcG9ydGVkIGJ5IEJyZW5vIGlu
IFsyXS4KVGhlIGlzc3VlIGlzIHVzaW5nIF9fcGEgZm9yIGEgZml4bWFwIGFkZHJlc3MgaW4gYXJt
NjQgYXMgZGVzY3JpYmVkIGluIFsyXSwKd2hpY2ggY291bGQgcmVzdWx0IGluIHJlbW92aW5nIGEg
bWVtb3J5IHJlc2VydmF0aW9uIGZvciBhIGNvbXBsZXRlbHkKdW5yZWxhdGVkIGFyZWEuClRoYXQg
d2FzIGludHJvZHVjZWQgYnkgdGhlIHBhdGNoIGp1c3QgYmVmb3JlIAoiYXJtNjQ6IFVzZSBjb21t
b24gb2Zfa2V4ZWNfYWxsb2NfYW5kX3NldHVwX2ZkdCIgWzNdLCBidXQgYXJtNjQgc3dpdGNoZWQg
dG8KdXNpbmcgdGhlIGNvbW1vbiBrZXhlYyBmZHQgZnVuY3Rpb24gaW4gdGhhdCBjb21taXQuIFRo
aXMgY29tbWl0IGlzIHRyeWluZwp0byBmaXggcmVtb3ZpbmcgYW5kIGNvcnJ1cHRpbmcgYW55IHJh
bmRvbSBtZW1vcnkgcmVzZXJ2YXRpb24gKGFuZCBnZXQgcmlkCm9mIHRoZSB3YXJuaW5nKSB0aGF0
IHdhcyBpbnRyb2R1Y2VkIGJ5IFsxXSwgbm90IGFkZGluZyBhIG5ldyBmdW5jdGlvbmFsaXR5LgoK
WzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIxMDIyMTE3NDkzMC4yNzMyNC03LW5y
YW1hc0BsaW51eC5taWNyb3NvZnQuY29tLyAKWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC9abkZLRXRxZnFKa1lmbHdMQGdtYWlsLmNvbS8KWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDIxMDIyMTE3NDkzMC4yNzMyNC02LW5yYW1hc0BsaW51eC5taWNyb3NvZnQuY29tLwoK
VGhhbmtzLApVc2FtYQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
