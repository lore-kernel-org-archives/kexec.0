Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F178AC4332F
	for <kexec@archiver.kernel.org>; Tue, 12 Dec 2023 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LVUSwII/aVcz6oDy+3shboAwWUYker54W0Uy3Lvhg6w=; b=EmBtDgUeaKh4db
	hYsz6S8koeV8CwDMYXznxTTsG7LqBrAfCpO9ExH1cX4cEwL6ZHklh0rp3iinqtl091Iq305AcsoOc
	sWhLU9bDIUyv/Ip/lJP5r7mw3nDu+2NdnRwlCiN1/3sn6arLxroAUxy91HG7/dD60cJ1siBfZGsFt
	rGZuhpfffkz9d6hDHtd3IYvY10laCT7OCvAQrwuQsFEGcMaNru3avbRd6ZOTiKkUVCy3BaSMChmN2
	PxX/13VnXgbPiTjjosuHt1iFTlqnZ4gbfhSN05X6E4w/lwk8yuBxJwdZVP/akXJyq2hEC5cCGQ9fu
	ZovnFcVJqNZrApUeJbWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rD2xq-00BpVQ-27;
	Tue, 12 Dec 2023 13:38:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rD2xo-00BpUZ-03
	for kexec@lists.infradead.org;
	Tue, 12 Dec 2023 13:38:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702388299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IjtSLSS+KMn2n0R4fQtLvtCI4SQNSXOvC4z09ahOFQ=;
	b=hyGVyiBnMYgJRjma0DXfngZC00g63BJD4CnGcZXv75FRukrAjpskLWCWPcoAYFO86Ymnkc
	SsYyTT8fDrIYZ3TA8TVsaCb4VNdT47VYOFMEnN5zJiZRXgSU5XWcfSD7fBB4q47aCAXnzb
	Qqe6Mcss9NcakJcAOce1PpRZem3IZmc=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-nOjYpWvdMkypk5L4TmMl-A-1; Tue, 12 Dec 2023 08:38:16 -0500
X-MC-Unique: nOjYpWvdMkypk5L4TmMl-A-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7cb2d8b214dso112079241.2
        for <kexec@lists.infradead.org>; Tue, 12 Dec 2023 05:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388295; x=1702993095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IjtSLSS+KMn2n0R4fQtLvtCI4SQNSXOvC4z09ahOFQ=;
        b=DpGLbM8HjVq3AqlAzGc44ZP6PrW758YgUjRVY/oK93IedvbFfEnMDvN1j0vhuMv7P9
         r22zar0PRhEjHfRIR5+vf8ULBc5xvOQ065PDjbV193ONSJc+W0rhN1Isk1ORLoBOLp52
         UggwCgXql/IhuIEmTfE6q3Po2ULXK3rG417i0LXd9K2uaECIgRrMvMBtzUYo8fgoXNfa
         sBdygR+SNQkts9hl6+M8hBSL2y43xAa9rZywr4zKH7YtAymrlsrW4RrQrF8erGMXF1ND
         U8DIEkPDCxDtIudT7m5zrGNZ9RokLrWgLHlaEs/GifFju70YbVGc9IninYAOSDHlk78c
         2iCg==
X-Gm-Message-State: AOJu0YzhHvZjzixdb3gkAODu9QaXS6/q2ldEbAzZKS9JU2jxMbYYTF3B
	AFN7KU6TS/Oz2amLtEVItIjO1J/MbKTqSU7pXO/E6M3UZ7eOsFlGKU9tj8HNio/eJjaTvUCklLp
	AvWolrbRpecByp9pduw1Nlttx8HMdypUl9VWc
X-Received: by 2002:a05:6102:954:b0:464:a4b9:5ca2 with SMTP id a20-20020a056102095400b00464a4b95ca2mr4133766vsi.43.1702388295546;
        Tue, 12 Dec 2023 05:38:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoi0rzc6o7Gt4+TFEGhMVoc3vZ6tzwUFixtpjFgOfHf47vt6vk5agyXIEXqqQZSIqeGr8AylCCZagp/mgF4KI=
X-Received: by 2002:a05:6102:954:b0:464:a4b9:5ca2 with SMTP id
 a20-20020a056102095400b00464a4b95ca2mr4133761vsi.43.1702388295319; Tue, 12
 Dec 2023 05:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20230512233127.804012-1-seanjc@google.com> <20230512233127.804012-2-seanjc@google.com>
 <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
 <871qbud5f9.fsf@email.froward.int.ebiederm.org> <a02b40d3d9ae5b3037b9a9d5921cfb0144ab5610.camel@amazon.com>
 <7e30cfc2359dfef39d038e3734f7e5e3d9e82d68.camel@amazon.com>
 <87wmtk9u46.fsf@email.froward.int.ebiederm.org> <cf9e15bf3da411ada1c5b2bbdbfdea836029a5e1.camel@amazon.com>
In-Reply-To: <cf9e15bf3da411ada1c5b2bbdbfdea836029a5e1.camel@amazon.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Dec 2023 14:38:02 +0100
Message-ID: <CABgObfZKOkUn3++g-YMkv7bsmKU77Y88NPBqt-5XoRJFLXDEFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to
 hook restart/shutdown
To: "Gowans, James" <jgowans@amazon.com>
Cc: "Graf (AWS), Alexander" <graf@amazon.de>, "seanjc@google.com" <seanjc@google.com>, 
	"ebiederm@xmission.com" <ebiederm@xmission.com>, =?UTF-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>, "james.morse@arm.com" <james.morse@arm.com>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "atishp@atishpatra.org" <atishp@atishpatra.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "maz@kernel.org" <maz@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>, 
	"anup@brainfault.org" <anup@brainfault.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_053820_126461_FA5FB0C3 
X-CRM114-Status: UNSURE (   9.55  )
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

T24gVHVlLCBEZWMgMTIsIDIwMjMgYXQgOTo1MeKAr0FNIEdvd2FucywgSmFtZXMgPGpnb3dhbnNA
YW1hem9uLmNvbT4gd3JvdGU6Cj4gMS4gRG9lcyBoYXJkd2FyZV9kaXNhYmxlX25vbG9jayBhY3R1
YWxseSBuZWVkIHRvIGJlIGRvbmUgb24gKmV2ZXJ5KiBDUFUKPiBvciB3b3VsZCB0aGUgb2ZmbGlu
ZWQgb25lcyBiZSBmaW5lIHRvIGlnbm9yZSBiZWNhdXNlIHRoZXkgd2lsbCBiZSByZXNldAo+IGFu
ZCB0aGUgVk1YRSBiaXQgd2lsbCBiZSBjbGVhcmVkIHRoYXQgd2F5PyBXaXRoIGNvb3BlcmF0aXZl
IENQVSBoYW5kb3Zlcgo+IHdlIHByb2JhYmx5IGRvIGluZGVlZCB3YW50IHRvIGRvIHRoaXMgb24g
ZXZlcnkgQ1BVIGFuZCBub3QgZGVwZW5kIG9uCj4gcmVzZXR0aW5nLgoKT2ZmbGluZWQgYW5kIG9u
bGluZWQgQ1BVcyBhcmUgaGFuZGxlZCB2aWEgdGhlIENQVSBob3RwbHVnIHN0YXRlIG1hY2hpbmUs
CndoaWNoIGNhbGxzIGludG8ga3ZtX29ubGluZV9jcHUgYW5kIGt2bV9vZmZsaW5lX2NwdS4KClBh
b2xvCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
