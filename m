Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F887C433FE
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 03:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hZYGTs/ErLHH2TSvqcNa7Mb/X/iqPO7yw6IRf4P0jzI=; b=BdL8xGtVoXbFpf
	fUX+qP4mI4yNx0o3313B+E9KOOOYm3kv/pZfEsVZ/yGPn3doUjqyUfPZ4xMxdA+N5Bl4TC004Fjw9
	SzPUfxQeBqFfJhaxn8IphwlKlhnDtyhz+W+gMt/qgaFZIlAxOarZbJlEbO7ZYstDYOMtjnjjwqnYO
	43XHUO+LCtuUxhECpbeSibMSVIMYXMiZWDqp3qG0UE3+HsWCtwOdLESAsG4wocN3cRrgG5385HcUI
	Pnq6BYVTuuiZ0sGvNH9oRxDjlemAGgUIORLPP1udMmAPPLsU8TWAz+rqrnsM5SwMwmVsiNUCSPI+x
	bS5qko645cyv19nMzOag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olLqG-009fDR-HP; Thu, 20 Oct 2022 03:03:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olLqC-009esb-Au; Thu, 20 Oct 2022 03:03:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qK1a5TEsG1r9JfGqBdlnMu1hdFRZw9NSadqyvunRFo4=; b=jmA5bOFEvTqe88T14nM3hqvi5V
	737xEbjbhpEdNnQkuzqVjdmN20HZ7cZJ52EqUAIzhzfhHQGM1l2pRDN+5NIc4K2oABGffBxcdKkwd
	xle8g1vhDAeeECa/2cBdBm14eORBOMG+PM9KzZqnPNwR43wVcUinBhBbjVIBfEEipvFoRGlOL/+Of
	cfwRS4cG81eqOH3IjPnGlSoTrnwM+yx7tJQjm+tDLfLTZAJIxJsQrTZDM/NcjJQ+ESfGhvYXB8dYi
	tTVZNCXboZ+w9gQMQeW2ivXmEjM41Bo6eTVLOlhcT+ax3jBu8GFcNX/8ZixFSJm4GCnebT17k6AMj
	M4HbYfJg==;
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olKhn-004usX-Sk; Thu, 20 Oct 2022 01:51:06 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VScs1Nz_1666230634;
Received: from localhost.localdomain(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VScs1Nz_1666230634)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 09:50:34 +0800
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
	lifang_xia@linux.alibaba.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [Crash-utility][PATCH V4 8/9] RISCV64: Add 'mach' command support
Date: Thu, 20 Oct 2022 09:50:13 +0800
Message-Id: <20221020015014.46085-9-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221020015014.46085-1-xianting.tian@linux.alibaba.com>
References: <20221020015014.46085-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_025044_540479_56386F22 
X-CRM114-Status: UNSURE (   8.36  )
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
index 68eff5d..c8693e8 100644
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
