Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01005C369AB
	for <kexec@archiver.kernel.org>; Fri, 18 Apr 2025 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hzDXI54x1X0eS48ybGkFqIAbabffOZuzEsqDECgMj8s=; b=RDNjFXqv2JHHLvhXzarUd+OBeq
	0uTT0b8nELBJfdPrlSYlisR7BpSRhn9KDsDk3L5zD8ixvRjIFqBwCGA9BunIR6Pj3U73aUa7kWr/C
	04OKPDLGzJvAxmbdz4wDos74NrmM4KK0W+Iwgnh1N+5JJdOfX6PBNiYm5fsJ7E01bib0OiMLold+v
	bFqnPumretR4xsHMIhlk1mw9LizxerESv1XjmXE6DSnrmWVjHAEI1yAo/HYJaRhhw5FtAJzXNxGSq
	LvgR+1+wMTZxKq04OV+hKqTmg43HMnTtSC2AhtLvRer8eoIueq/Pi2w4P4RuLQNf4Vano3/93r1rW
	HXPc53yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5kRt-0000000G1px-3A8r;
	Fri, 18 Apr 2025 12:04:01 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5kRX-0000000G1lF-2zD0
	for kexec@lists.infradead.org;
	Fri, 18 Apr 2025 12:03:40 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso8350995e9.0
        for <kexec@lists.infradead.org>; Fri, 18 Apr 2025 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744977817; x=1745582617; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzDXI54x1X0eS48ybGkFqIAbabffOZuzEsqDECgMj8s=;
        b=a0FP1JKPh0f+skPhQVMItvEPAOoEI+ibVR0Icd9MAiw2cCORapvPjDNUTVOG28lsYH
         XDpnbIsdV23kIzjd5asDWVg0tQUNlTuWsTrUgJkYvBl1xA7tsr+0xofGdnKVkbRDe1GZ
         VGouy1fdL0M4arBwrcVrYcBwFwEj4t9ftbHIRx/mLcySFg3+NvB/GVq0iiPzntTE4dms
         M+Qs9Grlfx6lmiK2oZNpquU7QFN/+yYMs81xxXqCGxnshIxJE99iBTXNmRTzTFdsP8vO
         9ZBW8c6GiUL3IXasUzAFYX1umudbnJE4gownMxNyKQOycKonQENDPoXlgNZ31l4NCI64
         XjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744977817; x=1745582617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzDXI54x1X0eS48ybGkFqIAbabffOZuzEsqDECgMj8s=;
        b=YVJEk2wiu0va0YULl87AU5EHTN18iGw47RVDPt2XgyqcR/kdgi+sWoOcup51WvrRCS
         VX9WC+5ySessA5F5X4woCu98tgtaWdpP52fktA3borwzWaHdS51j+l1P6/nuZNP2ABt9
         9fgL6cAwUcVuQsWx12t7QGuCUxnniIOG9MbSZhFzs2H1l1jT0yPvfi0XQSkU0SMVsJTf
         Rq8o+IIz3Zf+vaAllaWlIMHc2+8dyHVtdU3XIo/xL/4Lg+4h6o1ugGTUwGUfsyxF2cV4
         dpdmStcjYW2cd8gD13h7jix9ugLoupwQZr4jFRyRUNxQT13/R9V8Y6tAKa5KT2LD9nCe
         J5Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXk/y/EoZnMuhONSBVxbea12UIVYiw6tyrv+9DL60jGWCwykcQO0tsIkJwSZOVYhuPnZjSQcw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzacH/pHoSpkrTzrs81CYbG/N3oVY0IZPz4smJVUN/risR53iOj
	ZwiWtC0FZnHvWStCMA2OgNQjh9JmNO/cTXKl/3pCJ0A44rfz8Pms
X-Gm-Gg: ASbGnctwNAA63vykRcVWgVKpiz/gGU2r/ya7dZB4pTReNaYIeRA9IMd/Zpc+Rj0ZgMm
	ufqAk/emKaAJ+qDOhLYzo5lXcYN9xNjJGkvmPd1fXu/yg1DN3fuvPe3VNhnAq/n0lRMCDhNgc7z
	K8zpoTcR5cWtDCfahKpy3EBJwlLQcEFxcLtBowCBmgRRIC/OLdD4/ITX2/y1tVQrScMSldY8QnU
	Wt7fJC85UCXWlKYFgGcnHYKpsvbxAYguvjlHiuq2e7Dg2t8shqlfLHO9+HyzgJvvBUrLB6WJBXN
	leIKP1arXbGr+vLo+mhAaY+rX0tjMmalEc3y3fxayA==
X-Google-Smtp-Source: AGHT+IEUD6k4QSc4ti7eTCFJXkgL+r1yKTaYIn7Oc+8OU8G5Fg7lgwr9Er+zG0ZcUkbsPplX9I1p4g==
X-Received: by 2002:a05:6000:400d:b0:39c:cc7:3c5f with SMTP id ffacd0b85a97d-39efbae03a2mr1985961f8f.45.1744977817031;
        Fri, 18 Apr 2025 05:03:37 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa4931e7sm2586839f8f.67.2025.04.18.05.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 05:03:36 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crash: Fix spelling mistake "crahskernel" -> "crashkernel"
Date: Fri, 18 Apr 2025 13:03:31 +0100
Message-ID: <20250418120331.535086-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_050339_749687_D9D9DA84 
X-CRM114-Status: GOOD (  11.00  )
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

There is a spelling mistake in a pr_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/crash_reserve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index aff7c0fdbefa..acb6bf42e30d 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -131,7 +131,7 @@ static int __init parse_crashkernel_mem(char *cmdline,
 			cur++;
 			*crash_base = memparse(cur, &tmp);
 			if (cur == tmp) {
-				pr_warn("crahskernel: Memory value expected after '@'\n");
+				pr_warn("crashkernel: Memory value expected after '@'\n");
 				return -EINVAL;
 			}
 		}
-- 
2.49.0


