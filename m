Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA22CD5BB7
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 20:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lI5mS1q2qOObabKUBbKfb1QQJkZ/uNYoefmzXL5rBmg=; b=AV+9lqdkhrPKesvGIYSHov4wiB
	85mhhRFKVC4OtuQlT1Z9qIjyzMgffdhBxxrX3Tym008tUJfZc73J/8FOSYJJIoNidHjibbgMaMiGC
	NsorBkPtyeflChTkpni5rN6aAy5ZsBhe5i1Pt5Pkb4N/JHoYEPT0cc4GWdIY6l0m24lBKMFpvmj1o
	V05FxJKuJ/7SuVeo2bejXYYFOOBKPMEMGYNkk4rh2gZ1tIzvqXq1QBkiXd6cy7AHzQNe7RwDXyQqY
	IgHJukI63AIesuYo4PgCQ8EORIU0i6Ax7U7lGVGCsFjEapXP8nROB89FyE80aa+M+m5BQ3cdkc3wq
	IUa+5nPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPr-0000000BrrF-2K05;
	Fri, 22 May 2026 20:24:19 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPp-0000000Bros-1cd3
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 20:24:18 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-3663d5e9bf4so7327405a91.1
        for <kexec@lists.infradead.org>; Fri, 22 May 2026 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481456; x=1780086256; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lI5mS1q2qOObabKUBbKfb1QQJkZ/uNYoefmzXL5rBmg=;
        b=AEuj/8B3Vm1f7Bv/veqKd/k2BDTx1tRH8/pxjaOvtWwoNfAgnWeBymFxZM7fLqn8KP
         EtcEeN+ZMWqCtpBd5ji150qzYMD/nbG7gBkkXDQ6bML+uPfPoDriF2ODiQjF/t85FQJ3
         hg8Nsl/hzSpyOicrnNHm/xEAWu5ZTw4hSMxgj1O89c+ZZo87O0mAUve0ENcEzPS8Vewl
         37Vb2368nYvY/2AlJQ5BMpcr/Kt5OlZ956/dFSSI2rRnS64YXiZZeavMHTqHQifFEmS9
         X/86HHMJ8/fVtJifSA9Tr2zGJ/3CvPo7wSN5B0cn5M+Vig+4+73gUBKnTL64KdA9VYb4
         Vkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481456; x=1780086256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lI5mS1q2qOObabKUBbKfb1QQJkZ/uNYoefmzXL5rBmg=;
        b=DihKnRo1D3YdZIa+CGO3T15tvIOlLCRGhsM1XwJC514eLijAWjHqfzfgjqOpTdwKEl
         HKEofXOf7YEAn+dSXjgh+VL2wbB7JogkZtjiMGSAqTWtNH3CHkfO03JG06Cf26ZD2P4x
         5RUOJVD08kqdE9vhb7bnY+XB5F7j7R3FcoIFjfMLk/FjtV3MoqTc0M3MfK4vAITy/xIg
         7YTA/pkWUeiZcNtZpIG6MHtt7eW1IN/7rY+Q3LtAsZgVKRZjnIraSjThZOW1O6Uz4Rll
         HFJOE/ck1iicKOsorxenC2ZVOfMJZGoSPGz5RWKlH8f6A5MQfmkxirX8IehiR7a0i/s5
         GX/A==
X-Gm-Message-State: AOJu0Yxce8ptSt8How6pzzkIKVa21DgMkULYb/TScTw09Wg4F3uMFFU2
	7JLUsf+jgf0/RINDNkY3HoAPuU3rducqfML3iqXevruJW2nu1nTvg4gU8mKx0nx4tQn5GG0Q1g6
	Jd6ujHxdbRn5EpoSzggaRM8F3OFDYQjlxSKpdkOECkWqRase48OEZd9GmtUDnMAv3gie4XgsYVU
	t4cKVQYANAcuhdLQgQJhaJYelTT9oBfFg9TY4Vbs9AXx2vwgBCrm4=
X-Received: from pjyv15.prod.google.com ([2002:a17:90a:e98f:b0:365:ca4c:7afb])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a8e:b0:368:78da:803 with SMTP id 98e67ed59e1d1-36a674f81fbmr5156953a91.12.1779481455496;
 Fri, 22 May 2026 13:24:15 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:02 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-5-dmatlack@google.com>
Subject: [PATCH v6 04/12] PCI: liveupdate: Document driver binding responsibilities
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_132417_428599_9DFF4924 
X-CRM114-Status: GOOD (  12.12  )
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

Document how driver binding works during a Live Update and what the PCI
core expects of drivers and users. Note that this is only a description
of the current division of responsibilities. These can change in the
future if we decide.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 96c43b84532c..4f2ec6ffdd16 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -70,6 +70,22 @@
  * preserved. These may be relaxed in the future:
  *
  *  * The device cannot be a Virtual Function (VF).
+ *
+ * Driver Binding
+ * ==============
+ *
+ * In the outgoing kernel, it is the driver's responsibility to ensure that it
+ * does not release a device between pci_liveupdate_preserve() and
+ * pci_liveupdate_unpreserve().
+ *
+ * In the incoming kernel, it is the driver's responsibility to ensure that it
+ * does not release a preserved device between probe() and
+ * pci_liveupdate_finish().
+ *
+ * It is the user's responsibility to ensure that incoming preserved devices are
+ * bound to the correct driver. i.e. The PCI core does not protect against a
+ * device getting preserved by driver A in the outgoing kernel and then getting
+ * bound to driver B in the incoming kernel.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
-- 
2.54.0.746.g67dd491aae-goog


