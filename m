Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A7CC4332F
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 08:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s4Z1v1wFnqUfJhgkF/6ps240AqnCuJFE/5qPNp/i+vA=; b=Z+YXnyu+fU69E7
	Q1Bbh5Yv2y8YO75ZQy+1bvf1ZBulLY1dcn3bGzU6j8qDNiW+ozGeiNpIGBwh1YIP1dyxJm0OSD8Tr
	sQOCNBeVjfHl6Ln679oHVb/QLPNt9v9qfpQtXYsTsiVBY+Mf6UtPsV5/NMWGSSwrwpqI+Md/83Cxa
	NdfvGwkI7p2W2HbMgwoJertbT+IhmC90/e6GlrB+ac4jy/D+CaIZj1QoxLULDMQ/tZATxXxnrHCSZ
	EJCLqRarmw6gyXTCmSovOeS4sULNPDEYmRKucYwrJjJUvsKQPNoldZ2SpXG1xy1fpEAa+LXUjNXMz
	JVSA16xqqvvyCK4JEbTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3Gw-002PwJ-31;
	Fri, 15 Dec 2023 08:10:14 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3Gt-002Pql-2I
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 08:10:12 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ce7632b032so155640b3a.1
        for <kexec@lists.infradead.org>; Fri, 15 Dec 2023 00:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702627803; x=1703232603; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sICzlYhaSfeV+0O8ybAajGk8fmRoPkGoJtHOPJtKgUM=;
        b=dYURLaGQyk9GmeXPrhFAvb7Bf3OAfheLCOSOuho692OFQyVM0qR6RU+GF2FhWnnP55
         seuw/OaVCfSh/w596dnJkgPbyk0sK/sLTGLZBKW96TulA2oZkLRJk0uegdkY+4HPf4yR
         TlQcjCV8Wy7Y5p/q6IDbTRDApvbQRx6u5HkDTC9imHCBFjSjbU9KAOdLd99EsgL/lv0U
         bZ03Vz8Dvr+pONm45Klt0pSK8tVmINHh9j4I7xc9PCI0UvmDBFTSXumG1wTkAR9OvIQl
         ScZJ4Jg/WMIWdnBMnLIXwWmZ4/b/DnMAK22r+WUT4HN+TUsPgU5pC4uedHXNJ0s+RX60
         tdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702627803; x=1703232603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sICzlYhaSfeV+0O8ybAajGk8fmRoPkGoJtHOPJtKgUM=;
        b=J0cCvFrBEZU2hEwiT6VuXzru35nJqdzwfCphE3AfsbWR+kyyn5odJGrOSwPf3AUkVL
         moAJgOP0nrmZYIqhlO06ogHwGN1Ln7REY9+hPL1tAqPuclRwKA0lLi3PAFh2AswgJ93e
         vIlZS6erzv7yPTH2RAYLCHXsYWs5AE6nMHsyf64zOXbZeKZawa6vwrsFaUH5QUU5EC7o
         QIy5eEuVLe7syG1HZTN9if6vXRtUtQx3epdIFbcM83sXqlc6x/CZ2FDOW2tjNauo4/8R
         YgCo0u+/oU8W2wNR0J1NN8q4oCiqHW4xC6bhpAVH1i3DwZECIA4dQGeKY21Z6rgmJOOd
         fTjQ==
X-Gm-Message-State: AOJu0YwIMHctxOmEc6341EW59cWwEEmxWNnOEqCEJ/XI+synj758IpJV
	M315tP7Wwvqo3qIPP9vc5/uAZ3Zupfk=
X-Google-Smtp-Source: AGHT+IHxPXj3XYid69vOvuBnwTPo836bhjrwQT+9xxJqSFiSTCYQpfkUC3ihozMaJJmBd/eshU7Vng==
X-Received: by 2002:a05:6a00:d76:b0:6ce:f665:ab1 with SMTP id n54-20020a056a000d7600b006cef6650ab1mr3875430pfv.11.1702627802891;
        Fri, 15 Dec 2023 00:10:02 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b006cee656cb35sm11783792pfl.156.2023.12.15.00.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:10:02 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 2/3] kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
Date: Fri, 15 Dec 2023 16:09:09 +0800
Message-ID: <20231215080910.173338-3-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215080910.173338-1-ytcoode@gmail.com>
References: <20231215080910.173338-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_001011_752791_D3CBDCC1 
X-CRM114-Status: GOOD (  14.82  )
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

temp_end represents the address of the last available byte. Therefore, the
starting address of the memory segment with temp_end as its last available
byte and a size of `kbuf->memsz`, that is, the value of temp_start, should
be `temp_end - kbuf->memsz + 1` instead of `temp_end - kbuf->memsz`.

Additionally, use the ALIGN_DOWN macro instead of open-coding it directly
in locate_mem_hole_top_down() to improve code readability.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/kexec_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 26be070d3bdd..c3bf52a9a8ad 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -426,11 +426,11 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_end = min(end, kbuf->buf_max);
-	temp_start = temp_end - kbuf->memsz;
+	temp_start = temp_end - kbuf->memsz + 1;
 
 	do {
 		/* align down start */
-		temp_start = temp_start & (~(kbuf->buf_align - 1));
+		temp_start = ALIGN_DOWN(temp_start, kbuf->buf_align);
 
 		if (temp_start < start || temp_start < kbuf->buf_min)
 			return 0;
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
