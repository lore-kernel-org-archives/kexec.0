Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED06CD3425
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 09:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1tin0jspbQdn8mi23t+nODJtrr3QhSqiLRjH754JK3U=; b=G+fijXmJiL2CJ6mnttTKc/qT1s
	JDwjGm9xIH0o5Z5o9paGqVvKYy9bXAR76CZYT63M5qEEs8su/1tNsl6429ZbxW4+CKjKj+8N0+CSd
	I/pT2+Zs5DC8RWUUyI0oO/AXXuSI5R2MTCYIATb9fdwq2opPMvKy4IJ1f07xy7vBMEsP18gwsuFtW
	9nsAD6peH3eDzkmL6f8ZGggs+P7qdiVv/dMTfX444oYie8OT2WisUBDlv/Tzk+qYaeul1TvAp+UH/
	tgkFpM5dx2FheyZ3jV/lYet9csuEvdJ7tjyL3qbuxN5A1Ao6pVF2Dz0SORR6IRIoSlsf+GaYSw/y1
	KYQ/BZGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkUz-00000006YeT-0c3z;
	Fri, 01 May 2026 09:49:29 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkUx-00000006Ydi-1LFz
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 09:49:28 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so1326539b3a.3
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777628966; x=1778233766; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1tin0jspbQdn8mi23t+nODJtrr3QhSqiLRjH754JK3U=;
        b=LKM+kLUdBx4QuH6useCEHKEF9jgkDYGSW6CzN+pk/9axLpm2ItTyhlYUFMicRJwYf3
         pEiRfsD9Fiizplw1NyQAbSAUqP+4Fzqv6m5JlpQ5cUMJWGPQyl2/Zh1XsrKIKAdmxrUG
         g/JXJRiXO1cRvODsp2s7TIi4qCORw1VfuR64ltd5ckaFs4Pv9fvBAO6HndWF5sss37Fz
         +7NBGezGpnKPUpec5qprPtQjHGEQufM6EuPkoyeFLZqGsoMaqdAVUwb06qOt6h8STHC5
         ay3xxCL4WMoMf4fUX3RKxC8cD2Vxgot360tLO0d3iu4Sp6X2eGMsn6Zrf5Dq7QdvMQNE
         2JkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777628966; x=1778233766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tin0jspbQdn8mi23t+nODJtrr3QhSqiLRjH754JK3U=;
        b=RnGq+btuWvPzKC5Pxmr1hLqJWt7kNMb9m6sFGL1Z0kQFpawaJYtYZxpHWVOAi0cgS5
         GFwQuQmtt0c+TcTDOgBw1fr7JhmcvK0T1a5huGdHeEIeRUNt4eq6RNvN+ryY34EjKaPV
         53c1UNdtha7Wq+2b88SXxoLqrIrXtZqc34wit3ta2RsnJQSUQrXQKslWSLvHdVMh5U/1
         hGyLECBdVNeKwSm6UXWo7F2aRTKQKoYXF5TxPmxS7vU16NaSEsBqKiS8MIJvMTsHiBjZ
         MOU2d8nmGJPcK83ec1/Xa19kyw+abNwy9cEdJLNzRyyVAy42d9FoBMZni2344G5a0WSC
         gfmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+f0RIlOo91vn1n6743/7JIKHAVOECR4vhUyb03BwdWTJV4i5+1G5TcnBn8W2Y1ByQomUI8qw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzcQ/OItEMJmjcc9P3fHtH19wWX/DNhKMtZHpR/zwO4upN+HoTy
	UwTfEFYhKMUo03/lqkGCpjNEHtbIJfFuT+rmr1DeY8DhCzaygctnNirI
X-Gm-Gg: AeBDievc03drCDK64iJOPUgtakrE/TksEA4ole3NUmnZKyfGNh742SSOMIg1O8uAVBk
	pOVvxZ7HYtioNAtb76cNXtywmWRxYu+E5BciKl7y/sN2BXWI2uqqHQkzifkwwHHrWk+F09ASWM+
	yYNekEubfH/uu5Wxaaz1SU/BQTQDOrLLnhh3+AjcLuDPL0SbZvQqvKSUyZzUy8nIHxtU/akS7aZ
	jr2CQV4aIFCWTpnN61ri1HFd6rSrW77HDHuF4PgPOGlT9w10/8O9pqwchx4NOBTevAtNCbqs2sS
	knQPePpnmVwRwa20LcTIG3L6OqUHhGgZr3wH6P+X4La54h9NKDNRaWYv0kk4KiJ0b+8a8sSlT/T
	ntyJtjw0EK3XhpNKWUbGMWu+IlIc+q341+M2vyzw0C5TyNPYbjFPp6u05WI2q86EzG4aoETzurv
	lHefF2mPPjCiwOMAIGrDKNcIPiHB9fISQO17oKfw==
X-Received: by 2002:a05:6a00:8e01:b0:82f:9e98:1356 with SMTP id d2e1a72fcca58-8351a31126emr2478609b3a.20.1777628965625;
        Fri, 01 May 2026 02:49:25 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:eebe:247e:613c:24d7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351582dd55sm2042729b3a.1.2026.05.01.02.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:49:25 -0700 (PDT)
From: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/5] liveupdate: validate restored LUO metadata
Date: Fri,  1 May 2026 17:46:32 +0800
Message-ID: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_024927_361110_F554D0C1 
X-CRM114-Status: UNSURE (   9.53  )
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
walk preserved session, file-set, and FLB arrays.

This series adds a non-consuming KHO preserved-range check and uses it
before phys_to_virt() on restored metadata addresses. It also rejects
restored counts above LUO_SESSION_MAX, LUO_FILE_MAX, and LUO_FLB_MAX
before traversal.

As far as I can tell, this is root/admin-only; I do not have evidence
that a normal unprivileged user can trigger it directly.

I have not reproduced this in a VM yet, so I may be missing a KHO
invariant or a preferred restore helper pattern. Feedback on the helper
semantics is welcome.

Cris Jacob Maamor (5):
  kexec: handover: add helper to check preserved page ranges
  liveupdate: validate restored LUO FDT before use
  liveupdate: validate restored LUO session metadata
  liveupdate: validate restored LUO file-set metadata
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


