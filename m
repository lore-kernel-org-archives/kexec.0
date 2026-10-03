Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53230CA5FED
	for <kexec@archiver.kernel.org>; Sat,  3 Oct 2026 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kLoV5W1FHSMCnQXJR94hBtpM1Iv97CLc5Gk+9EMFE3c=; b=FEjADC9BYvvb8UO4Hyf+3hG68J
	EiVtuxKTjrhbYMtEzI+jvKirRvIeZL4doGeKWPQ+dkeiZ7gG5q6yQhHsre0a+SmAClw3BaAnxjoF5
	i4Nou1MyxO3eKz0Qa/p7WGP5eSQAWlWV+BigFNEab8C0cYcugqiUs5AM1/Xc8f9k5W5jUX6YXUUnp
	KdUj/85Ym2hQvmCrxsUFWkw73naWqnPpdPrgUsMV0TYJGhTT7TzsT3oN6W1tsi4y3o6l9AQggdCs6
	n4U8zSwjXMd9Q65KGfIRdMHXit4t6kc0/7sgft5OctjKvcwQPAabvDmX0wYraaQoOKExJ4jSM/11V
	FnVXrIhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xD38A-0000000DoqR-1P8K;
	Sat, 03 Oct 2026 17:02:38 +0000
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xD386-0000000Dopj-3kir
	for kexec@lists.infradead.org;
	Sat, 03 Oct 2026 17:02:36 +0000
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 892C93F1E4
	for <kexec@lists.infradead.org>; Sat,  3 Oct 2026 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1791046950;
	bh=kLoV5W1FHSMCnQXJR94hBtpM1Iv97CLc5Gk+9EMFE3c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
	b=oDxinKuHjSwh31QA9ULq54Z0Ka3ICwf6Mm+tdVnkM2VCtxgbrTphDAaxTtj3bHKvh
	 78EgtWchmjblnTJmdW79O/x1M9TQ3JIbaHQH0vWmn4/rs8QPf19aJqM0y9HWHeLCFG
	 FCxDNLRmZFMyy+WcJMGl5Ex528DbAArYEXbX3TTAp3GuTRH6jQq6zlPomY8wFBKo7/
	 m4YNaGXO93hcs2fw4DtuZLeuPeCbAsYYUjAc/ILCXgnb+kGlkBOluIna7w2H+I3rEp
	 QVWSEhhGFiXJlsUZtU3ot3pjM0eWFL6rsAS6/vbSbqYTbXVwUhBtpBqdh+tCO8VYTM
	 ciIqkrOECxtRbx2ylA9aQfiM24gdlrdjS9YkmVOAO7h1GwHTPEssGD1TLBCTL7OVJR
	 YO9R1Fm08M3lNhY78i/ajFG3yAv+q7OyG1222rlbJ9XBa8I7LnSgZyWsf6KlHeAZVX
	 MiL5VN7es0oakI1vvnA3RKdzjCjC/Q7VS96sAMqomj6RUzs+SCWUYT1gbmr3cQj/Rp
	 OpgmeZOeIThCglW9H9qOTtacdLCct0I1HwkSFwB3e05sJ8EG0j3pq6LpKQRMGJwC5W
	 5oRfiii9TvMy47pN5PsZqMLXpOIGnQFRJyVdMlBdVsUSKqnQ5uIL2o+kC/slooAlKF
	 Qa/d0vr/A+83MXyjwjwRYyrM=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a01ba12198so6656915e9.1
        for <kexec@lists.infradead.org>; Sat, 03 Oct 2026 10:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791046950; x=1791651750;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLoV5W1FHSMCnQXJR94hBtpM1Iv97CLc5Gk+9EMFE3c=;
        b=dCdxwIIELjG3J6Z3ZbN0deDc/wWBlEPSjb+ngIbT/Ik0lHSynfL9+aUnvoWgKBvoOn
         mGDS9COGPgPqFXMZ27Rc3muke9xoXF0iI/gcv/ZJ1ai1h3Hjnng70JC6y2WG6tdl5GmN
         J277/0YH74DcX41J1rqrBNRn6sbNlJyaewCFi3qttLpdE1kVNNkzyjjSWuS3qoXgILRo
         de6EbVVhGqzlxkj4ocgkRjviIvE+TvdVmd7VfVLTYiLpj2wTPA+nZcV/CX9eLPJkjBEF
         IWP87FxwAl+GY0o9Fc8S7gRh12XelA0i2lQ9XxAwoFw7tD4CjEMn8cOeQLdpjuj4vvzs
         7RDA==
X-Forwarded-Encrypted: i=1; AKwUvByD+KZMmmdGS2oRL6m1S0qE6JJCmHGaqMH126FoFy8dTTrYYx3xX8WMzmoASwNxrsjq7sw1Gg==@lists.infradead.org
X-Gm-Message-State: AFuF++mjWZWI37rbi87VylKEBWThZFr0bfyjvqD7wilqib4sRg221b8m
	B2WEQyTkmHoS6yV1K5MvbPrBq04z92wJDn/gBgDeOtWsLOwEZC+1ikMvtSBZ9FTHZixoi/kpcMg
	XzB6r4eQV11S2I515/Vm/XQW+mJ6D4tzCK2MBhGFmPgv/2zWXMTs0WuhO/uMy/AptNT2hXZv1c8
	UFKg==
X-Gm-Gg: AYBFou3FECmvSx99Pq3zMUCuh/Rke9RfakVvNwf75flrOsgoOHvBXB10O6xZ6stT1Ya
	D7tsDBFCfod7AE5sVTg0ZVQ5wa7Y28/Id3+B7T5maVMbmCHY7jhhtAcabtw/Mui0nneDGpm86ID
	VSoe97x6rPramfpDmVHRzWK6nyfrc4+PqDDesaVxNpBAldqPq08oXgNkiWJYVmAlgn8qTnujbuu
	l+vWXf7X5ck+jP5eCQZZaC7NSc1YfiBNvLXoMy4KMkWOvlT3zOPf1GsHpX1REXl5paSNU6YjGhi
	vV21MNK93GNIWcNbPonxTljdAjYkzdIWKKf85pBPR5rbUiq20D/1Qz7uMeYhHJNv1QaIvWjDnvN
	gQaerKG8=
X-Received: by 2002:a05:600c:3e19:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-4a027534b98mr106170535e9.3.1791046950087;
        Sat, 03 Oct 2026 10:02:30 -0700 (PDT)
X-Received: by 2002:a05:600c:3e19:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-4a027534b98mr106170055e9.3.1791046949625;
        Sat, 03 Oct 2026 10:02:29 -0700 (PDT)
Received: from px13 ([2a06:5902:822:4600:184c:5422:d333:cf3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02752aeb3sm192763715e9.0.2026.10.03.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 10:02:29 -0700 (PDT)
Date: Sat, 3 Oct 2026 18:02:27 +0100
From: Chris Bainbridge <chris.bainbridge@canonical.com>
To: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Miu <jasonmiu@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org
Subject: [BUG] KHO handover hangs when memmap reserves PMEM
Message-ID: <asE0R_f2r2TL-3Sy@px13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261003_100235_324696_E86BFF2B 
X-CRM114-Status: UNSURE (   7.65  )
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

Hello,

I am reporting a regression in KHO handover.

In the most recent Ubuntu 26.10 beta mini-ISO releases (2026-09-18 onwards),
the first kernel reserves RAM for the downloaded ISO with a memmap directive
such as memmap=<size>!4G, then kexecs a second kernel. On affected kernels, the
first kernel reaches "kexec_core: Starting new kernel", but the second kernel
produces no further output and QEMU spins at 100% CPU. On unaffected kernels,
the second kernel starts and finds /dev/pmem0 with the expected "Persistent
Memory (legacy)" range in /proc/iomem.

A source bisect identified 3f2ad90060f6 ("kho: adopt radix tree for preserved
memory tracking") as the first bad commit; reverting it at the bisected
revision restored the handover. The regression appears related to KHO metadata
being accessed after the receiving kernel's memmap directive changes how the
metadata's physical range is mapped.

#regzbot introduced: 3f2ad90060f6

I have an AI-generated candidate fix that changes 22 files. I have not attached
or published it: although the AI did extensive verification on both x64 and
arm64, I cannot review or explain the complete change, so I am not submitting
it as a fix. If one of you thinks an unreviewed candidate would be useful for
further analysis, please let me know.

