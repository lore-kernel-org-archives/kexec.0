Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23FBC761A6
	for <kexec@archiver.kernel.org>; Fri, 31 Mar 2023 19:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zf7oUn7ohOANq44pWot5We1Lg9g9MwL+Pq4lmyDpurY=; b=cFYXtMZ53jSDi6
	GU4XF0OPzNbt4VI7JmFuNmcjVfa0pK/gbxvmmuVr8inn46BYUE0hk+x8EXsY6XNz8loiP4HuQAWJ3
	jFMmS9jR8/A9qJoVWzmQDhm1KkS7JfTA28rFpzA3BniJ4XHO44ueIPe/JAiJFqz3I/7dhgHH4u+Ex
	1oOLCCVkWJ630EMDWlbt68/HmUc4J/rgxItV614s4WwFcXIDb1fEYz68JTA2+5rLyWGSRWtyQ9om1
	jhmN9IJRzn/1d7KmeaRD2f041DHRnj4R5ne6Okw0WmF/DAUgBRpxeiqVI3OQqWq99yei5s1Nr3YHM
	wnIC7wJn0REPSF1h/74w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piKCU-008as5-20;
	Fri, 31 Mar 2023 19:14:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piKCO-008arD-2y
	for kexec@lists.infradead.org;
	Fri, 31 Mar 2023 19:14:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A8DE462415
	for <kexec@lists.infradead.org>; Fri, 31 Mar 2023 19:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16080C4339B
	for <kexec@lists.infradead.org>; Fri, 31 Mar 2023 19:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680290047;
	bh=/CfZt4OxuWD1DSgb/0vFAV/hFLZFC/08ki8yZZJNyGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HDYTQoSJjAdKe4gL5JgY46rfh7x/dEe470GRbfoSawYRHwO7E+9Rn1lZF2waARMJ0
	 XeIkTmESGJDmtvVo0wdcGjQVD80l9098Zo9KX7pHVG0wdbJlVHeyRLttvv1VfJVSj7
	 kk+d5UUyl0WbvRvxw0Wp+KhpDeW6hD8TDwmlj+1iVd0RktH8yGGHW2/buL+yY78iux
	 2+R+TGsP1lxjx7RLvgFPKN7SG3aukZXUI+DJDu0mbsMg4RABuF3SToYY6jH6Nc6XK/
	 O0lI8mStDVJigdO1CX0NTNdfy3eyViTaN3kY3AsAVxituL0YMaq5nGo18oPNzxkfQH
	 WkjmXIviL3pDg==
Received: by mail-pl1-f180.google.com with SMTP id f22so18075102plr.0
        for <kexec@lists.infradead.org>; Fri, 31 Mar 2023 12:14:07 -0700 (PDT)
X-Gm-Message-State: AAQBX9dtJ/FyR7ZcMFSoxvfVSDEsIeUu7/wEQ2D/Qv/Ml0U77qLzF/fM
	9kCXDtyGXV6XCGDdKTgK6zvmqytZ9CrBZ2z1zSwz8Q==
X-Google-Smtp-Source: AKy350aTSo3hL6GihtyDfEbY7KALV0nbI7oV3810z5Osa8s8LnAKd53t7j7zMzopdF/vN4/hqMoON66jprXPPl64qtg=
X-Received: by 2002:a17:903:1105:b0:1a2:8870:5ba2 with SMTP id
 n5-20020a170903110500b001a288705ba2mr2674034plh.10.1680290046470; Fri, 31 Mar
 2023 12:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org> <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org>
In-Reply-To: <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org>
From: Ross Zwisler <zwisler@kernel.org>
Date: Fri, 31 Mar 2023 13:13:55 -0600
X-Gmail-Original-Message-ID: <CAGRrVHx4S0VxMQ-76i3sQQNLUBKbHr_wJdLhJ8F9D6R=UoCLAA@mail.gmail.com>
Message-ID: <CAGRrVHx4S0VxMQ-76i3sQQNLUBKbHr_wJdLhJ8F9D6R=UoCLAA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Simon Horman <horms@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_121409_024328_D3DC4E3B 
X-CRM114-Status: GOOD (  12.08  )
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

T24gVGh1LCBNYXIgMzAsIDIwMjMgYXQgMzo0NeKAr0FNIFJpY2FyZG8gUmliYWxkYSA8cmliYWxk
YUBjaHJvbWl1bS5vcmc+IHdyb3RlOgo+IE1ha2Ugc3VyZSB0aGF0IHRoZSAudGV4dCBzZWN0aW9u
IGlzIG5vdCBkaXZpZGVkIGluIG11bHRpcGxlIG92ZXJsYXBwaW5nCj4gc2VjdGlvbnMuIFRoaXMg
aXMgbm90IHN1cHBvcnRlZCBieSBrZXhlY19maWxlLgoKSG93IGRvZXMgdGhpcyBpbnRlcmFjdCB3
aXRoIHBhdGNoICMxIGZyb20gdGhpcyBzZXJpZXMsIHdoaWNoIElJVUMKYWxsb3dzIHVzIHRvIGhh
bmRsZSB0aGUgY2FzZSB3aGVyZSB0aGUgLnRleHQgc2VjdGlvbiBpcyBzcGxpdCBiZXR3ZWVuCi50
ZXh0IGFuZCAudGV4dC5ob3Q/ICBEbyB3ZSBzdGlsbCBuZWVkIHRoYXQgcGF0Y2gsIGJ1dCBvbmx5
IGZvcgpub24teDg2IHBsYXRmb3Jtcz8gIE9yIGRvIHdlIG5lZWQgYm90aCwgYW5kIHRoaXMgcGF0
Y2ggd2lsbCBuZWVkIHRvIGJlCnJlcGxpY2F0ZWQgZm9yIG90aGVyIGFyY2hlcz8KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
