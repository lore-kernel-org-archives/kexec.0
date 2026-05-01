Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C1ECD3423
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p8iyhANYh3zo/R/pXDjlB+lRBTZSZ++xkutbnUsPG3Y=; b=xyBH2TwOFfuN27putAItq2hM62
	xKPzvItgE01Rsv3IzW7kVYBDP++5ZnadSa+lNngSwfhWNtJTNVUa8Gri9k1yCga0zJhyhy/e+svT5
	aQRA79kso/JHLHPQw+6y607xI3OO4FAuP/A0oh4QoBGd5CorSbHAK8gRU5YeOQdvCEI/O2y1ZvaZL
	3NG2qVCR0d2BdLtVw7mhBidTBP/2wI1Axecs9M2+0XYzXnpE+FsARbkKMXoStBRQyjz489bBP9TlD
	vTbG8tHqIr567Aq4FZTISiMiJBDPxgDnv8yLWgTvUO8gAaTTz5e6bQ6hhwu5DXiEkCq/CzenwnKd4
	63OWrw5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIri2-00000007Vhc-38M9;
	Fri, 01 May 2026 17:31:26 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIri0-00000007VhH-0OEY
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 17:31:25 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ad9f316d68so8933375ad.2
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656683; x=1778261483; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8iyhANYh3zo/R/pXDjlB+lRBTZSZ++xkutbnUsPG3Y=;
        b=soewL+GPFQBq030VZmBhTA35GdUw8seYna6Zxv+Sp1OvqnYiqtt2btQ+DO3n8ME/ez
         223oUQDTN/QwrECKYntkRDE+nYeW848dEurD6MGCgTKIYmiPvVT3DSy3ijzdx8Wx/jC3
         HIO+43q7YOytbUczi1gNdSWoJP+VH9PJjcgH0Bj/M/dNGit5mJd/1EkmYF9zbxv+A9La
         06xHoLMXV/MyEfn3EfzIyh/cxNVObErtxWVVHWRIbo5b96z7icIL+jniXM9eOPOKc4Hs
         SrzpsWbmAUezLwXrq+isuoPLn5cLyGZ7M5X4ctOyi008KsdWueSG16XJWEHsRfYjT+nz
         xGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656683; x=1778261483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8iyhANYh3zo/R/pXDjlB+lRBTZSZ++xkutbnUsPG3Y=;
        b=f1NSkxCtr8sAy7kTa1AjmFmI4ZkLWDlAX8qcnaFNXhpexnWTx067hlcE+u67QC3box
         J1iVOdzyGvHUB7/o0pdBhujkzYGzRvRR0iSjuezfGxupSX+sxjbkammL+UZjHyQyOdE9
         U7xZ88mQMCH9HvvibIQpy+oWuBM+q9SPQ2gfdivVySlN21+VDrvCu0oPLC58sq4dlQd8
         WLWDU7nampxpG7PuCfYbEIFfF+L9TFPEcnhnL0Xk2doP53+KhnZcid+xZ2xDinClitvr
         JaHE+PnUbq4Ap43o87NGySURO32J8QjqJ7yygcBlDlLkjXRFvzDFmUJY6Oi7Y4TsPYRp
         C8Vg==
X-Forwarded-Encrypted: i=1; AFNElJ/7/wBZ589dpEa96bnQxZJloGSJc+i41Oa836Vns0jOr7rd2Lv5fiOuGaNjJn81ZPRWCX/HTQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyoEq+LT6wVD6z81Der1pNjeNvtYpijZcnaietGYss4s86frarw
	JJnGNmdkVi0PaEDpmIT8L2bOETh0cmgGEvpcsjfSBw6Rcm3xsXVuKdP2
X-Gm-Gg: AeBDiesyRhE+H2hg8/NTfrfMiuheyhek2D3kWCsdmXpf45Ntd0Ea+ttWHthH715M3ZE
	D1GUzSrq4bq2WqdhTljBDfqZNiYTm96qFJSKUfd17zwM8vn6duWEU07w7Qapp1WJeMXcjGvuLR8
	QL/4/XKKQdfDKNbZRVLmA7WfWclAu2eKk/aZGP1asg7Q0tNeC2L82GLCJOkinYmCRoKzabQtOCB
	1znvBc4T9gW2QF1Xe5Y+/3XrhDleQkJmKYBNW6RZx5vAEt4lxPqaYTW09oyh7tO98xbqe/jOguh
	91rp9dPA1OfDk3F35NKvUJdW2I2Q3GdqeezZ3194QGUjK+KKdEKqyxaZTcr5ZCU+uaEksJq3KUt
	6qcaNOq2CrO2jdR1HNFVcH13g+U6MfAPHQ8sJ05rEvVzepbM40CssTobqukxfovM7ozklyrdI2F
	5U3aIkL0PQnPg6h8Pil0mYM99I81l+3JdNrYO/ng==
X-Received: by 2002:a17:903:1815:b0:2b2:539b:d2b1 with SMTP id d9443c01a7336-2b9f257c9a4mr1034795ad.16.1777656683049;
        Fri, 01 May 2026 10:31:23 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:15cc:43cd:8af9:5a8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caad2459sm27094895ad.33.2026.05.01.10.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:31:22 -0700 (PDT)
From: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] liveupdate: validate restored LUO metadata
Date: Sat,  2 May 2026 01:30:48 +0800
Message-ID: <20260501173053.73116-1-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_103124_138109_4E449387 
X-CRM114-Status: UNSURE (   8.99  )
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

LUO restores metadata from KHO/FDT during liveupdate. The restored
metadata contains physical addresses and count fields used to access and
walk preserved session, file set, and FLB arrays.

This series adds a non-consuming KHO preserved-range check and uses it
before phys_to_virt() on restored metadata addresses. It also rejects
restored counts above LUO_SESSION_MAX, LUO_FILE_MAX, and LUO_FLB_MAX
before traversal.

As far as I can tell, this is root/admin-only; I do not have evidence
that a normal unprivileged user can trigger it directly.

Changes since v1:
- Dropped RFC marking.
- Added changelog text to each patch.
- No code changes.

Cris Jacob Maamor (5):
  kexec: handover: add helper to check preserved page ranges
  liveupdate: validate LUO FDT physical address before mapping
  liveupdate: validate restored LUO session metadata
  liveupdate: validate restored LUO file set metadata
  liveupdate: validate restored LUO FLB metadata

 include/linux/kexec_handover.h     |  6 +++++
 kernel/liveupdate/kexec_handover.c | 35 ++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_core.c       | 10 ++++++++-
 kernel/liveupdate/luo_file.c       | 14 ++++++++++--
 kernel/liveupdate/luo_flb.c        | 23 +++++++++++++++++++-
 kernel/liveupdate/luo_session.c    | 22 +++++++++++++++++--
 6 files changed, 104 insertions(+), 6 deletions(-)

-- 
2.53.0


