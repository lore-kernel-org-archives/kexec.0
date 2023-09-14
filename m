Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5B4EEAA5A
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CMoJY1L3lNPFlUuRkrsy4pKte1r8urGnNyp43t+0eYE=; b=t8Ahnpw2PI02Lc
	yr9mbYKYFr1dUig8Zdx4Ogaf6uciNL0+Jcg5B5NLqN8iIwgsr9jsBTCiVIV+H+L3Y4XzvP9k+MDVj
	G8X+rDAwU5QZpUokE3LiZ4qBFGQosDbB0P1JduOfXsT7DCTBBzQQp1D3lYYLqnYuXEO3pQl/PLj/t
	s4b3zVvfzlU0cXWzN0gYheus2mmr/8uD6ZIwK+I3WbsYbyq08fjAR+PMTcJfngqgaCbKVaM7in0VZ
	LAUO+kiUroANdDuVpEv1/mBfCj3jnMxPF7RYPDzAS45WpkNBt++yO6XbnEA9iajhx+gN4bONhfSy5
	rxvNfH3U7HEuWq30Mtzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgpk1-008xVZ-3C;
	Thu, 14 Sep 2023 17:02:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgpjz-008xUb-0J
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 17:02:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8E88A61E3A
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 17:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60391C433CB
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694710974;
	bh=dNvKVExAcL/+xsVdm/JTZl0sH/+jDBgpCJN7oIJgWk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eTLrZoBvHzLb8opyX5RDTUJinZWC67A/h8gxiaS9PNNpqzuxUyiS/OhPBMkjy6ja/
	 8BHaxNQdoj5KHkoyhcctU3pUxXxpSb/GtktJ/QqnESdvnLxO6FelK5cISxm7tLC1LU
	 7gJA2VY2/RjNDCURlQ6OyRmCz6WzXcQiYTER10qtSsK7nU6ewRlOZB4k4QvzUbbEuG
	 S+jCpyBJLwgrsvAgSSjQ/rV8elqtmVcGqjr/4fGv1+zzlKjGsTXvNeg17lURvgMGEu
	 HJtt719KF/mrNPsHNcMYSLK51TFJdHQwYnus2/f3hr7uWNRJJtjbuRwGiR8QSF0OhM
	 TnfQWfsTjoUhQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-500c37d479aso2005987e87.2
        for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 10:02:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YzRCRcQXYZmXgn9XPWTgICEqAW2LRc8pkcqbaOn/J4huMH8zyxf
	bajhxDxIcwd98Y5xx97Y7LNb13E1KtuGE22U8pc=
X-Google-Smtp-Source: AGHT+IGw/eFibdqS75bKWCpJa37gsnsnifCwsJlCyAp5V7GZQe8BhXNYzITpDpDqdeTGQTy8AIuHJ7b5Z0M2SEojNyo=
X-Received: by 2002:a19:ca43:0:b0:4ff:aeef:b582 with SMTP id
 h3-20020a19ca43000000b004ffaeefb582mr4611968lfj.66.1694710972568; Thu, 14 Sep
 2023 10:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230908231244.1092614-1-song@kernel.org> <CAPhsuW5Xy_K=6u4s=pNAZ8+eGBtX8v16Fr+9quL-FftEu+DWOA@mail.gmail.com>
 <CAKwvOdk6FeQjbh7b5K4pps50HZa6Riw6o7huGKzYcHFk_R8MLg@mail.gmail.com>
In-Reply-To: <CAKwvOdk6FeQjbh7b5K4pps50HZa6Riw6o7huGKzYcHFk_R8MLg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 14 Sep 2023 10:02:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5niOZwfc=aZcHNeWMU8OJnf9pcOgyXZpm289dQXfmOUA@mail.gmail.com>
Message-ID: <CAPhsuW5niOZwfc=aZcHNeWMU8OJnf9pcOgyXZpm289dQXfmOUA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/purgatory: Remove LTO flags
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org, x86@kernel.org, 
	llvm@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_100255_176182_F8AFCF8C 
X-CRM114-Status: GOOD (  15.00  )
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

T24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgOTozNOKAr0FNIE5pY2sgRGVzYXVsbmllcnMKPG5kZXNh
dWxuaWVyc0Bnb29nbGUuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgU2VwIDE0LCAyMDIzIGF0IDk6
MzHigK9BTSBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiBXaGF0IHdv
dWxkIGJlIHRoZSBuZXh0IHN0ZXAgZm9yIHRoaXMgd29yaz8gV2UgaG9wZSB0byBiYWNrIHBvcnQg
aXQKPiA+IHRvIG91ciBwcm9kdWN0aW9uIGtlcm5lbCBzb29uLgo+Cj4gUGxlYXNlIHNlbmQgYSB2
MyB3aXRoIHRoZSBmaXhlcyB0YWcgdXBkYXRlZC4gIEkgd291bGRuJ3QgbWluZCBpZiB5b3UKPiBh
ZGRlZCBhIGNvbW1lbnQgdG8gdGhlIGNvbW1pdCBtZXNzYWdlIHRvIHRoZSBlZmZlY3Qgb2Y6Cj4K
PiBXZSBjb3VsZCBhbHNvIGFkZCB0aGUgdXNlIG9mIGFuIGV4cGxpY2l0IGxpbmtlciBzY3JpcHQg
dG8gcmVqb2luCj4gLnRleHQuKiBzZWN0aW9ucyBiYWNrIGludG8gLnRleHQuICBTaW1wbHkgZGlz
YWJsZSB0aGUgcHJvZHVjdGlvbiBvZgo+IG1vcmUgLnRleHQuKiBzZWN0aW9ucyBmb3Igbm93OyAt
Zmx0byogaW1wbGllcyAtZmZ1bmN0aW9uLXNlY3Rpb25zLgoKR290IGl0LiBJIGp1c3Qgc2VudCB2
MyB3aXRoIHRoZXNlIGNoYW5nZXMuCgpUaGFua3MsClNvbmcKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
