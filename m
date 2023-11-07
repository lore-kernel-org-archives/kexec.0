Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BE2C04E85
	for <kexec@archiver.kernel.org>; Thu,  9 Nov 2023 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wRGBRolV7z++f/GdkBBA+QdjW0ddg8GYhOU7iKjN3Ac=; b=NjpSMJ8/I1Y+KV
	CkOpLXaud5cxpfgf9vCKEwVQAfv+hROe02M+DUNfW1fqKnxUlLbtnEqz9+cBvUQbOjgFZSqw+R2kO
	ivLNjt1uT6K9HdtQm5NfblgUy70zpT6vJXdByPLdPfkWZKUbIVSAPAz1rskzplqfWGa2E+WLBMIXe
	w+LTCGNQg+X3ogBoDRYfdzZU55DvEfIGo7+XLHJ9CgKYQtaQBhBgTFQxkUSxop0SHbRnXOWFO9zoh
	wDb4J9SeertfKGbJJaG/8MJCQzfFI3BS4d3k7rqxdSlqKr1zo4omvaLWwZlVLdeotZ4GZpKvjqOvV
	htHIbWi4YukxFB9m4FMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r17oE-006hxt-0u;
	Thu, 09 Nov 2023 16:23:10 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0QcD-002Aj0-0V
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 18:15:54 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9d216597f64so920323066b.3
        for <kexec@lists.infradead.org>; Tue, 07 Nov 2023 10:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380951; x=1699985751; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLCkkkRy0xyxhf2w0mzTXDWxtj3x83g3Dw/kY8liqxs=;
        b=aY6oocPxcyObBfC5KACO7tj9NkxAVqlvYGYc9uS7A4/DVfF72CkEg5Sg1oRpwyo1HS
         5kyhWQp0acb60H1qKAnrzIPvx4tXBlRyAQ4P926GG2iRRwmt/Gk08PlApNhKystwY5Fj
         l0T4ouFttcHuPxH8oPeu8PuRE7C3nBaVhKIKUX73UfLV2mSt9GMXK1a8vK2i+e1/nvNF
         QwRkzGnntC9+mslSF4yKrVFUFj48tGgAH3doHLanmZquFEsWH5R3OhPIRZyyOn31clQc
         8FEx40c8mB8palx5RdC7iv04JKW2qNrDPG59Cc6/hFsPYVpedjcWcMlMMMnbhWmtdcr5
         rn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380951; x=1699985751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLCkkkRy0xyxhf2w0mzTXDWxtj3x83g3Dw/kY8liqxs=;
        b=VLgk5eU8eO2rNvZshkRHtw4OYVEkXi7hVIXyNOs5Y/WU3LRNpxhe7C75B46TwAxG7Q
         ZdAMS4ASTnuUDLXQK3lIbEeVzOQNLWOiZtDVGem1bkM0ZrQDgd+/p7d/wMFBUtU9f3ot
         +95KJTRI3NeHVslvjdArX87vbnzA1CZFjd7IiC0TvpD3DltaPylesgmUwRqEDCtAmoSL
         Op72Pmi5802SRsNfF7bvelf0k/nBzAR1HuO7ezO/VuAMp2Zvl13B/uSzTLdQ69rBIdAh
         D3wwXc4vOM3SVh7KEzGuCWDogs6UK5cJMc5muUxSeeEjYUfPSDbjWqGsVkJ0MuPtNiuj
         UiRA==
X-Gm-Message-State: AOJu0YwLW9akW7fraJjSutW2AzJ64Lff/g527+HdtvKXP4AE/ryAWBZ+
	Pxfa7UXAswFsQfgSzZAWfziosBJq1Z+/POTlqhE=
X-Google-Smtp-Source: AGHT+IEu5edPr9vVltsuODkwaa50hcmnHTRA8lKcWKQoW6T8vdFZrs7ih3QwA4MmdyUXquI2lxrp4aEhdeZvuQjGSwk=
X-Received: by 2002:a17:907:d21:b0:9c0:eb3e:b070 with SMTP id
 gn33-20020a1709070d2100b009c0eb3eb070mr17256502ejc.69.1699380950186; Tue, 07
 Nov 2023 10:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-10-e4ce1388dfa0@samsung.com>
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-10-e4ce1388dfa0@samsung.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 Nov 2023 10:15:39 -0800
Message-ID: <CAEf4BzZY0TATP4ug54j43o=qDvHBe8xW=hKwRRTfBuLUKGjrmg@mail.gmail.com>
Subject: Re: [PATCH 10/10] bpf: Remove the now superfluous sentinel elements
 from ctl_table array
To: j.granados@samsung.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, josh@joshtriplett.org, 
	Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, 
	Iurii Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_101553_194938_20A71277 
X-CRM114-Status: GOOD (  18.51  )
X-Mailman-Approved-At: Thu, 09 Nov 2023 08:23:08 -0800
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

T24gVHVlLCBOb3YgNywgMjAyMyBhdCA1OjQ14oCvQU0gSm9lbCBHcmFuYWRvcyB2aWEgQjQgUmVs
YXkKPGRldm51bGwrai5ncmFuYWRvcy5zYW1zdW5nLmNvbUBrZXJuZWwub3JnPiB3cm90ZToKPgo+
IEZyb206IEpvZWwgR3JhbmFkb3MgPGouZ3JhbmFkb3NAc2Ftc3VuZy5jb20+Cj4KPiBUaGlzIGNv
bW1pdCBjb21lcyBhdCB0aGUgdGFpbCBlbmQgb2YgYSBncmVhdGVyIGVmZm9ydCB0byByZW1vdmUg
dGhlCj4gZW1wdHkgZWxlbWVudHMgYXQgdGhlIGVuZCBvZiB0aGUgY3RsX3RhYmxlIGFycmF5cyAo
c2VudGluZWxzKSB3aGljaAo+IHdpbGwgcmVkdWNlIHRoZSBvdmVyYWxsIGJ1aWxkIHRpbWUgc2l6
ZSBvZiB0aGUga2VybmVsIGFuZCBydW4gdGltZQo+IG1lbW9yeSBibG9hdCBieSB+NjQgYnl0ZXMg
cGVyIHNlbnRpbmVsIChmdXJ0aGVyIGluZm9ybWF0aW9uIExpbmsgOgo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC9aTzVZeDVKRm9nR2klMkZjQm9AYm9tYmFkaWwuaW5mcmFkZWFkLm9yZy8p
Cj4KPiBSZW1vdmUgc2VudGluZWwgZWxlbWVudCBmcm9tIGJwZl9zeXNjYWxsX3RhYmxlLgo+Cj4g
U2lnbmVkLW9mZi1ieTogSm9lbCBHcmFuYWRvcyA8ai5ncmFuYWRvc0BzYW1zdW5nLmNvbT4KPiAt
LS0KPiAga2VybmVsL2JwZi9zeXNjYWxsLmMgfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVs
ZXRpb24oLSkKPgoKTEdUTS4KCkFja2VkLWJ5OiBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaUBrZXJu
ZWwub3JnPgoKPiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9zeXNjYWxsLmMgYi9rZXJuZWwvYnBm
L3N5c2NhbGwuYwo+IGluZGV4IGViMDFjMzFlZDU5MS4uMWNiNWI4NTJiNGU3IDEwMDY0NAo+IC0t
LSBhL2tlcm5lbC9icGYvc3lzY2FsbC5jCj4gKysrIGIva2VybmVsL2JwZi9zeXNjYWxsLmMKPiBA
QCAtNTY3OSw3ICs1Njc5LDYgQEAgc3RhdGljIHN0cnVjdCBjdGxfdGFibGUgYnBmX3N5c2NhbGxf
dGFibGVbXSA9IHsKPiAgICAgICAgICAgICAgICAgLm1vZGUgICAgICAgICAgID0gMDY0NCwKPiAg
ICAgICAgICAgICAgICAgLnByb2NfaGFuZGxlciAgID0gYnBmX3N0YXRzX2hhbmRsZXIsCj4gICAg
ICAgICB9LAo+IC0gICAgICAgeyB9Cj4gIH07Cj4KPiAgc3RhdGljIGludCBfX2luaXQgYnBmX3N5
c2NhbGxfc3lzY3RsX2luaXQodm9pZCkKPgo+IC0tCj4gMi4zMC4yCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
