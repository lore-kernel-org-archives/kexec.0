Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FD8D1D486
	for <kexec@archiver.kernel.org>; Thu,  8 Jan 2026 18:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GxGOI4fTfH8u55B1DL8U4nm4ObzNusp9OL+d9L8pE9k=; b=yti2fR2cUtAX4E
	8sn7W6fpPxpHzap7YPT9yFWLvj38RqGsdT67wZBOuoZtba/kZFtEJgD0mW3IoF25hHQNJfBN0nond
	afaq7SX1WIOfEZoJ0LslaiXnHjWIWqZCe8jNDMvJpcpSkJAhy3UPPJ52WzOjV59tKJAFTyEulPBww
	vyfWXFDlCKLpjnPTVs/Z+V4MQ2viO9XuHCjDzVvNVCAzpmt/+sECfMa+Q5KNwClWed+198MP1U8Yz
	E98pt9yOfSI5a3WUrTrroRVaM+lsc6xz9EI4TdJOE2mhDTQsAAwQivQfT8SPvK9tyJCO27tgne40g
	NjQ6skngrUONoZGG5Rrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdul1-00000000cHt-1nT3;
	Thu, 08 Jan 2026 18:29:15 +0000
Received: from mail-oa1-f46.google.com ([209.85.160.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vduky-00000000cH7-002I
	for kexec@lists.infradead.org;
	Thu, 08 Jan 2026 18:29:13 +0000
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3fe3cc80bc3so1838324fac.0
        for <kexec@lists.infradead.org>; Thu, 08 Jan 2026 10:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767896951; x=1768501751;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxGOI4fTfH8u55B1DL8U4nm4ObzNusp9OL+d9L8pE9k=;
        b=eZlfVtXhJCw5ztdD2sn5otbhwSu8fuUCBBBQwOIiUV8k3B5VlBFM7bnYnPb5qigNcb
         On1ODkFhDs6PVgc4hFau2+9Fn7gnYHUH/8ah7Aia4yY1tqH/vQzqBKUOpWNu9yW20kQo
         2O0yXvDiKbOtVi+mMFwCb1whzEIiO2Vxa6ym0bJmuy9RLro4K+piU7YVHwdbD7ZEQ9zE
         E156yx6SxkDlKsqzC/KlI08KKTEmVdo39xoUI77my905ujLnmNRlWJV/yshbeht4BziS
         Cj2IW3ZwtPiof8fCV3kasQaYfGqBK+xq942XRq7r6MK2M296JAW1JxNW8NLO2RutAV9Q
         Xnxg==
X-Forwarded-Encrypted: i=1; AJvYcCWMAbhyvfTP/oDwuQ2IuH3GqlHn8A1keW9cW84ac4QckMpXSqnX+mqt4SeITXxhsyAU7GZcxQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyOZD9sPd8CbYFF6kW39JVtqxQXAW2l4PzBxcpHeMVncGLBH9My
	QG7I4TD0zXtDNnG8c5bVsrSUk/YNQHiwq9S7MgpPqzyRuCTd8sZ21Yw1
X-Gm-Gg: AY/fxX6bV1o6VrBLU5Lawu1plzYsCyxzZJDn7IR9f+ahaWdJvD6ArIn8Tgz1emrRAf5
	FEqkkTqoXlIzDX8weKWB6tpIKxeGe4fecZEUjSM4tuufej7DPWf2uPlCmumr0TWepJhyluaBWE6
	oXeVjnd3wTWwEDZFdENdV99OV3aU7VviAWjprHZpTN8KrUbswLYMtqaQ9f5XVQGzJmj5RscAEUl
	ZCZO6HXdaxtqAx0lpIDK7++Kz3lTYz/Y9I/hS7GQCO8MH6p+znRmnvr0lx/JqepYCxnLX1IpH4q
	0ln5TKWg1/yQMeh+ICQm2OMn0PC8kbYunxzey/ZC1kPpV6nxPHiZPQKeUureN+W5zh4vMUVoZBt
	+SySVCSJk0sN8iAzgqPaOob2GmsSu2Du2cedPWmlbLlV+89FR614ZUI2/owD9gEGTxXN7lw5pif
	eHWw==
X-Google-Smtp-Source: AGHT+IGjo79YzWbsVuqisuDsj8X6jFxioSTkbz2DzVGWWCeD2vs2aw6tQvT8I6ProgsJB1hbR2WPuw==
X-Received: by 2002:a05:6830:4426:b0:7c7:6626:b595 with SMTP id 46e09a7af769-7ce50a54edcmr4043973a34.3.1767890480527;
        Thu, 08 Jan 2026 08:41:20 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4781c447sm5684987a34.9.2026.01.08.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:41:20 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v3 0/2] kho: history: track previous kernel version and
 kexec boot count
Date: Thu, 08 Jan 2026 08:40:57 -0800
Message-Id: <20260108-kho-v3-0-b1d6b7a89342@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABreX2kC/1WNyw6CMBBFf6WZNTWd4VFl5X8YF4UOUE3AtNhoC
 P9uCnHB8ibnnLtAYO84QC0W8BxdcNMItcgzAe1gxp6ls1ALIEUlUq7kc5ik1krz2RB3yJAJeHn
 u3Ger3O77Du/mwe2c1EQMLsyT/243ERN3LEaUKAurL6WhwpoLXy03zoynyfeQkpH+UqVQ0S6RV
 BJ1oRs0uUFbHaR1XX9d6ZyF3gAAAA==
X-Change-ID: 20251230-kho-7707e8a2ef1e
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2859; i=leitao@debian.org;
 h=from:subject:message-id; bh=s1RRLh1s24N8vch0efEW4crrg2HPdZCHGJl+fLq95DU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpX94vATIWGxdN1+hN2/iDpZ64iATDNHKnAMXR/
 MS4BU5sz6yJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaV/eLwAKCRA1o5Of/Hh3
 bet1D/95jPd+3qRKS1ZBojBwI12XNWkxdzy/CpGuJX8MMI48vM1yS3kFweMp50BdaDU55SeilrV
 awhMthz6pAeCD99uMtDpQqIAtwtvxHK3gwMlI+SKxusGJaBnAo8XQ3n6KToJJuVPmYN/qXYkUwy
 K6WT4utD8kSPPCEXnsKKJyqPVMNvpLCWQlakaeZ5cVdgEf0f8w3tom9dG9WoNj3e3Gf2RQrWF7O
 HcRBAYjakjQjAPOxAV29/bxedtC5oiMF2WKrdPcmSRXUzDTJD/MPtoFH0mxOmqtbV37yNEUCL7z
 48bI4jeGkHv3h6dZGEUECk2P1zXrEiQH9kBRnLD6O5LiiiCXmx6P5ZishQyRFsy/EF0e5T2Y5OJ
 mvvLfYWb6WLvVVgV6IIJbFplD9T8EmRi40rSXPgTx+nrpAQWfabxlET6zuJ2wnIwS62emdYOhIQ
 7K+6vk9GWH2oSAYmrTkautpuE4rn/yQFv7PCO8J6mK7Wa6Kg/w/YqLw/rnVOKsg0UEzJH0tX2Oi
 jJFFtR8KTew9WLjXGfCkTA6agW21iWGwWmchIvSZeqgVdZX51cXF5udYkqk5/PsFDAgfd5YxFYT
 FO4W2yLAQmoN6CgjTzAbtXvBNDsBNy99A2q0SYl1KhR4y11iFfpsNYaLzm+HJkCfhUkOAEYXZVS
 ZcN/EBby9Yo3wMA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_102912_076605_BAF31616 
X-CRM114-Status: GOOD (  16.28  )
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
        [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107upstream-00004-g3071b0dc4498 (count 1)

Motivation
==========

Bugs that only reproduce when kexecing from specific kernel versions
are difficult to diagnose. These issues occur when a buggy kernel
kexecs into a new kernel, with the bug manifesting only in the second
kernel.

Recent examples include:

 * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
 * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
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

The goal of this feature is to have this information being printed in
early boot, so, users can trace back kernel releases in kexec. Systemd
is not helpful because we cannot assume that the previous kernel has
systemd or even write access to the disk (common when using Linux as
bootloaders)

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes from v1 to RFC
- Track the number of kexecs since cold boot (Pasha)
- Change the printk() order compared to KHO
- Rewording of the commit summary
- Link to RFC: https://patch.msgid.link/20251230-kho-v1-1-4d795a24da9e@debian.org

---
Changes in v3:
- Remove the extra CONFIG for this feature.
- Reworded some identifiers, properties and printks.
- Better documented the questions raised during v2.
- Link to v2: https://patch.msgid.link/20260102-kho-v2-0-1747b1a3a1d6@debian.org

---
Breno Leitao (2):
      kho: history: track previous kernel version
      kho: history: track kexec boot counter

 include/linux/kho/abi/kexec_handover.h |  6 ++++++
 kernel/liveupdate/kexec_handover.c     | 39 +++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)
---
base-commit: 5eec2b2e1f37acff8b926d2494eadaeef59be279
change-id: 20251230-kho-7707e8a2ef1e

Best regards,
--  
Breno Leitao <leitao@debian.org>


