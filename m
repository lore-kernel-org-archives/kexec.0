Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85193C48291
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7dN3rOSU2C3f6Mfd3O441VI83SxDJ/h2L/TUvMdxST0=; b=NOfwypf2QIfoHe
	NQbWLsai4H5+aCtLogHNDMj+dJPIM6U+BsUBt9iIDnCiDBGEpLlZme/KS+VBKTVZwXKvNH3qjpXHc
	OgnyVcQ9xT18631y1Yd00RQvK3XjINBttsYODZmQbqPJZfeKkbfEhyDeLfMGrqq9hSwh4HM6hVwyZ
	syK+FC01FLzuUfKLCRLA1DYB3hqhdRtAvi17w1OWPGX2LkHnlPxm05xs6Fhg3p70xr1TIRxa7E41q
	cYLE9Sh8YB6sDgRi1wSytxHbTTDUQ/VYTut9KintfHEtjftAim8lyIIhmrgCkLvDDa1zm1IHQkgt3
	+drD0s/eq+3SInQUdLLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxhT-000000036OY-0FZU;
	Mon, 05 Feb 2024 12:03:47 +0000
Received: from smtp-fw-9106.amazon.com ([207.171.188.206])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxhR-000000036Nb-0wqT
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:03:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134626; x=1738670626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GuAtgRmAwOIaihgufqnss82d+hBkVwofjU/pF2m60/o=;
  b=kcEW2jEB1SevwyiGV9tiPNgSpSSB4Eb54eOLEyLccIv4DAiivPzXAGdS
   9wOFjIVdVzVLx6YG1T11NREeoN35/V7msL4/WDiRJ5SeQMU/NAEWMVTsQ
   SeU/vkmJ4JlP2YuDU6wH0Azevl/s1u72Sf980FYpMlpeIR/3y0hulM5zX
   0=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="702146151"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:03:45 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:55484]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.190:2525] with esmtp (Farcaster)
 id 54deb5d5-b17f-4ae2-b6be-2dc346f855b1; Mon, 5 Feb 2024 12:03:43 +0000 (UTC)
X-Farcaster-Flow-ID: 54deb5d5-b17f-4ae2-b6be-2dc346f855b1
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:03:40 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:03:33 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: Eric Biederman <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	<kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, Alexander Graf <graf@amazon.com>, David Woodhouse
	<dwmw@amazon.co.uk>, "Jan H . Schoenherr" <jschoenh@amazon.de>, Usama Arif
	<usama.arif@bytedance.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	<madvenka@linux.microsoft.com>, <steven.sistare@oracle.com>,
	<yuleixzhang@tencent.com>
Subject: [RFC 06/18] init: Add liveupdate cmdline param
Date: Mon, 5 Feb 2024 12:01:51 +0000
Message-ID: <20240205120203.60312-7-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040345_333323_9F7512D4 
X-CRM114-Status: GOOD (  11.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This will allow other subsystems to know when we're going a LU and hence
when they should be restoring rather than reinitialising state.
---
 include/linux/init.h |  1 +
 init/main.c          | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/init.h b/include/linux/init.h
index 266c3e1640d4..d7c68c7bfaf0 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -146,6 +146,7 @@ extern int do_one_initcall(initcall_t fn);
 extern char __initdata boot_command_line[];
 extern char *saved_command_line;
 extern unsigned int saved_command_line_len;
+extern bool liveupdate;
 extern unsigned int reset_devices;
 
 /* used by init/main.c */
diff --git a/init/main.c b/init/main.c
index e24b0780fdff..7807a56c3473 100644
--- a/init/main.c
+++ b/init/main.c
@@ -165,6 +165,16 @@ static char *ramdisk_execute_command = "/init";
 bool static_key_initialized __read_mostly;
 EXPORT_SYMBOL_GPL(static_key_initialized);
 
+bool liveupdate __read_mostly;
+EXPORT_SYMBOL(liveupdate);
+
+static int __init set_liveupdate(char *param)
+{
+	liveupdate = true;
+	return 0;
+}
+early_param("liveupdate", set_liveupdate);
+
 /*
  * If set, this is an indication to the drivers that reset the underlying
  * device before going ahead with the initialization otherwise driver might
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
