Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AE6C7618E
	for <kexec@archiver.kernel.org>; Fri, 21 Apr 2023 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d460fS01uK579vgTOli+MIeC0jra7YzpPRDVLKTge4o=; b=MJKPUkrqPwKOy3
	RmjwmiqObVKTIJfKGcR/h+nMu/VD4OM9J8szrtqwIbPr6YZsvof2TX29CUehSaoHy6fnps8V78NVJ
	yFZfoqORi/twA7V68fbhn2Ybs4x38wr76GAu1q49raCwSBt3jbGjM0QgHLf/fg9voM2gTgUac59hH
	ZowPXtrkr3fGbsI5ibqoepKQd9zA4tm4lsSMTmFFjQp7pGX39UD6MQJtNnUOi1g7zTUhBxaFi2qwQ
	zM/5DTd6JyHmMLwi9ze7cB5DcEDl8IPtFv9oWlo1aFKllEofmpHdLA7oOWjoITapid5MK/IgBywUg
	LZJVBMms8FQbOd8HwStA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pplXL-00A1F6-2J;
	Fri, 21 Apr 2023 07:50:31 +0000
Received: from mail-yw1-f182.google.com ([209.85.128.182])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pplXH-00A1E2-37;
	Fri, 21 Apr 2023 07:50:29 +0000
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-54f8b46d031so14901997b3.3;
        Fri, 21 Apr 2023 00:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682063426; x=1684655426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkpYhZmr123XoZwxeuyT9/faeSkMZw8H0JzS3L2I10s=;
        b=JlVQTAI2OM1AQyAygW2OgPZPFc8sz47SGUglW37Al3EDIKxq48eCePBQLyu4s+zDvp
         6lhLctrFSZZBKSiNRTvt2KWASnDrEJNCQE4HLkLle6m3moYI6NTukjQBdJX/1e+Qjkdl
         GnTtbio1wu4xNRQ+3hZEnHuuQOUIaU0sVQyHHdre21ylyP2deC5vpuvvoeQCE4MDje+r
         x1CccIfwxUODA6Qqz8W9lX08QaMFbQ/1K/Kxu3K4fETpUZxnHKS7P3JTx0dt5pOwQ+HY
         0wuENkaR9LG4CDUS9grZFPiIILvhrvEazi0q3s6NGNzpt71+uq+eeUGh3a/NgWl/iZdt
         3YAg==
X-Gm-Message-State: AAQBX9dHFbeMcG/VNJ5LHl7yFWtcFbZmqbjytAG6GPDIvWGk3lVHwb75
	cjB21auz7yLvwvPSIc6iWXcsPNAsLsVPLjmt
X-Google-Smtp-Source: AKy350YYUgLTVHVREJpQm47pUOGcqayWiwbTlz2iEjO96KaDFw8pcOS20S7BsDCdMu+hkvff+/uaig==
X-Received: by 2002:a0d:c644:0:b0:54f:895e:70ff with SMTP id i65-20020a0dc644000000b0054f895e70ffmr1287772ywd.21.1682063426083;
        Fri, 21 Apr 2023 00:50:26 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id g137-20020a81528f000000b00545a081847esm820804ywb.14.2023.04.21.00.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:50:25 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-b8f51500a82so1678201276.2;
        Fri, 21 Apr 2023 00:50:25 -0700 (PDT)
X-Received: by 2002:a25:4d8:0:b0:b98:c9af:b9c7 with SMTP id
 207-20020a2504d8000000b00b98c9afb9c7mr1724109ybe.26.1682063425192; Fri, 21
 Apr 2023 00:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-m68k-kexec-include-reboot-v1-1-7552963a0f25@kernel.org>
In-Reply-To: <20230421-m68k-kexec-include-reboot-v1-1-7552963a0f25@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Apr 2023 09:50:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUuV=JmoLoEOL1TfBBmFAMbqOGz0oHn3kz1QN_7s_uObQ@mail.gmail.com>
Message-ID: <CAMuHMdUuV=JmoLoEOL1TfBBmFAMbqOGz0oHn3kz1QN_7s_uObQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: kexec: include reboot.h
To: Simon Horman <horms@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230421_005028_006963_4A11F823 
X-CRM114-Status: GOOD (  14.10  )
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

T24gRnJpLCBBcHIgMjEsIDIwMjMgYXQgOToxMeKAr0FNIFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4gSW5jbHVkZSByZWJvb3QuaCBpbiBtYWNoaW5lX2tleGVjLmMgZm9y
IGRlY2xhcmF0aW9uIG9mCj4gbWFjaGluZV9jcmFzaF9zaHV0ZG93biBhbmQgbWFjaGluZV9zaHV0
ZG93bi4KPgo+IGdjYy0xMiB3aXRoIFc9MSByZXBvcnRzOgo+Cj4gIGFyY2gvbTY4ay9rZXJuZWwv
bWFjaGluZV9rZXhlYy5jOjI2OjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig
J21hY2hpbmVfc2h1dGRvd24nIFstV21pc3NpbmctcHJvdG90eXBlc10KPiAgICAgMjYgfCB2b2lk
IG1hY2hpbmVfc2h1dGRvd24odm9pZCkKPiAgICAgICAgfCAgICAgIF5+fn5+fn5+fn5+fn5+fn4K
PiAgYXJjaC9tNjhrL2tlcm5lbC9tYWNoaW5lX2tleGVjLmM6MzA6Njogd2FybmluZzogbm8gcHJl
dmlvdXMgcHJvdG90eXBlIGZvciAnbWFjaGluZV9jcmFzaF9zaHV0ZG93bicgWy1XbWlzc2luZy1w
cm90b3R5cGVzXQo+ICAgICAzMCB8IHZvaWQgbWFjaGluZV9jcmFzaF9zaHV0ZG93bihzdHJ1Y3Qg
cHRfcmVncyAqcmVncykKPiAgICAgICAgfCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPgo+
IE5vIGZ1bmN0aW9uYWwgY2hhbmdlcyBpbnRlbmRlZC4KPiBDb21waWxlIHRlc3RlZCBvbmx5Lgo+
Cj4gU2lnbmVkLW9mZi1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPgoKUmV2aWV3
ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+CmkuZS4gd2ls
bCBxdWV1ZSBpbiB0aGUgbTY4ayBmb3ItdjYuNCBicmFuY2guCgpHcntvZXRqZSxlZXRpbmd9cywK
CiAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0CgotLSAKR2VlcnQgVXl0dGVyaG9ldmVuIC0t
IFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9y
ZwoKSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2Fs
bCBteXNlbGYgYSBoYWNrZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkg
anVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
