Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AD1C25B0F
	for <kexec@archiver.kernel.org>; Sat, 13 Aug 2022 03:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a/J68non0eLL9k6b/pGJC4m6TR+G2RGdX2IOuWN4MWM=; b=gdWpwIrZW4nor0
	ghuP20MwapzeEXEHU9absxY8c8e23+I6oS9/h5qNA8JZqdQHbeJbRuqqbNix5Y6kOKOm0Hz28OL6j
	5PKbohbO+PnYLU5KqiLA5LJ7OX0Wr0dj0+bwaGdMFuT9SPmH2NvEwaC39Wi3MGs4WNl2f+Bm9Tb35
	UorhDcLoCJPz5NbpKrW0O/UgD3PryPFRo4W7hsbQKjhMEZvEztUrRm0G68iqhreqUEJB5n29kdLbA
	Th6BT4KFNvB29X00U30ZIhm4UnKwbaiOh4C2z0g1nB9UdihiO1908VLHh4IkCPEbxoTiwtWZyRRJf
	1lJRIoZ1q02ZVy0SiHEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMhfK-003wOS-C1; Sat, 13 Aug 2022 03:18:22 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMhf5-003w4o-9x; Sat, 13 Aug 2022 03:18:10 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VM4rqlQ_1660360683;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VM4rqlQ_1660360683)
          by smtp.aliyun-inc.com;
          Sat, 13 Aug 2022 11:18:04 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: crash-utility@redhat.com,
	mick@ics.forth.gr,
	heinrich.schuchardt@canonical.com,
	guoren@kernel.org,
	k-hagio-ab@nec.com,
	yixun.lan@gmail.com,
	lijiang@redhat.com
Cc: linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org,
	hschauhan@nulltrace.org,
	huanyi.xj@alibaba-inc.com,
	lifang_xia@linux.alibaba.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [Crash-utility][PATCH V3 8/9] RISCV64: Add 'mach' command support
Date: Sat, 13 Aug 2022 11:17:52 +0800
Message-Id: <20220813031753.3097720-9-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220813031753.3097720-1-xianting.tian@linux.alibaba.com>
References: <20220813031753.3097720-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_201807_532623_2FB24605 
X-CRM114-Status: UNSURE (   7.85  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

With the patch we can get some basic machine state information,
crash> mach
                MACHINE TYPE: riscv64
                 MEMORY SIZE: 1 GB
                        CPUS: 1
             PROCESSOR SPEED: (unknown)
                          HZ: 250
                   PAGE SIZE: 4096
           KERNEL STACK SIZE: 16384

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 riscv64.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/riscv64.c b/riscv64.c
index 566f48f..0e5c9c6 100644
--- a/riscv64.c
+++ b/riscv64.c
@@ -116,10 +116,53 @@ static void riscv64_get_struct_page_size(struct machine_specific *ms)
 	}
 }
 
+/*
+ * "mach" command output.
+ */
+static void
+riscv64_display_machine_stats(void)
+{
+	struct new_utsname *uts;
+	char buf[BUFSIZE];
+	ulong mhz;
+
+	uts = &kt->utsname;
+
+	fprintf(fp, "		MACHINE TYPE: %s\n", uts->machine);
+	fprintf(fp, "		 MEMORY SIZE: %s\n", get_memory_size(buf));
+	fprintf(fp, "			CPUS: %d\n", get_cpus_to_display());
+	fprintf(fp, "	     PROCESSOR SPEED: ");
+	if ((mhz = machdep->processor_speed()))
+		fprintf(fp, "%ld Mhz\n", mhz);
+	else
+		fprintf(fp, "(unknown)\n");
+	fprintf(fp, "			  HZ: %d\n", machdep->hz);
+	fprintf(fp, "		   PAGE SIZE: %d\n", PAGESIZE());
+	fprintf(fp, "	   KERNEL STACK SIZE: %ld\n", STACKSIZE());
+}
+
 static void
 riscv64_cmd_mach(void)
 {
-	/* TODO: */
+	int c;
+
+	while ((c = getopt(argcnt, args, "cmo")) != EOF) {
+		switch (c) {
+		case 'c':
+		case 'm':
+		case 'o':
+			option_not_supported(c);
+			break;
+		default:
+			argerrs++;
+			break;
+		}
+	}
+
+	if (argerrs)
+		cmd_usage(pc->curcmd, SYNOPSIS);
+
+	riscv64_display_machine_stats();
 }
 
 static int
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
