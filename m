Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EEE606A31D
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zQF1ojTe;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ua7oM8fD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kt6vo4l51awhjqq3I2zXUePIjWcvYUZXxZ9RPkgXQb4=; b=zQF1ojTetHTpEoHJeNI1LLvhmE
	IJVe+qiov2jqTtnsI46j7Deb9X7rGa3gDO3fokz3XeHvJDXKc2VNd00f6XGC5LP3nZpEFeYDgUQIv
	ra8SFRDwr1Wy5lpORZRKuC/eu0pqxfOOKRNY3CFhjnqKbAf7SMBb6C5UDKrvCsvd7SL62aiWPOL/R
	m7tkFDS4bGTX+tP8YemLOYZbgS8W2qixOS8BfKaQx7ekuQPac0vyEgky8EUUWW4FWOSZfVIxcSJD0
	4SW9MsoIpagrO7EZ094NzGuXpalILanTtzHfr4Y8E8UcYNKNTTWSexTDFG853nEO+uIapusP4Bgs4
	Ycfccu1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJTNq-0000000BaVC-3jg1;
	Wed, 21 Oct 2026 10:17:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJTNp-0000000BaV4-1UnN
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 10:17:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 86F3860052;
	Wed, 21 Oct 2026 10:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3D61F000C9;
	Wed, 21 Oct 2026 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792577840;
	bh=Kt6vo4l51awhjqq3I2zXUePIjWcvYUZXxZ9RPkgXQb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Ua7oM8fD2K3FMaghCaMTRd9ndhsONSrpG8JtFqKFRH7QkzZYnNXA15wEiVNRYcXDG
	 /ZrdAvrUX1dtBFeRhboJ87hFl8Lzk2RKkMo+bHOPOlIZFAoDm3FUFDBYiwNrXbzbiD
	 o5PqeyWU4ITidvmG4Pin2asL7HiPpAK5VRQp/lO2O9dQyJoeQua+dNbvzRJ8i0iXzw
	 17K2T8spJdWwbNdFEGl73ma9zW0rwXlPoPHGDVLapHBQ+CXK8paHtxovCMXXD2WYB6
	 AqVhpfGAghihIMoozPSch1/UiP0HFf8Obo5ajBAhbOVNVfIEePRmHOtVNCEyx3kiUa
	 Jdp96m58i4GhA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,  vipinsh@google.com,
  linux-kernel@vger.kernel.org,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  graf@amazon.com
Subject: Re: [PATCH v2 2/2] selftests: liveupdate: Add tests for
 LIVEUPDATE_SESSION_FREEZE
In-Reply-To: <20261020144710.4154339-3-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 20 Oct 2026 10:47:04 -0400")
References: <20261020144710.4154339-1-pasha.tatashin@soleen.com>
	<20261020144710.4154339-3-pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 12:17:16 +0200
Message-ID: <2vxzzew7fjdf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20 2026, Pasha Tatashin wrote:

> Provide luo_session_freeze() in the liveupdate test library and add unit
> tests in liveupdate.c covering the LIVEUPDATE_SESSION_FREEZE ioctl. The
> tests verify that non-zero reserved bits are rejected with -EINVAL, an
> outgoing session with preserved files can be frozen early, freezing an
> already frozen session returns -EBUSY, and attempting to preserve an
> additional file descriptor into a frozen session fails with -EBUSY.
>
> Also freeze the test session early in luo_kexec_simple.c to exercise
> LIVEUPDATE_SESSION_FREEZE across a kexec reboot, and verify that
> attempting to freeze a retrieved incoming session returns -EINVAL.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

