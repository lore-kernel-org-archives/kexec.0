Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF360A260C
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gGx9itIF;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=QaKBUt81
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=59sgXJgrAjzlF6lUUIt9hHd7ZlSVCeSH79v3f3zBjaU=; b=gGx9itIFlHdj9EO6XUEyd7wmNl
	q0nRjyr25lhccAkcgJ/mQ5BGlp/LmG2yKuOLcMIv4pd7RIwFZBxx1tPtZOYid9MacZt25/css1PJS
	ElWgck6gIkkJVUc1MSujskAdNaWwsCp0k/85nne3NGJh5EnWlFNEZ4tu3cmulr14DJUaw4wKCguaa
	qY0+4RPC+xbQvv4ECMOLEhDdrtQKx4G/huplGcXgmGXpWNN13LqviMHMhWDgGn56gc6sqENsdYEYn
	2uhAU9AP8OfMkiYwmNqcHm0h7Cz8vh19nmGkslShZs09sYxMnaeOZ0iySR7KUIHQMbCER4IY+KIjL
	WYVmVasA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR38X-00000005xfh-0zWN;
	Wed, 11 Nov 2026 07:52:53 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR38V-00000005xex-1rd3
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 07:52:52 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2eb0f1b592bso11220925ad.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 23:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794383571; x=1794988371; darn=lists.infradead.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59sgXJgrAjzlF6lUUIt9hHd7ZlSVCeSH79v3f3zBjaU=;
        b=QaKBUt81qoMV0NW+eI3feJrJP1EjVXjZbISAa8OtOPqzM3rz4onxw4zOJTbiVVOfVw
         8BHhEL6U/D94BkkPJ9uIsBmUdlCxC+tPMYJnuKrSvG64jppICUIUUnVuMs+RTvakLBNd
         nxYZoMzGmnXEbXqSVOst0Db4oAZkEZNbIYkOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383571; x=1794988371;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=59sgXJgrAjzlF6lUUIt9hHd7ZlSVCeSH79v3f3zBjaU=;
        b=EBortZ+7p7GEA7ymygXME0qGTgYDS/Aia4S3jSCqYNh/hKKSZE/hJlkI+0+f5GVqI3
         zSdGN6vqsET3vgu+CTU/ROAzllk+YQ6PApKemguY+BwL5o6ThphW16XnhnY5LAQWqiZa
         qYjBVsekqSO2BUuemBpw6Ay3Dr/aMqOsOe+tdnr85YeSqy9xPk4trKHlYCR/fIbJv9UV
         5VPSBiucBZp4NHMn33TLlCXL9pnC/ItV2fngKGA6jAU+uDecU7ATG1U/b4ZZOQmyUEX2
         RDqIlobWLfqokQtk9CQ0Bkl8S23Y4DCrSma6Qa3QVrQxUfqypuJFLR1aNBqH3fKIIqpK
         E0HQ==
X-Forwarded-Encrypted: i=1; AL+hErEvNIQo19NzY14DbywqnTbTZ/LITm6yl3QkP3dAavB/YDoAR+x7sz5PDSVADlAJqqsQm3l3ew==@lists.infradead.org
X-Gm-Message-State: APuU4Z9tdWVHPfR77nzNYbewnoVioYUK7F2AslMmopadhuy2dfmcl0Ln
	Z+sYKYAvBGFTSkwFxYcesbpd9e+UZQJNyg9te7CM0iwhZnnKqD9z/eIa1L1nY0fxQaw=
X-Gm-Gg: AYBFou3FWvEV6LR55T7ZhJemPz7cad9xpzsQ3YM1uFBbCYHCVr1Ajtgtq+7hrc6lBKb
	yj+yHXfu79VWNgpKCRFG/txnWG3WgRw4NvT8iOKrHqH05TY84Ywk1nNlYRBtcgAuLLHvxzlOeCi
	l4BXHOobMHDRz9eMkt5XGtbcDXx8grUBKokCouEg+nMJUEnkCfr5ghnzFbWuTi3oY0hR26vmK8x
	WyazxmRWfOA/SxWiPkJfUOvoUyJB/pPYwiy2Z7Aat2WpiOp9DzGFB5iwshqxF/IN7lhJaAr7pJk
	CN5pfSKLDq1tc1nLsS2nCr36b2E7La8CovCize9vcNfUvHHgb2Ck/zJopyg5e3gzUFWYvkk4LzC
	LRgnUsLnKod3gkQlU/S7WQ+Ve3mkUGTlCaJN5ocs9vomjXiV/dVcRlmKXCzQ11Qon1OWIVxV0Xn
	MPUMWTTBgTIq/kJgTIMR1NSfNYSdRpDlF+JYb7V7BitMEIpaYuSGKbLc6Ar87LABV9emv0dAft5
	VAzsdH59uriO49JzNoqGP9hgAWwnIPFegxVwLlPE2SQDBp+/fLu0frcBUmU2xGeO4qkowAHRv9a
	eC4j6uzkkvmKxjAzKsFRUoFXlSdHYIym3bbqOdsh3lHdhc/LGpHVm4ZzoOLqR+eCmPrZIN0choM
	dd6DQ2PKVOpBl2L/TlOi6wUDSwktrkQtXTHrQtTvrSqqK5zV89/rQzfE44TFSExn8D8Hv/P1uII
	SZPQVSIWB2YWI9evPltowA9WXKlc4RozBsp0DzIRqpLxXobxsi0Zh+
X-Received: by 2002:a17:902:ce83:b0:2ed:205e:eac3 with SMTP id d9443c01a7336-2edd7673ee3mr20690885ad.12.1794383570630;
        Tue, 10 Nov 2026 23:52:50 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6e0d5c0sm17541865ad.71.2026.11.10.23.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:52:50 -0800 (PST)
Date: Tue, 10 Nov 2026 23:52:46 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/9] kho, liveupdate: KHO/LUO observability
Message-ID: <cover.1794383544.git.chris@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_235251_498013_E1D3BE34 
X-CRM114-Status: GOOD (  15.56  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

At Meta, we are moving towards using live update on hypervisors whose
VMs can't be migrated away first. We also want to preserve service fd
stores across systemctl kexec.

Our kernel rollout is driven by health checks from each host. For
example, an increase in rejected handovers or retrieval failures may be
a reason to stop a rollout, and the bootmem size and sequence number
help us understand what is happening on which hosts. The series exposes:

- how much memory KHO set aside
- whether the new kernel accepted the incoming handover
- whether LUO could give back the state that userspace handed over

We expose these in sysfs so the collector can read them without opening
/dev/liveupdate, which starts deserialisation, or depending on debugfs
or the kernel log.

I also noticed that the incoming kexec metadata page stays reserved
after boot, so free it once its contents have been copied.

Chris Down (9):
  kho: Reclaim the metadata page left reserved after kexec
  kho: Make bootmem reservations visible to fleet monitoring
  liveupdate: Make failed retrieves distinguishable from dropped files
  selftests/liveupdate: Catch incorrect file accounting across kexec
  selftests/kho: Catch missing or zero bootmem reports before kexec
  kho: Expose rejected handovers that look like cold boots
  kho: Report how much handover memory is preserved and restored
  liveupdate: Expose the sequence number for consecutive live updates
  selftests/liveupdate: Check handover revival, sequence and memory
    stats

 .../ABI/testing/sysfs-class-misc-liveupdate   |  56 ++++
 .../ABI/testing/sysfs-kernel-kexec-kdump      |  30 ++
 Documentation/admin-guide/mm/kho.rst          |  19 +-
 Documentation/userspace-api/liveupdate.rst    |   8 +
 MAINTAINERS                                   |   1 +
 include/linux/kexec_handover.h                |   3 +
 kernel/kexec_core.c                           |  26 +-
 kernel/liveupdate/kexec_handover.c            |  82 +++++-
 kernel/liveupdate/luo_core.c                  |  58 ++++
 kernel/liveupdate/luo_file.c                  |  16 +-
 kernel/liveupdate/luo_internal.h              |  34 +++
 kernel/liveupdate/luo_session.c               |   6 +
 tools/testing/selftests/kho/init.c            |  24 ++
 tools/testing/selftests/kho/vmtest.sh         |   1 +
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 tools/testing/selftests/liveupdate/init.c     |   5 +
 .../selftests/liveupdate/luo_handover_stats.c | 258 ++++++++++++++++++
 .../selftests/liveupdate/run-vmtests.sh       |   1 +
 tools/testing/selftests/liveupdate/vmtest.sh  |   2 +
 19 files changed, 624 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-misc-liveupdate
 create mode 100644 tools/testing/selftests/liveupdate/luo_handover_stats.c


base-commit: a0dc8eddbfdb6dd9c5c2b70eb66ab49cb1978425
-- 
2.54.0


