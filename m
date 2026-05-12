Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B01CD4F24
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R9vgovai2qZ4+GTWVA7dNoj3PLQixVC0z5zMzu0oHkk=; b=LxQYP6yJX8+T0IeFlHLptpZkF2
	S25rg0Mie+1VzayqeM1EHD87Vj+U+ezNWueOPVAo2UHfStl/4nqumydqtJNlrqatoct3d5OMwBecJ
	1b6rrmvywpXp5SZ7bL7IHJ2H2RAbsVHpfYev5pM4ruICBU3nToVwoqeElpasM8Dl0OThLk7y+YrOV
	9Ml5geyOU+Yhhuh3myaeBwH+hvayw5ZmtikgP2zdRdq9gb0uwSHWMfZ/c6oH5YKIS1g/GgzasduLp
	70SySwuQanRO+rv0hSq2idO7GykSmFxA4+7n/ORf3Rd8x6rrIPyz2Gb8h1gdjlqQzP3bP5lc/uIBv
	HBcgJJ9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnp0-0000000GyZB-0qcU;
	Tue, 12 May 2026 14:10:54 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnoy-0000000GyXc-2s2M
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 14:10:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 29B966183F;
	Tue, 12 May 2026 14:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B8FC2BCB0;
	Tue, 12 May 2026 14:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595051;
	bh=anjlqCUoPbEaiZ19uaavn8uvI4scPPxpypmtBvx16XE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SLBC9DHS28emqubhd4NrBcWrLVdJZKmDve1jZ/ycL5EUF0aCngHlZRI7Q+ac4+jSv
	 Fn/COdzXAZxzZoGd4N3+4cx7wtfAB39uxiA0ZmaTK3W8m70vm8n2mobaZyty34a4OK
	 Y5FIlJVilBNancIc9JKK3hr/zQX/zMPxLno5EEwZLXsFPQ5EgnzArTx9kbyPvViC/G
	 y2t5JuwbDOG2KGkTSdS/GpJHTH/AwDH+mqQujcjeiIECewbsH4UltssS2a1fRwkGwh
	 4adPzZgqCLoD/37zMVOHgPk6OfIFV7IeqWy9V/9evzeGcFrZkvXklp2Cv8JB3jmq+I
	 xddlA+mWYRhcg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH 5/5] selftests/liveupdate: Add stress-files kexec test
In-Reply-To: <20260414200237.444170-6-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 14 Apr 2026 20:02:37 +0000")
References: <20260414200237.444170-1-pasha.tatashin@soleen.com>
	<20260414200237.444170-6-pasha.tatashin@soleen.com>
Date: Tue, 12 May 2026 16:10:48 +0200
Message-ID: <2vxzh5ocafbr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Apr 14 2026, Pasha Tatashin wrote:

> Add a new luo_stress_files kexec test that verifies preserving and
> retrieving 500 files across a kexec reboot.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

