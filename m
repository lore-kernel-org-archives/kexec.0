Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5410ECD4F47
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 17:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KisQipb+u8ZX/MhoM0RgywoyXEoAnE3ZKJTKFmwfaO8=; b=LQvWXr2JufI0YzA4YB28a50vFM
	T/LzjStPjl6fPPNB+E0WVQvgu/Vd/fhD6yFlo2bTN8VbnGqvzESpEoEI0nRFGmJc4KXZge26dviQo
	8TvRXcQkCodeY3lQ1agMOpSHb0nqUdndFhw3tKLi5O3E7VRpZ9+KHfUt1bXsx6HW7FDwTP5ltoeBU
	DBRC7jEVy6Xqp28UADbdb35cq2b7+1tDVZ0eb46MeDFpTl72kx4KjqEGcfhDAs9rI02kJiWj7VhTP
	ixIURkNhY9EjS5I/m5Q6D1Mq0gBw7C2V0UFzrf+fLq1+Ikt4cjx8xXaXzifO2zJm/suI4iej8TGY1
	b30wcpAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfRP-0000000D8E2-1aY1;
	Sun, 17 May 2026 17:38:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfRN-0000000D8DZ-0sM5
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 17:38:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DDE7943CAC;
	Sun, 17 May 2026 17:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624B7C2BCB0;
	Sun, 17 May 2026 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779039492;
	bh=hUXEIurEBWkC2u5wz4FjIdplyJXliJSJqkf1ECw3UDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFLx6ZNf3rrbva2M3m65Nd4aTUKBDskBTAyJvCjKxOWOWO2U+uXm55P1kFR6D3V5B
	 2MghIV+hpD7aSSqQ9qjxY1v9NiV5EuhzuF/tpzGOtf2xJcKApaPaMkRt9vT+D6xMtB
	 WhKI/ZquiUJE/91W4Vl3vVJ+nvSp2GiVE7A9FqNJij3E0FbOQvX8MhfzQ0dCaQ0Vcc
	 weiEdPQRSeTvrepjQbsJ76kfFv8m/cSg6Au6rflUxL7NuXB0MaLp5OTzaFNN0AoVkC
	 TbqxfzIevYlrwaGMBK68BNqj5UMzmD7DONdBpD56DqyFVugzLDSZ9nU7Ror2x0iwRz
	 3xS5LjIPteA5g==
Date: Sun, 17 May 2026 20:38:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v2 10/10] selftests/liveupdate: Add stress-files kexec
 test
Message-ID: <agn8_FAtMdc8B5c9@kernel.org>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-11-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514222628.931312-11-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_103813_269133_E49CC7CB 
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, May 14, 2026 at 10:26:28PM +0000, Pasha Tatashin wrote:
> Add a new luo_stress_files kexec test that verifies preserving and
> retrieving 500 files across a kexec reboot.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  tools/testing/selftests/liveupdate/Makefile   |   1 +
>  .../selftests/liveupdate/luo_stress_files.c   | 101 ++++++++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 tools/testing/selftests/liveupdate/luo_stress_files.c

-- 
Sincerely yours,
Mike.

