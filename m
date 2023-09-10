Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D583EE14D8
	for <kexec@archiver.kernel.org>; Sun, 10 Sep 2023 07:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=915KImU5t17P+Zi5Z3Lz9uzoH/NJv12+pVln2En0vFQ=; b=3iNLCdjiRJMif+
	wvOro9C17u/5e1WFkXxGviEjsN/0Q86KuaW8SHQEmFyDjXxRuaXrFL7RB0LB7CxehSmgoTxlohaG8
	0YrN6y32TJDzpwv7CEidNB6p6YySA3XikP1KPmVP940peV2QiWReGxVqX83mQMKzUFvbkv7KwgkvJ
	8dlFmtXspcV8uLZj8ZYUWxJyuadUGEnjB+MIuhmRJV0aQzCTKPLt2/VcDjdGnUhRNXda5zRzKkArq
	QccziOIht/HAlsY7mHZOOVpM2J2WjkNmTwF3rwklF96Qag6nrYZaVnKRliO8mMhBMPg7QWOKLZO7n
	lXoAkX7m94LhyhVcBVYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfF7I-00GGE5-0n;
	Sun, 10 Sep 2023 07:44:24 +0000
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfF7F-00GGDG-0N
	for kexec@lists.infradead.org;
	Sun, 10 Sep 2023 07:44:22 +0000
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1d4c9494b42so2538739fac.0
        for <kexec@lists.infradead.org>; Sun, 10 Sep 2023 00:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694331859; x=1694936659; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c50+csNixrAL652I8a2nGfpKGvkeir3Xklb+hUPR40Y=;
        b=D1hfy1BpIOq0EkkevVBLkc/EC8TJ+STjmssripIZ0VCjCfYNrocXZBoKKZYcZSkfC/
         DqCxDz1ggUdFAJbqNfJ8hiimSkddkqflYXl1FXnw5cnv7WwZY+o+CeRDovNNiYmvAuf1
         9PQkYxsDywLrHaxP2uZlVW43Yl7MLMSozXpZTHsvu4s5dwTG+VEZLMXhPJE7PQcIYLRu
         4qweW//f0qUrv8KtTZOxHn1poNziIK3kwIguxMjJ6EV8PJuEBq0HoojGI4T0IrzNWc1m
         mzVLngRK8/FjW3xAE6p//nqZ4V1Tq4ZdzDZPTWbcDbG1pZgpXNtcF4KxOaTDwy7HXnkZ
         q6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694331859; x=1694936659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c50+csNixrAL652I8a2nGfpKGvkeir3Xklb+hUPR40Y=;
        b=VKHwZXCgiPiAV5zVMJ/MhPHCo4hb01Tjd4XIM/7WBuHbY0U4ajsnVT8S+Uw0gHYfrA
         bzq8G7GYLzaAjE27uA8TMU6PN6z7UydwOmZ79HxSVvJ7JXsbd8+q8yKFv6Ajg+in6PLS
         VuhJBhywrgWdPjT361lZ61Y7Zu2SrHFJ1vbVoMh0MB8Vx8ISvnZEwtQyL2nFDBmxaa+u
         LZ/wrxQ9wwJcTOqy7WD0mVe48ugwHQR1fv5CHGTBl958DXDVyTmSRi75xK0/4VzFu1f2
         IVzCNhXvGj+7d34OoiBliiBKUHdbmlVYA4zWlxvFaqkyghO0REblwFNK/t+bFDdA7TQO
         Qe2Q==
X-Gm-Message-State: AOJu0YzUUG/xmnStkBA5jU8Lv9xTWFqx2IDhJibL+chOcyBERXMLDoDI
	NQIa0n8NNGq+lOH65Ec9OaAtKpyCoNexC/gRe5k=
X-Google-Smtp-Source: AGHT+IF85GxCqI1nmf/BUSpIO+3OcIzI4r8N/ZOdJLekOlOO3w6LQAX+Or4XjtalLh5iVsJQpEJiqJ/55ic8kjF6NcY=
X-Received: by 2002:a05:6870:2155:b0:1c8:baa5:a50f with SMTP id
 g21-20020a056870215500b001c8baa5a50fmr8754232oae.27.1694331859157; Sun, 10
 Sep 2023 00:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694202430.git.pstanner@redhat.com> <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
In-Reply-To: <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 10 Sep 2023 10:43:42 +0300
Message-ID: <CAHp75VdAXBk2GzNX+b2-t62biuOn9JHMupaVbBuVkDn5PRTg_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
To: Philipp Stanner <pstanner@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Christian Brauner <brauner@kernel.org>, 
	David Disseldorp <ddiss@suse.de>, Luis Chamberlain <mcgrof@kernel.org>, Siddh Raman Pant <code@siddh.me>, 
	Nick Alcock <nick.alcock@oracle.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Zack Rusin <zackr@vmware.com>, 
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, David Airlie <airlied@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230910_004421_172523_59EF4FFA 
X-CRM114-Status: UNSURE (   9.87  )
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

T24gRnJpLCBTZXAgOCwgMjAyMyBhdCAxMTowMuKAr1BNIFBoaWxpcHAgU3Rhbm5lciA8cHN0YW5u
ZXJAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBDdXJyZW50bHksIHVzZXIgYXJyYXkgZHVwbGljYXRp
b25zIGFyZSBzb21ldGltZXMgZG9uZSB3aXRob3V0IGFuCj4gb3ZlcmZsb3cgY2hlY2suIFNvbWV0
aW1lcyB0aGUgY2hlY2tzIGFyZSBkb25lIG1hbnVhbGx5OyBzb21ldGltZXMgdGhlCj4gYXJyYXkg
c2l6ZSBpcyBjYWxjdWxhdGVkIHdpdGggYXJyYXlfc2l6ZSgpIGFuZCBzb21ldGltZXMgYnkgY2Fs
Y3VsYXRpbmcKPiBuICogc2l6ZSBkaXJlY3RseSBpbiBjb2RlLgo+Cj4gSW50cm9kdWNlIHdyYXBw
ZXJzIGZvciBhcnJheXMgZm9yIG1lbWR1cF91c2VyKCkgYW5kIHZtZW1kdXBfdXNlcigpIHRvCj4g
cHJvdmlkZSBhIHN0YW5kYXJkaXplZCBhbmQgc2FmZSB3YXkgZm9yIGR1cGxpY2F0aW5nIHVzZXIg
YXJyYXlzLgo+Cj4gVGhpcyBpcyBib3RoIGZvciBuZXcgY29kZSBhcyB3ZWxsIGFzIHJlcGxhY2lu
ZyB1c2FnZSBvZiAodiltZW1kdXBfdXNlcigpCj4gaW4gZXhpc3RpbmcgY29kZSB0aGF0IHVzZXMs
IGUuZy4sIG4gKiBzaXplIHRvIGNhbGN1bGF0ZSBhcnJheSBzaXplcy4KCk5vIG9iamVjdGlvbnMs
ClJldmlld2VkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+
CgotLSAKV2l0aCBCZXN0IFJlZ2FyZHMsCkFuZHkgU2hldmNoZW5rbwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
