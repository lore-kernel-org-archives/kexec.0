Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F37CD98F6
	for <kexec@archiver.kernel.org>; Fri, 19 Jun 2026 12:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GeNrhO16hrgTC34xhsR8fA1n0GfOwZN3MF4DADT7KD0=; b=kFPP+3CsdEWuLHTp8ofr32cwS6
	FB4tBJAcKQbb9PpMhP5QQLrM91CI+MNzPVgavYB+OnsNia+l+rKZG/7byrVlSbb7BeGD7I2EAv0Kf
	tYNuHsHU2SLH2l1IAlJgCNWBCXcNn2IRTOlRTw5FAWL4d5+hfvR2B+RD7Vuh+vPTJzh8FM9yQ0Nr8
	HZZGz9VuT/fB4/aYx1goc+5lxRd5Dm0Mjvf63hn91lif93cgRQYWdc+wy9qyk3kjIHSOm++7RLYg2
	WYMEf9gy4sxfqjVAQSpxNGGt9AKxvxHi24IpFLR9ruvby71gJi/CKPZ/v3+J0LpegaO5xZ90pD6zx
	goLgPljA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waXtP-00000002MR6-2R72;
	Fri, 19 Jun 2026 12:00:15 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waXtN-00000002MQV-1BHz
	for kexec@lists.infradead.org;
	Fri, 19 Jun 2026 12:00:14 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-69681505eabso1149693a12.2
        for <kexec@lists.infradead.org>; Fri, 19 Jun 2026 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781870410; x=1782475210; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GeNrhO16hrgTC34xhsR8fA1n0GfOwZN3MF4DADT7KD0=;
        b=lawFRiWuVKcCQB8zPq8sERCLt/LCrG10fL72bGxu5BIkUXOB7FJiJ9e6zoSA2h6+Ak
         mxeToKzwc4n/ViRY1R/6IrVr/+HO2uvhgqUex77iqMAx+LXJuIvsaqjJB7xvizT/NKcx
         Dy+bSeHLhye6hbBPfBF1w7Vc2LtI9EToxs3WDRR/zIege552nabmg1oE7YSlsirA8d7V
         Zs9SVmXVDqJvdpOnXKnt1q67Z4pDzMQDgR2Uk2kOLcTjCBy9sKnpim5cah/R7COyT3cw
         WmLfp4evuE8CxBwyH1C6gullX9tA7wQGy8SsilOe/9KykizINBLjGp+gh6a/qpxVDBjV
         X8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781870410; x=1782475210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeNrhO16hrgTC34xhsR8fA1n0GfOwZN3MF4DADT7KD0=;
        b=MXNVzDGUwXNrfbR0INlsLjZRvX2l/xJj9FXaaUsh31xy4lOyE6W06rU9xLdWkkcF5d
         jCzMwMaEyKR9YL3rp5/7JDxFcoJebhDru6a/7mwccOqjbbYphHx6QJxFVMSGX1Sx1bA+
         ExAuz/sLZXhw6Z0hujOE/k06FNagiettR4Exr8KicLS+Wg53TUqG0N8ZiUyqrJ7eA46x
         cwrf8Zx28iQucKnsEScphgzsINhIiq3YVWBHOZI/4gWmYKX/dkvEVZgXe0cftVgIa2hV
         ohmMIIf082H6RkNbhngtZUJbcwTenWqy63ivEyMizg8Gb4pn+g3T0Bp9bTB1n3w4opUI
         JisQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fTq+IVyt+lpIIaHrXxIpdzXeCxQdABGEsWIjXCsd07keAWiuw2hfHhG/qyse/4Wyu/ZW1WA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxCutnLzqLdS/ig3VaYCqoDKkMegmcjku1EdjdJ6MuAGlSe8IaJ
	De+yet5icT4vk+4/3dPhlmFaxKbWUQlPTKa3/UbE9M9kofaXJUNsgdiXkSLvpKhcL79iQD112MU
	15NnKrCQ8lOPOTY/1zQ==
X-Received: from edy20-n2.prod.google.com ([2002:a05:6402:5354:20b0:697:647c:fe28])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:13d0:b0:66f:2ea5:c269 with SMTP id 4fb4d7f45d1cf-696e520cebfmr1885043a12.15.1781870410243;
 Fri, 19 Jun 2026 05:00:10 -0700 (PDT)
Date: Fri, 19 Jun 2026 12:00:09 +0000
In-Reply-To: <cover.1781615759.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1781615759.git.tarunsahu@google.com>
Message-ID: <9huzv7beloza.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v2 0/2] luo: migrate serialized_data to type-safe KHO pointers
From: tarunsahu@google.com
To: Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_050013_326050_6678F9EA 
X-CRM114-Status: GOOD (  11.96  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

+Mike, +Pasha

This is currently rebased on top of mailine, also can be applied to
liveupdate/fixes with no conflict. I would like to know which release
cycle we are targeting for this, so That I can rebase it accordingly?

As for liveupdate/next, it needs some conlfict resolution.

Tarun Sahu <tarunsahu@google.com> writes:

> Covvert raw serialized_data to KHO serializeable pointer (KHOSER_PTR).
> This series also takes care of resolving the bug with memfd of using
> phys_to_virt before checking the args->serialized_data value.
>
> Tarun Sahu (2):
>   kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
>   luo: Update serialized data to serializeable pointer
>
>  include/linux/kho/abi/kexec_handover.h | 12 ++++++++++++
>  include/linux/kho/abi/luo.h            |  6 ++++--
>  include/linux/liveupdate.h             |  4 ++--
>  kernel/liveupdate/luo_file.c           | 24 ++++++++++++------------
>  mm/memfd_luo.c                         | 18 +++++++++---------
>  5 files changed, 39 insertions(+), 25 deletions(-)
>
>
> base-commit: 0e0611827f3349d0a2ac121c023a6d3260dcecdb
> -- 
> 2.54.0.1136.gdb2ca164c4-goog

