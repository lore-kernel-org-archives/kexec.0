Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90788C43334
	for <kexec@archiver.kernel.org>; Thu, 30 Jun 2022 22:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=W64JsYsDdXuP9YfpYXNAAOiHWdGkDC064cUFu5cUUpw=; b=1sADMyG4jTUes4
	RViHUwF94y8iYCP6tkzKRoKyjeoAzP5A0PgrMUC108pv+jzLNtBMV2A4VRDueUgf7Rp8v0Ejd3pyb
	kNlxsB20AQbTrvBjxFJDNfQWfC96aLJJltXWtq+Efeju3eUQ1l/ZRCDvQsYmY4HDg74SA8RhXD7Rc
	ioZfSoK/DKruW6PWUThLISX9cq+bQoVi047lQbE1PaZI4is8oMCz9KTSjthC6Byu7n1mkbjOQqowS
	dSLmqkxVK4yzp0v7JYENtbAFL3C5+6bkRCBWx6ZMU1PhLlbaY08JzTjGiF6reB24g7AKYUPeqWGs9
	8fvZPBrXlCk7lMi0+0Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o72jF-001rNR-Q8; Thu, 30 Jun 2022 22:33:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o72io-001rBG-LW
	for kexec@lists.infradead.org; Thu, 30 Jun 2022 22:33:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656628390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XHy4PvEmAkmPOfd1mGpcH63ILnu1M8TgxJfIKYx6Bpo=;
	b=erEnLdW1GcEscmsx6AWdi3H2F+RmVmGCLoIVixNwbnsX/gOXzwgUzGiz+0Yvfj6MTcGn0p
	L8R8yeLMMDZPtSK8DY7vl41faniWHwALA58Y1zpWyjby9Wi4NP1CpPXekV3ceTgEMwFvbX
	VYP+kKz4ozSY1m3+cTJ/497Rh3KJsyo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-x8zHfrVqNP2N2YJm91gLMg-1; Thu, 30 Jun 2022 18:33:09 -0400
X-MC-Unique: x8zHfrVqNP2N2YJm91gLMg-1
Received: by mail-wr1-f71.google.com with SMTP id s1-20020a5d69c1000000b0021b9f3abfebso55095wrw.2
        for <kexec@lists.infradead.org>; Thu, 30 Jun 2022 15:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHy4PvEmAkmPOfd1mGpcH63ILnu1M8TgxJfIKYx6Bpo=;
        b=5fikCPk41RtM9ntiXLPdDuOQ1KSPu6PoZlacnHadLseNbtLdqcJr+7lkvjIyhpsS+U
         dcVmhQKJsNi7TZw3OpRPVt3QLfO5u7rwNLB45a2BxUZ/4hJBPG1soWGZpKraCmxgVU1v
         F0KVHK8KG+uwuvw/H+731vY7/Exk6pjJQ+Jf+kc3A/OvAG78f4cg9W3ywOiNKyi4xvxz
         Dc+F5WjS4RX20XF26NCkJia/l/OPMc8nBWWmV+wShZaTtY5TSTBBJvqOx/TrTlBG4uXe
         zM4kuZiwr+f87GNaK6GKgjzW564KQdfp2/ObYarTMl4dEnglHN1u7VSXmxBFa0UndUkC
         UILw==
X-Gm-Message-State: AJIora8k6tCUF3CxjEpAQ2ccFR5UB74wKK/gwdR13dOiLUDubjBryh+B
	STDeGhwe+MXU2YkFqWTgTwDe39Z4DhR0r68jx/SkYHQO+ma8PzgFMvv2+sMMAgDtTidXE/Q8ijV
	YobKe1eC3dB//z3miAj3EGrPwD7zXwd2VzDeeMraaIya5Ij4eQT++nuZ/aXdeIB0bVku97crk
X-Received: by 2002:a05:6000:1acf:b0:21d:1067:a1df with SMTP id i15-20020a0560001acf00b0021d1067a1dfmr10899670wry.198.1656628388184;
        Thu, 30 Jun 2022 15:33:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u3PqN+NRcFXDnGhZ2NA2TII+IW79iuDR0NwK+AO+7xudHAIrGuC9tQuCcswJWzhtr32IlB/A==
X-Received: by 2002:a05:6000:1acf:b0:21d:1067:a1df with SMTP id i15-20020a0560001acf00b0021d1067a1dfmr10899650wry.198.1656628387992;
        Thu, 30 Jun 2022 15:33:07 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b0020c5253d907sm4308387wrz.83.2022.06.30.15.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:33:07 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: kexec@lists.infradead.org,
	linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Petr Mladek <pmladek@suse.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
Date: Thu, 30 Jun 2022 23:32:56 +0100
Message-Id: <20220630223258.4144112-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_153314_865225_A474FB0F 
X-CRM114-Status: UNSURE (   9.33  )
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

Hi folks,

Here's ~v3~ v4 where we now completely get rid of kexec_mutex.

o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
  having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
  here. If that can't be done then I think we're better off with the combined
  mutex+atomic var approach.
o Patch 2 does the mutex -> atomic var switch.

Revisions
=========

v3 -> v4
++++++++

o Someone forgot to Cc LKML on v3...

v2 -> v3
++++++++

o Dropped kexec_mutex entirely and made the atomic variable the one true lock
  for kexec (Eric)

v1 -> v2
++++++++

o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
  (Petr)
o Slightly reworded changelog
o Added Fixes: tag. Technically should be up to since kexec can happen
  in an NMI, but that isn't such a clear target

Cheers,
Valentin

Valentin Schneider (2):
  kexec: Turn all kexec_mutex acquisitions into trylocks
  panic, kexec: Make __crash_kexec() NMI safe

 include/linux/kexec.h   |  2 +-
 kernel/kexec.c          | 11 ++++-------
 kernel/kexec_core.c     | 28 ++++++++++++++++------------
 kernel/kexec_file.c     |  4 ++--
 kernel/kexec_internal.h | 15 ++++++++++++++-
 kernel/ksysfs.c         |  7 ++++++-
 6 files changed, 43 insertions(+), 24 deletions(-)

--
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
