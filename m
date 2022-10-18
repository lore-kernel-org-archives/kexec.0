Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD4BC4332F
	for <kexec@archiver.kernel.org>; Tue, 18 Oct 2022 07:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MMLNlKhfIF/5euxCqJcwcBSN+WK3RBr+io4M1TFUBvE=; b=1OpXeeWB6ngX1g
	A4qa/sAggbHanvgctvETFCK+zZKA1PrE94AzGbg9hf1AOxu4q8CHHfktyg7zL5YWUInNzNsPlnpdF
	GvDrCcZcsu0XKo73CRnd8w8PNY0pQ68iPM9vNaDQWr/2G5VIZo4fkfP1Okd4ol7NKG+ZHqt1LnaQQ
	h6KpdNuzYBeJ4WQ/YQsf2VH/hKn6wNxgVrOrp39iwz42rWpJAhhoCcn3g6SFDQUo5SX6viOKzVMFh
	Ag+zfBs2+ygWdEbDKZ/PN3gYGEKvWo1FxKGtXRMRy2oVZiSYQq1EOklLyIQFyisn9mq93plPz+nX6
	7ewpg3U8MsM49OEoXmEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okgyd-003nWO-Nf; Tue, 18 Oct 2022 07:25:27 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okgtt-003l9V-4w; Tue, 18 Oct 2022 07:20:35 +0000
Received: by mail-pl1-x632.google.com with SMTP id f23so13010515plr.6;
        Tue, 18 Oct 2022 00:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlUHZSLgyN+Iy2ZHw1iVdzVnrjwNDaODH3GC5m/bHuI=;
        b=nVrDI3EyMXgMjYivuX8vqyo8cClBAL9BzAKbG9MC7nCPk3K8W/aD/305j/gU8MoM5k
         6o0KNlqwLB0WS+q0GAwHIYT8kOVOiNK9ydLit6nhzzHh66UwXAH9Ul4NOOAASvr6ySFK
         YxRvotPrddkdl5lxBP6kNack4WDURB0q2OEvqW+zmEMI7wnypccxUUWvdXjZcNi8FRLQ
         7pzRGL+aqtbtahk7q8kW5GDwYd5jUUl4u4O1+8CDE4hSJT/opXXCyLlZTWziYm63Y3yT
         pu/Ttg8cRnlAl7tNi/hFICLvo2+cxAt5BDOVjcaF2PUPKGGky02mR1W5+nH/PTpet41W
         Lg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlUHZSLgyN+Iy2ZHw1iVdzVnrjwNDaODH3GC5m/bHuI=;
        b=17QchNqSpnXXcWuFYHV2+ccYZbEPVgHnLNirlC0nGrdLbTBcbleThtXXEXsX98OVS3
         NpFXX9e2XvfgAjGcfwqzvcxhRQCyO9I/+gv4L6ktLtLKiHYXTuapVdsNefy4mayOIjZ+
         hZDiPrMBcquZK7PQo5DWTvNXHrIQaQ8z6TiWwXUHFfyRRbGOTahPihZhTQWEMpBKNNAM
         HypcPADYatgcZ5+kFKMRU5Wy05p8Z9d0N+zMhDVGqtppenKvsn6otsn5YtBYhTQ8R6BU
         JO8XI40HHWAzStPaHp2+YI26E5QkrYrq5m0fcEM34YgcJLmvKr3PzovY0VDhzkksUBYl
         qx8Q==
X-Gm-Message-State: ACrzQf2T2zueZaujYQLIksCnIK8AFjaMNBnMdKRDnFpphnNUWOClx8wY
	uqQ/P4rTwSCPCyrfmhFjqEo=
X-Google-Smtp-Source: AMsMyM4gLlyL+JlYeqJ/Nt61Zrspm7QxgQgNVoXaH5OieEUmOXK+54+b9VK5iwCxH1FfixNqR6eQzw==
X-Received: by 2002:a17:90b:1c11:b0:20d:459b:ef0e with SMTP id oc17-20020a17090b1c1100b0020d459bef0emr37731813pjb.129.1666077628758;
        Tue, 18 Oct 2022 00:20:28 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id w186-20020a6262c3000000b00561d79f1064sm8413056pfb.57.2022.10.18.00.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:20:28 -0700 (PDT)
Message-ID: <087eb324-a38e-331e-c8fd-033818895ccc@gmail.com>
Date: Tue, 18 Oct 2022 14:20:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH V2 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
 k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
 <Y04bOv49sRsauLb6@debian.me>
 <188e331c-d399-e86d-e894-a2a116deb753@linux.alibaba.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <188e331c-d399-e86d-e894-a2a116deb753@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_002033_384601_99E4740B 
X-CRM114-Status: GOOD (  13.06  )
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

T24gMTAvMTgvMjIgMTM6MDYsIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4gCj4g5ZyoIDIwMjIvMTAv
MTgg5LiK5Y2IMTE6MTksIEJhZ2FzIFNhbmpheWEg5YaZ6YGTOgo+PiBPbiBGcmksIE9jdCAxNCwg
MjAyMiBhdCAwOTo0MTozOVBNICswODAwLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+Pj4gVGhlIGZv
bGxvd2luZyBpbnRlcnJlbGF0ZWQgZGVmaW5pdGlvbnMgYW5kIHJhbmdlcyBhcmUgbmVlZGVkIGJ5
IHRoZSBrZHVtcAo+Pj4gY3Jhc2ggdG9vbCwgdGhleSBhcmUgZXhwb3J0ZWQgYnkgImFyY2gvcmlz
Y3Yva2VybmVsL2NyYXNoX2NvcmUuYyI6Cj4+IEJldHRlciBzYXkgIi4uLiwgd2hpY2ggYXJlIGV4
cG9ydGVkIGJ5IC4uLiIKPj4KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL2tkdW1wL3ZtY29yZWluZm8ucnN0IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVt
cC92bWNvcmVpbmZvLnJzdAo+Pj4gaW5kZXggNjcyNmY0Mzk5NThjLi44ZTJlMTY0Y2YzZGIgMTAw
NjQ0Cj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tkdW1wL3ZtY29yZWluZm8u
cnN0Cj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tkdW1wL3ZtY29yZWluZm8u
cnN0Cj4+PiBAQCAtNTk1LDMgKzU5NSwzMyBAQCBYMlRMQgo+Pj4gwqAgLS0tLS0KPj4+IMKgIMKg
IEluZGljYXRlcyB3aGV0aGVyIHRoZSBjcmFzaGVkIGtlcm5lbCBlbmFibGVkIFNIIGV4dGVuZGVk
IG1vZGUuCj4+PiArCj4+PiArUklTQ1Y2NAo+Pj4gKz09PT09PT0KPj4+ICsKPj4+ICtWQV9CSVRT
Cj4+PiArLS0tLS0tLQo+Pj4gKwo+Pj4gK1RoZSBtYXhpbXVtIG51bWJlciBvZiBiaXRzIGZvciB2
aXJ0dWFsIGFkZHJlc3Nlcy4gVXNlZCB0byBjb21wdXRlIHRoZQo+Pj4gK3ZpcnR1YWwgbWVtb3J5
IHJhbmdlcy4KPj4+ICsKPj4+ICtQQUdFX09GRlNFVAo+Pj4gKy0tLS0tLS0tLS0tCj4+PiArCj4+
PiArSW5kaWNhdGVzIHRoZSB2aXJ0dWFsIGtlcm5lbCBzdGFydCBhZGRyZXNzIG9mIGRpcmVjdC1t
YXBwZWQgUkFNIHJlZ2lvbi4KPj4+ICsKPj4+ICtwaHlzX3JhbV9iYXNlCj4+PiArLS0tLS0tLS0t
LS0tLQo+Pj4gKwo+Pj4gK0luZGljYXRlcyB0aGUgc3RhcnQgcGh5c2ljYWwgUkFNIGFkZHJlc3Mu
Cj4+PiArCj4+PiArTU9EVUxFU19WQUREUnxNT0RVTEVTX0VORHxWTUFMTE9DX1NUQVJUfFZNQUxM
T0NfRU5EfFZNRU1NQVBfU1RBUlR8Vk1FTU1BUF9FTkR8S0FTQU5fU0hBRE9XX1NUQVJUfEtBU0FO
X1NIQURPV19FTkR8S0VSTkVMX0xJTktfQUREUnxBRERSRVNTX1NQQUNFX0VORAo+Pj4gKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+ICsKPj4+ICtVc2VkIHRvIGdldCB0aGUg
Y29ycmVjdCByYW5nZXM6Cj4+PiArCj4+PiArwqAgKiBNT0RVTEVTX1ZBRERSIH4gTU9EVUxFU19F
TkQgOiBLZXJuZWwgbW9kdWxlIHNwYWNlLgo+Pj4gK8KgICogVk1BTExPQ19TVEFSVCB+IFZNQUxM
T0NfRU5EIDogdm1hbGxvYygpIC8gaW9yZW1hcCgpIHNwYWNlLgo+Pj4gK8KgICogVk1FTU1BUF9T
VEFSVCB+IFZNRU1NQVBfRU5EIDogdm1lbW1hcCByZWdpb24sIHVzZWQgZm9yIHN0cnVjdCBwYWdl
IGFycmF5Lgo+Pj4gK8KgICogS0FTQU5fU0hBRE9XX1NUQVJUIH4gS0FTQU5fU0hBRE9XX0VORCA6
IGthc2FuIHNoYWRvdyBzcGFjZS4KPj4+ICvCoCAqIEtFUk5FTF9MSU5LX0FERFIgfiBBRERSRVNT
X1NQQUNFX0VORCA6IEtlcm5lbCBsaW5rIGFuZCBCUEYgc3BhY2UuCj4+IFRoZSBkb2N1bWVudGF0
aW9uIExHVE0sIHRoYW5rcy4KPj4KPj4gV2hlbiB0aGUgcGF0Y2ggc3ViamVjdCBpcyBmaXhlZCwK
PiBDb3VsZCB5b3UgdGVsbCBtZSB3aGF0IHBhdGNoIHN1YmplY3Qgc2hvdWxkIGJlIGNoYW5nZWQg
dG8gPyB0aGFua3MKCkkgbWVhbiB0aGUgZGVzY3JpcHRpb24sIG5vdCBzdWJqZWN0IChhcyBpbiBl
bWFpbCkuIFRoYXQgaXMsIGZpeCB0aGUgZGVzY3JpcHRpb24KKHNlZSBhYm92ZSkuIFRoZSBzdWJq
ZWN0IHNob3VsZG4ndCBiZSBjaGFuZ2VkLiBTb3JyeSBmb3IgaW5jb252ZW5pZW5jZS4KClRoYW5r
cy4KCi0tIApBbiBvbGQgbWFuIGRvbGwuLi4ganVzdCB3aGF0IEkgYWx3YXlzIHdhbnRlZCEgLSBD
bGFyYQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
