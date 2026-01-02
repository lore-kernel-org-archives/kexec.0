Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46D8FA3751
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lVaoN1eh3C57/bKSyAYQv7yupDKJUH9rxo6P57vyXQE=; b=tS8PR82SWsdVhB
	XlA4ED6sFPcCU+Izg5k3O7hcx/20GSbRsRqg1k9wSp7Rp9EN4RUE4z27QpgTV5YEoo52cYH0L2Zu0
	ePKNVixCumTEgXAHpQnsAm51mNRUgLicBqrWpVHt0K0JORe9Bzg3nPG15MmEJeJhLTuJAM3ITkLoB
	mFvPR9T4yjiviM6DWYENM5o3fNe0heMPkgIxxnmRxI/gD1Ew3a4GMauRT+QywRZ0HIRH6I5VBAiYu
	Sa8Ch/RLKKUg9NptfpMtb0YXRdx985SzJcOlQKCeQKUw/5zImYXih1zUPlDfuiB57asduBZEueB4p
	rUaTOlvwKwJD325sdLrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgXD-00000008OIs-24bO;
	Fri, 02 Jan 2026 14:53:47 +0000
Received: from mail-ot1-f52.google.com ([209.85.210.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgXA-00000008OHa-2Tks
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 14:53:45 +0000
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c75a5cb752so8621823a34.2
        for <kexec@lists.infradead.org>; Fri, 02 Jan 2026 06:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767365623; x=1767970423;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVaoN1eh3C57/bKSyAYQv7yupDKJUH9rxo6P57vyXQE=;
        b=VZnVQSGzaGiOXkIl/2HLM5blfYCjHNgCqlxqpKHNUxPEjTwYNQqvx/kMDCY9hBC/t+
         8MwmecLbm4IkkrvPha02cY3cNZraHPkN6VBFX+3lxh2G/m12s2zV2MhNijGsnlKle8PE
         rX1Fd6JjvszllnFGElwYB6hNMIsVQYo33RNSI5EJmFa4x/BNWI0xDSdCGeG6mADy0EEh
         SaTac+jvr5KuzMG3UeEpiiQp76mtUiH4f4yTDriHol0KvX6rIlWF6Xmnn34rkiORteut
         +TOGzqOH+PWOji1QIXuksUI+amdAFR4I4iRkNEZIKiOXai/y3bjU1LFwGVX5811sPouD
         ifzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwKFdAaqPz6Ef4Cx7qDBB5xj7IGQe/hsdDTqGYC9jBaiGRL0m7ZOk7wjcOzriVH/OyPQ0R1Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwDevnHHJhp6ddvM1MuKvNZ+5TZtAOGS3H2noyJ1FFEg0JrgA48
	SiW5MFIT4OPfjvdNoX/slK2IienuVLBcn7gCf+TFe6t46H99hACXwEKo
X-Gm-Gg: AY/fxX4ffBNfnqH8XvmGb9MfGRC8tT6B1BZYvR+c1aNyJl1VCj8Q7WW/zcR8gVNbk+G
	d5XIYzVNlGZa71Wh5b17ZZ5a4LAm9Qx5TdVcj/VTqcnvwlZEGTpakUPlfTbZlJqnO4jSjdO77N7
	iGu6rbUNTAxF4lBX+YBE4kLC8hZ7IfjJQTQp+V3v7w2LYLi19GspieWo4nBBeuhUI9z6UZh5WLt
	UDR8x9sB49PEzi+rcvFWnsnYKxKsvSp9FkSqIf79ytnMcJJoIvuSDZEDB7HnHfDzg3xUhzPa7Rx
	EX6fTt/AHPUZJ13hF0+peWMwtvBzV7DH4zR0ShElNI6Yz2NjL6FRn/mjjkiwNK6edMkZCNQyiUy
	FMJ/BSSR/HhoDSYauL7TC0Z0CQt6Tp8PaC44g1WhAMZCM5OD6sGGGhjFFOgGDR+OKkfijdl4af2
	fmIFM8UDWh7RreKBONTzFdp/HQ
X-Google-Smtp-Source: AGHT+IHeJsGZ/SX/hNY+45CMBgjyMFy5KgBCY+PBAVGiHHhPJdSaaqy8TMKvsf79sPPpSXptC0AkzA==
X-Received: by 2002:a05:6830:6d05:b0:7c7:6a17:ba35 with SMTP id 46e09a7af769-7cc66a49319mr27427721a34.31.1767365622904;
        Fri, 02 Jan 2026 06:53:42 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc6673ccc2sm28367487a34.12.2026.01.02.06.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:53:42 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 0/2] kexec: history: track previous kernel version and
 kexec boot count
Date: Fri, 02 Jan 2026 06:53:22 -0800
Message-Id: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOLbV2kC/1WNwQ7CIBAFf4XsuRjANtie/A/TAy3bspqAgUo0D
 f9uqCePL5k3s0PCSJhgYDtEzJQoeBiYahjMzvgVOVkYGCihOqnOgj9c4FoLjRejcJEIDYNnxIX
 eh+U2/nZ6TXect3qthKO0hfg5MllW7t+YJZe8tbrvjGqt6fFqcSLjTyGuMJZSvhGNpRqpAAAA
X-Change-ID: 20251230-kho-7707e8a2ef1e
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2329; i=leitao@debian.org;
 h=from:subject:message-id; bh=i3CmEWPm0Y4/Vry1pju4wRoGsXN3c5nNvQGe4fhn/iY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpV9v12c+ZP5H2du0LVIKF7c1HtTaqzRJyfSxRA
 vimJBZ+gq2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVfb9QAKCRA1o5Of/Hh3
 bT4HEACpMoA/+5gfeqIvqHqN6gPej2Pyzyh+VChw9mh70O9Hvkw2x/R/PcPDxAa4cGNgN7FSqyl
 eTtdEYZDfzHqnWoZu/+3INPDVs549mMYYFI/eLLHjJ4wAevmGRVrWSJKL98VIAvNe07TR0DFM97
 1wiqosuV1WoNekZj1vxlwq0cruI65HuWh2eHEJyepVuGkTiEOJVtxgAIfZz4/v8SoF3e2vq7/6K
 3QVmO8DA49GnOHkbu636cWyeQsMAAVBru22UNBo4L9hm4VIXJrfn/L4gwCf7rGCEIqJG508VaD+
 5xzUojyuc0JeuTSZcXLVQi3C5XE3uQxYf/R5seyzlw0m1qnGWPd5L1svaWw5s/1SawV/WxEK7QN
 HyhUb0DBykr2GrCcaYjf7LDZIjqlhqm1in6pKejY7ZMD5kH8TL4HktZepYJk7BYTARwQe/2VHH/
 jdTXiKe5+wqcGmQ8ojVQW8+D16yvWdSw8lWx44jSO2z6/p6sg8lbcnttEgPmNxn1Z3xYuQIzvax
 SPnbnWtwQ12k439dDzccUTYj6nOFQ+zYdZtiRwDjOHXaV/gz5T5K/Zp21ktl1v/OF51ApRQy57X
 V1tAgqFH2DD2FvQPjo5jeAnyspCMxVOndYxEw3jjjMnnGrFYEnznI54N5uHTDZYf4IKqR/7M9yU
 k/hgCgo34DcDsuA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_065344_657856_4F1C404E 
X-CRM114-Status: GOOD (  13.46  )
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

Use Kexec Handover (KHO) to pass the previous kernel's version string
and the number of kexec reboots since the last cold boot to the next
kernel, and print it at boot time.

Example
=======
	[    0.000000] Linux version 6.19.0-rc3-upstream-00047-ge5d992347849
	...
        [    0.000000] KHO: This kernel was kexec'ed from kernel release: 6.19.0-rc3-upstream-00048-geda7d9110f99 (kexec count: 3)

Motivation
==========

Bugs that only reproduce when kexecing from specific kernel versions
are difficult to diagnose. These issues occur when a buggy kernel
kexecs into a new kernel, with the bug manifesting only in the second
kernel.

Recent examples include:

 * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level
   paging transition")
 * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to
   avoid corruption")
 * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")

As kexec-based reboots become more common, these version-dependent bugs
are appearing more frequently. At scale, correlating crashes to the
previous kernel version is challenging, especially when issues only
occur in specific transition scenarios.

Some bugs manifest only after multiple consecutive kexec reboots.
Tracking the kexec count helps identify these cases (this metric is
already used by live update sub-system).

KHO provides a reliable mechanism to pass information between kernels.
By carrying the previous kernel's release string and kexec count
forward, we can print this context at boot time to aid debugging.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes from v1 to RFC
- Track the number of kexecs since cold boot (Pasha)
- Change the printk() order compared to KHO
- Rewording of the commit summary
- Link to RFC: https://patch.msgid.link/20251230-kho-v1-1-4d795a24da9e@debian.org

---
Breno Leitao (2):
      kexec: history: track previous kernel version
      kexec: history: track kexec boot counter

 kernel/Kconfig.kexec               | 13 ++++++++++
 kernel/liveupdate/kexec_handover.c | 50 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
---
base-commit: 7620f9ccfabbdaf07620381264d8b8d91412542f
change-id: 20251230-kho-7707e8a2ef1e

Best regards,
--  
Breno Leitao <leitao@debian.org>


