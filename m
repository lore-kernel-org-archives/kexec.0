Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E987C6FD1D
	for <kexec@archiver.kernel.org>; Tue, 21 Mar 2023 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pg/CxuqnF8rzJe0vu3WT0zwv6pomxgdOpzt+r0C55as=; b=RzvA3N6vrC12cL
	61WjHF/lQZdbs04gpZI+UuJmEfkrld9leyuFhIFuKOtlHit7xwn3v/L8a6BxcVaeQwpJeIjPeIpNJ
	58l6KplRsFfOz4ZIz+ld45qE77F6790rd1Jq4bMuF2GIV0X8ybHdj3shJKlrf+4iYYjQv1KMuebqQ
	2ADt7Oz90VTFZIcqBcDGDFcW7b2ogZkpL+YHvnYL+Jx0a147IUPybfXTq2bgEVWhvl5ICHVs2D14w
	ClnIUk5T1hpjoCqsZA6uiS6kG0ylXPuCyfFtW54PiKaGK/KhBCyw3Gv2IOOhZet/j1xGIRdruOeJ6
	p4nzXWiIRjqJb8gZCAsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peheq-00DTVj-03;
	Tue, 21 Mar 2023 19:28:32 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pehed-00DTTn-0h
	for kexec@lists.infradead.org;
	Tue, 21 Mar 2023 19:28:21 +0000
Received: by mail-ed1-x533.google.com with SMTP id y4so64064821edo.2
        for <kexec@lists.infradead.org>; Tue, 21 Mar 2023 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679426894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHtgR0XvPydSJ2xRHzSM20hkxNSVo2TSBRlBp9YTFyU=;
        b=g5XylmHo3AryDi3Obhf6SykzvXeNwfhnG4knFluZEoelXvkbEciK/IhrJLm/LI79Hh
         My86Iz2AZCuM4/KjZAxXQHFN89oNIlEqbhjte+DlXbgqlxXTi8DIscBJ6WEeIIiK1rbW
         u+65ZrEOjQKgHBB7QcElM58vTLvwNiGaoux8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHtgR0XvPydSJ2xRHzSM20hkxNSVo2TSBRlBp9YTFyU=;
        b=PNkAQe7eq9o7bLj0g560SNxswEb1rSxB4OaHNcukvhubBS22Ro+/2asp31Zg4c0xjT
         hcY20aMjLtsUVGE4aXU9ex0vQm0QV3tMwutx+priGxB+igEn/5P48TQfhWcV3UnA3dmA
         lw9qoPXl8AYYN3JwaQSSdu3jeaaFIAQEHIlsvdplhSM/K+i5BYGL7tlCdMcMuwyfDFub
         SrYviW6jEPxPM46cIZeOdEDDU7tZsRkMtSIcN62hqhYjOFigr8ZVxEbfXBEbW6Jo3GJd
         jZ7m/mWI8xLhlRmuSL4wno62RoUnMIqHNCd4GEHCoEcCeUSiruaxaxzlbeN+Hw92fs7j
         yhaQ==
X-Gm-Message-State: AO0yUKVg2+R9sUylDnySMA+AJnbFTp6HAcVLhBPvcR7uh6WUei7a12sW
	cgh8tcJKjdqzJEx0JxYxDGhYkB3dw69NsF1auh7S4BQN
X-Google-Smtp-Source: AK7set+tuvCb0kKFtEOyOq2cSia1aeQFoxsG0zg5fuS3AvwlWKJMfWx1CmZOpAAo7xIQ/2y5D7pH7A==
X-Received: by 2002:a17:906:5e04:b0:92b:34cf:16a with SMTP id n4-20020a1709065e0400b0092b34cf016amr4476800eju.52.1679426894105;
        Tue, 21 Mar 2023 12:28:14 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906670b00b0093a0e5977e2sm1133221ejp.225.2023.03.21.12.28.13
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:28:13 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id d17so6410125wrb.11
        for <kexec@lists.infradead.org>; Tue, 21 Mar 2023 12:28:13 -0700 (PDT)
X-Received: by 2002:a50:9e6f:0:b0:4fb:482b:f93d with SMTP id
 z102-20020a509e6f000000b004fb482bf93dmr2321260ede.2.1679426530851; Tue, 21
 Mar 2023 12:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <2851036.1679417029@warthog.procyon.org.uk> <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
 <8d532de2-bf3a-dee4-1cad-e11714e914d0@kernel.dk>
In-Reply-To: <8d532de2-bf3a-dee4-1cad-e11714e914d0@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Mar 2023 12:21:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2yeuwCxvB18=AWG+YKnMgd28WGkHFMqTyMA=59cw3rg@mail.gmail.com>
Message-ID: <CAHk-=wi2yeuwCxvB18=AWG+YKnMgd28WGkHFMqTyMA=59cw3rg@mail.gmail.com>
Subject: Re: [GIT PULL] keys: Miscellaneous fixes/changes
To: Jens Axboe <axboe@kernel.dk>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Bharath SM <bharathsm@microsoft.com>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Steve French <smfrench@gmail.com>, Robbie Harwood <rharwood@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	keyrings@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_122820_133140_90B0893C 
X-CRM114-Status: GOOD (  11.27  )
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

T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgMTI6MTbigK9QTSBKZW5zIEF4Ym9lIDxheGJvZUBrZXJu
ZWwuZGs+IHdyb3RlOgo+Cj4gSSBoYXZlbid0IHNlZW4gdGhlIHBhdGNoIHlldCBhcyBpdCBoYXNu
J3QgYmVlbiBwdXNoZWQsCgpXZWxsLCBpdCB3ZW50IG91dCBhIGNvdXBsZSBvZiBtaW51dGVzIGJl
Zm9yZSB5b3VyIGVtYWlsLCBzbyBpdCdzIG91dCBub3cuCgo+IEl0IG1heSBtYWtlIHNlbnNlIHRv
IGFkZCBzb21lIGRlYnVnIGNoZWNrIGZvcgo+IFBGX0tUSFJFQUQgaGF2aW5nIFRJRl9OT1RJRllf
UkVTVU1FIHNldCwgb3IgdGFza193b3JrIHBlbmRpbmcgZm9yIHRoYXQKPiBtYXR0ZXIsIGFzIHRo
YXQgaXMgZ2VuZXJhbGx5IG5vdCB3b3JrYWJsZSB3aXRob3V0IGRvaW5nIHNvbWV0aGluZyB0bwo+
IGhhbmRsZSBpdCBleHBsaWNpdGx5LgoKWWVhaCwgSSBndWVzcyB3ZSBjb3VsZCBoYXZlIHNvbWUg
Z2VuZXJpYyBjaGVjayBmb3IgdGhhdC4gSSdtIG5vdCBzdXJlCndoZXJlIGl0IHdvdWxkIGJlLiBT
Y2hlZHVsZXI/CgogICAgICAgICAgICAgICBMaW51cwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
