Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C64DC2BD09
	for <kexec@archiver.kernel.org>; Tue, 25 Jun 2024 01:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qIViBJku0YuenW6Necy1B724TZDhKYRzxWLPN2UtB4M=; b=twvaLiC+J2fTZr
	NMhv643MVYXMEn2K0Upk1koThH3eobjr851MM+AgEwA9FelcRJSLazcbBI3wI3z0I7ypsWnW4aUAC
	pVvx1SGVm3MJjLy6DW+SANKKY6/7Qufv+/DAUBdB5mPdjtmNF/Smn0fkB9IFbcwZcR3Te3HXFsH2h
	hJ8+MSlQu6iy87tjPiGU6iYLxBsNlq4SaUW98XYqscIOy/HYY7MbYbYWdRBXHo4opUEw/HM7UNKci
	852zkThB6TOQX/9aOCpoPupuDlpNjH+vv8FSAWKkOjvDrYNOQlfSMjcgv+MzOnJS0SEndGHW7VKBe
	p1MxHhpBbJQgFum7nC4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLvSe-00000001HJL-0dv8;
	Tue, 25 Jun 2024 01:59:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLvSZ-00000001HIc-0nHi
	for kexec@lists.infradead.org;
	Tue, 25 Jun 2024 01:59:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719280741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YaXL3zaTu/zp3CvezDqYvpaRg+TsX7TWIM8BZdgaTbA=;
	b=UxeuJe1BRwnzGFPGpyw59csKZJi6wZU0O6K0MoLuSZwe+pZ4e4jtMZs1KyRDKdSuneoOg+
	8W/BPGTU0MkY2soDztHfRNpePjdoPAAkcjE2+gCKNOk9IWgoL7bEvoZFzqsQdxxO5wS54Y
	DIFukOSWhUjCikxb3h2dpiMJzYpZ5p4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-U7oOmQYIPPSlyTv0bJmTRw-1; Mon, 24 Jun 2024 21:57:30 -0400
X-MC-Unique: U7oOmQYIPPSlyTv0bJmTRw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5baec6d1ce4so6555040eaf.0
        for <kexec@lists.infradead.org>; Mon, 24 Jun 2024 18:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719280649; x=1719885449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaXL3zaTu/zp3CvezDqYvpaRg+TsX7TWIM8BZdgaTbA=;
        b=jiWkkpUiIvSo3gofyYC4TWfU0scwd4LeXd/tYlyfaCYSXfG1Szvve8OB+thVU2iNwK
         lmAEe6a9ftDlrid2avvgXESWpSBL3fX1ygpFwsqKcrHyd84lEj/UPzKqQJUjXHQfQudQ
         ke0kGi7KRAJ3MjxTWhbWxKlSls7oa4uZHaBW/v+cbcp+lsMxTCQGrimblV4RsZE1tUyI
         kmBcZ1RzGSLV77DdD2mXXpREBsM63+DZUDHMgP9FJ+1OTsfFv2vim3YWxzpgcEObsJc2
         DqYZDcJaSE5DpTLKFLyYthosFJg2r4Nv/rAuKDCMMQIJdIptSHl+BveD9KJv+mk/LK01
         WERQ==
X-Gm-Message-State: AOJu0Yy4HDb5htyKB6xp/MqMsx+KQCsauC5I3Ay3oJNrc4SHKADNRa7A
	kgS8kEWeYQqIZ/mutkpa87271G1/6HhFlujfHVa8GPM/OFOmHdY1+JYsc36AJMO5OjqNewIYcum
	KhZvVydvYCU1b4piChlA4i54YbFF6TDdJE7R38sgxjtDn185HxpToYWFEAHoCHQj9GRo/6kd7qS
	+GjBG3ItJxf8Hjt962TMOLVRYN8RrvsakvYHSs5G1U
X-Received: by 2002:a05:6871:58c:b0:254:b192:9c29 with SMTP id 586e51a60fabf-25d017b0394mr7698986fac.38.1719280648777;
        Mon, 24 Jun 2024 18:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZvjDscvxTm7T3M6qyGXItjR/MoLHPwMfdFuPq2/G9JT1nREg6QP34dpzK1UiHn+JiDMa6BQ==
X-Received: by 2002:a05:6871:58c:b0:254:b192:9c29 with SMTP id 586e51a60fabf-25d017b0394mr7698973fac.38.1719280648432;
        Mon, 24 Jun 2024 18:57:28 -0700 (PDT)
Received: from f37.llcblog.cn.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706984a721csm255345b3a.37.2024.06.24.18.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 18:57:28 -0700 (PDT)
From: Lichen Liu <lichliu@redhat.com>
To: kexec@lists.infradead.org,
	k-hagio-ab@nec.com
Cc: Lichen Liu <lichliu@redhat.com>
Subject: [PATCH] makedumpfile: call initial before use cache
Date: Tue, 25 Jun 2024 09:57:12 +0800
Message-ID: <20240625015712.3266086-1-lichliu@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_185903_320126_46849784 
X-CRM114-Status: UNSURE (   9.01  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Run 'makedumpfile --mem-usage /proc/kcore' will coredump on ppc64, it is
because show_mem_usage()->get_page_offset()->get_versiondep_info_ppc64()
->readmem() use cache before it is inited by initial().

Currently only ppc64 has this issue because only
get_versiondep_info_ppc64() call readmem().

Signed-off-by: Lichen Liu <lichliu@redhat.com>
---
 makedumpfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 5b34712..6a42264 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -12019,6 +12019,9 @@ int show_mem_usage(void)
 		DEBUG_MSG("Read vmcoreinfo from NOTE segment: %d\n", vmcoreinfo);
 	}
 
+	if (!initial())
+		return FALSE;
+
 	if (!get_page_offset())
 		return FALSE;
 
@@ -12034,9 +12037,6 @@ int show_mem_usage(void)
 			return FALSE;
 	}
 
-	if (!initial())
-		return FALSE;
-
 	if (!open_dump_bitmap())
 		return FALSE;
 
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
