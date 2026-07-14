Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEC4C4450E
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NsilKFLygw8IS3OsjN731JV3UeNVYFWUky8KZoNrr2s=; b=01s2XFfdZnHcPdsoS7J1WXjDsV
	xyFagnSvYLpEjQOvTGEw6z20dAmot5RCca+7PjiSW3lSp0xjki4BZeGTyqdugtcj9cfwdXwNVFc7o
	vXeUc92ZprP/dOlBTZIeqQFgUIq4jFNPAwD8+chtVZ4tKoCgpFaesCQiVSxjUStPtT+Z+lknMA67T
	9r36yT8LFNao79wS8P4FINNsYIrbjiC3LjajyyuGQhB2TvDsnDiHITVNMCCkAbe5D2q9DAplZPXKt
	3MxS/wAdK5klyM+hCGMhEVi0S81nQbnnxb9zHsELRMkwjNPKGvPZ3tpGPbWKUEdC5zy7fkA4JkpWx
	yYHPXOZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqs-0000000CU7I-1aZV;
	Tue, 14 Jul 2026 15:15:18 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqp-0000000CU3J-0E2R
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:16 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-848860def2cso4614413b3a.2
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042114; x=1784646914; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NsilKFLygw8IS3OsjN731JV3UeNVYFWUky8KZoNrr2s=;
        b=OE+aJGtgvwkpUB81K19yMDnn18ts5rK+Wp3lQBoqFbbN54akj7a9+ktDBQAvBjcRT4
         7DATY6JmX6aDGUlrK9wFv4Opo/3oAAgfMDLIWz63iaTgmij/rYLPPSiny4Z1ag6AQHhp
         /hS5ohv9Eqe+vWFPgbY6TdXzS2QmbrX72PBHcsVq5c7q9fhAFgac2A3J38vdWaX4Gjtx
         F7QCZpY/NvgYWxnDLhQm2n4B+8guOiXsx3vNgdnp5B0eug6na0TttfesVbuKvdNoViNm
         r6vtx1LOn//xBouKPYiodrRgA5oAow3inZwj5FuqrZDftaOao6F3wp1B3ariUpSfKilQ
         RqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042114; x=1784646914;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsilKFLygw8IS3OsjN731JV3UeNVYFWUky8KZoNrr2s=;
        b=WwDlwI0CAY4L8CvMnx5gSnu8xSCAK0vE6WkSQuUYJaR93JDRjjgGgvHb2Jjiw+Cjl2
         vW3RUXZAkh+2C1/XuDOdaOCFbVMuvzeM9Rj+e0i2KvUA+xDtokLtVj0xGFH0xOrwmg24
         953MmZiTdcEzYnljfs/53NefjhawfpTnr9skUhjTO72otly12OP/diw1ioZjjKYf88fl
         YilehJzxJC/UfohW6HSe0qra/IXqOoNVqFsgszcOTLLow5uRsmDXHn/WI0y/QEOqJpZk
         77XB2p++1JUaPwyyK3M+x/RFWHFEJK5SCss6DnvZd3xP6xOts5gO8uS50baRGFQS2y/Y
         SrlQ==
X-Gm-Message-State: AOJu0YzSJSHvAmZD/cZsugvDm+igkw6ig/CQw5vL7ThfAxtyDiZtRaBv
	oODbANfuiMCtgfXzS9dXjmPPfsJ6yjwCS/uOlcLe9SuoSaHjkrS9LYj1MHBRGN9hMP7tm1TccJB
	ZDJIEK2mViFQvUBXamrsSIQj1D5UDOMS6lPxzTIO32rr+9X6bG8ojrtFwWA3wWdqxuriNNn/W/6
	M0WebaoBkcZdYWL9YQM0UzWPjbdgXDPjAaVioNVaHoldotOw==
X-Received: from pfff9.prod.google.com ([2002:a05:6a00:bd09:b0:848:487e:d23c])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:992:b0:848:65f3:23c1
 with SMTP id d2e1a72fcca58-848897d7661mr12194779b3a.69.1784042113533; Tue, 14
 Jul 2026 08:15:13 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:49 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-5-vipinsh@google.com>
Subject: [PATCH v5 04/20] liveupdate: Export symbols needed by modules
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_081515_106490_846495C1 
X-CRM114-Status: UNSURE (   8.22  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Export liveupdate_register_file_handler() and
liveupdate_unregister_file_handler(). All of these will be used by
vfio-pci in a subsequent commit, which can be built as a module.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 kernel/liveupdate/luo_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index c39f96961a85..dd4e26ac34f0 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -909,6 +909,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 	up_write(&luo_register_rwlock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
 
 /**
  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
@@ -926,3 +927,4 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	luo_flb_unregister_all(fh);
 	list_del(&ACCESS_PRIVATE(fh, list));
 }
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
-- 
2.55.0.795.g602f6c329a-goog


