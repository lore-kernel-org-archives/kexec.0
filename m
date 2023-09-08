Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11ECEEB566
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 20:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5rYb1JtYVBsTmtyA92MNKC8F2bkSDZId4HLuAJS7meo=; b=Kb+dQCaLn36ebY
	uj8D7v8tV5oUNp5mc1yuJur3I45GnxMKi3+3cfbzq9wU2Wlm1pdQkDqFAXIA2Rc1k1uQvov3bU3Sd
	nQzo16vCzIES5A7YWTQMSlOmyjH1lDAPTNYTU1/sJMO+BNHRwIZa5NyiTaRkvEWij8PCx6kPgpv2t
	ni91SHizkg0+oVahrd02q4fJH2EVckk5xCfnx11JkY2hSwKldn3J3gZFtt/0EcvcAoQFAu1TK/aL1
	RUUlRJ8qCerfWHgZmOH4PrV/hjJKlL4qC6nWpteIQTfJg226maA2q4hiBVSdl2SdRwgr16uHwe0aI
	053SnffY7Bdl7gsyW51Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qehgs-00EQP6-07;
	Fri, 08 Sep 2023 20:02:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qehgp-00EQNI-1W
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 20:02:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694203366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CVUWiNi0XyDqlB1JxyjZ0R/Ir5gIUCrvEGnFOU6/cQM=;
	b=i3XSc3IbHxg4+9Y4Xt7yiR9jYIWtiHtn5K5lokvFfE0pPMuAwIsdbFomCnx2WuXphQzZm/
	O4hCWC4JByje5ob91Se3AAukS/Btccfx4SSK4UAy33/ox97iQLoJ4CIN/Kq/ygq1ravGcJ
	i5f/lARzV5s4WHVjccg1QMz3rwesbXs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-OXClKBNvN7iFQFNcfa-c1g-1; Fri, 08 Sep 2023 16:02:45 -0400
X-MC-Unique: OXClKBNvN7iFQFNcfa-c1g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4122119722eso4980381cf.0
        for <kexec@lists.infradead.org>; Fri, 08 Sep 2023 13:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203364; x=1694808164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVUWiNi0XyDqlB1JxyjZ0R/Ir5gIUCrvEGnFOU6/cQM=;
        b=ss8bvzKzK6IFc2rxU8LAjpijVyZUY8NrSXSCAbhO/wlVulhSZT8ycg420jAVnOBbub
         IqA2QmCBQTX1iWkj/5o8clpuaCVxf8Fx+q8+t/fCbXbQ89ZLN1kqm3xmOCd6xXQKrezi
         +Dv0EaYu3D+Z1kjvIepeM4duLXFaR5t/J3mBdAExfFm6YToQmVBElgMvgGdRbCXMbGUe
         A0FhmUPLL97eipshBL7AMDB/bBN1CfpO4SGdKLdHRrW1nLeUtSs9OBHmcxhETI5PBWNP
         PZnEyMDFkvItoHWRu2ISdz5QDcsUrOcbCE6CIiYaRcMrOZBEHe73c3sIlB840ZI7QkWM
         ryug==
X-Gm-Message-State: AOJu0YyDgq8LKpfhSaYHg7QcvPmqojJiv/vvPwlatYpoKTI4IbjDzkH6
	jew/iNP3OG3wfUd9jYNr8XWrUdycNwa9x3r4GMd9dqienei3pcbQ46qg7oIdmLoFNqkbDff9H91
	wHUkEc+Oy3p1/lsF803jv
X-Received: by 2002:a05:622a:1915:b0:412:1c5f:4781 with SMTP id w21-20020a05622a191500b004121c5f4781mr4701336qtc.4.1694203364612;
        Fri, 08 Sep 2023 13:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuiGnmMFWAKLSh30zPQGkgvOkX4VTvQk/17jsSVc5WjoNTNjt80rBc5lL7G+qjPScKuI3czQ==
X-Received: by 2002:a05:622a:1915:b0:412:1c5f:4781 with SMTP id w21-20020a05622a191500b004121c5f4781mr4701161qtc.4.1694203362351;
        Fri, 08 Sep 2023 13:02:42 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id jm8-20020a05622a750800b003f9c6a311e1sm840078qtb.47.2023.09.08.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:02:42 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Siddh Raman Pant <code@siddh.me>,
	Nick Alcock <nick.alcock@oracle.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Zack Rusin <zackr@vmware.com>
Cc: VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2 0/5] Introduce new wrappers to copy user-arrays
Date: Fri,  8 Sep 2023 21:59:39 +0200
Message-ID: <cover.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_130251_597031_0604F902 
X-CRM114-Status: GOOD (  13.34  )
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

Hi!

David Airlie suggested that we could implement new wrappers around
(v)memdup_user() for duplicating user arrays.

This small patch series first implements the two new wrapper functions
memdup_array_user() and vmemdup_array_user(). They calculate the
array-sizes safely, i.e., they return an error in case of an overflow.

It then implements the new wrappers in two components in kernel/ and two
in the drm-subsystem.

In total, there are 18 files in the kernel that use (v)memdup_user() to
duplicate arrays. My plan is to provide patches for the other 14
successively once this series has been merged.


Changes since v1:
- Insert new headers alphabetically ordered
- Remove empty lines in functions' docstrings
- Return -EOVERFLOW instead of -EINVAL from wrapper functions


@Andy:
I test-build it for UM on my x86_64. Builds successfully.
A kernel build (localmodconfig) for my Fedora38 @ x86_64 does also boot
fine.

If there is more I can do to verify the early boot stages are fine,
please let me know!

P.

Philipp Stanner (5):
  string.h: add array-wrappers for (v)memdup_user()
  kernel: kexec: copy user-array safely
  kernel: watch_queue: copy user-array safely
  drm_lease.c: copy user-array safely
  drm: vmgfx_surface.c: copy user-array safely

 drivers/gpu/drm/drm_lease.c             |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
 include/linux/string.h                  | 40 +++++++++++++++++++++++++
 kernel/kexec.c                          |  2 +-
 kernel/watch_queue.c                    |  2 +-
 5 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
