Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB45CD4F35
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 14:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CtmAVH/fHRTtD+JkmxFCFZ5OoR+7oWP3QexqZth9Y3c=; b=Z/pA7JpBQIv05ZS/VL6Oq2PTgZ
	CN7KZ3zZFIIxSA6VLLzzh+ecfpb6E2Fh/KgoUA2ckcn75EhhufyYCZ5vBK3IBY4ZzCezdvUfVeASx
	mfhBts9lXXlnKJwTvUmrT62pRbSVV0d9KWr96AKZl19p6UHbK3QZxG5Ah8rkIjKwLvdsiHn4gQ73D
	wFsRUavAicHMeQAMzVfJfgc5XB+Yhbha1zB9t41MOhl7UwozoX/4sRNgPm3BNf53P4JaCTKx1zLhZ
	ETbAi+DzWQQAvisL19DwDJ1Mvd+sP/JEQjkEWecjEUtpxP/lrxm0x8gZk8v1EwrpolSF9k93eOmUm
	s+iFFjFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnnM-0000000Gy4F-1KaX;
	Tue, 12 May 2026 14:09:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMnnK-0000000Gy3J-3AMm
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 14:09:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 151A462C4A;
	Tue, 12 May 2026 14:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE69C2BCB0;
	Tue, 12 May 2026 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594949;
	bh=kH+DBH602R/NCMQ8TNdgFnfzcA0HQ7TM7TcnLEWnzJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YXy7tjHeVafWgkoh9kZB1s2WPWxRJwh4XA7F5ZYdpJ6KoFS3923iDL7eSbj9ghHBy
	 WEnYBAPKilqVYayl34sHEjYVC69JVD9Bigj3GJC2RaIY1ftgbrh9AlP6r+Y5KuxvEH
	 VEBUpDmxRymvetc5ItvkvIldJvreqDWFy2vAt50XQmCaWnM6wZbEIpCBIJ4U4xoS3Q
	 yyMe5OzzolcfMf8q8KL5uKNv69XgqVgX/ToKmTXB6tY/CvMIbeoDm87e/Ey1ZfX7Jh
	 uAYA1JEJPmOrSKV6mCxTYTftUsfm9YswWSYMiyiSiBRTErbDFnidoWtLK6DPSJfBtC
	 8MRuSkpinkQ2w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH 4/5] selftests/liveupdate: Add stress-sessions kexec test
In-Reply-To: <20260414200237.444170-5-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 14 Apr 2026 20:02:36 +0000")
References: <20260414200237.444170-1-pasha.tatashin@soleen.com>
	<20260414200237.444170-5-pasha.tatashin@soleen.com>
Date: Tue, 12 May 2026 16:09:06 +0200
Message-ID: <2vxzlddoafel.fsf@kernel.org>
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

> Add a new test that creates 2000 LUO sessions before a kexec
> reboot and verifies their presence after the reboot. This ensures
> that the linked-block serialization mechanism works correctly for
> a large number of sessions.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
> diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/luo_test_utils.c
> index 3c8721c505df..37c330b9bb36 100644
> --- a/tools/testing/selftests/liveupdate/luo_test_utils.c
> +++ b/tools/testing/selftests/liveupdate/luo_test_utils.c
> @@ -20,6 +20,7 @@
>  #include <sys/stat.h>
>  #include <errno.h>
>  #include <stdarg.h>
> +#include <sys/resource.h>
>  
>  #include "luo_test_utils.h"
>  
> @@ -28,6 +29,30 @@ int luo_open_device(void)
>  	return open(LUO_DEVICE, O_RDWR);
>  }
>  
> +void luo_ensure_nofile_limit(long min_limit)

Since you are adding this to luo_test_utils anyway, I think you should
do it in patch 3 and use it there too.

LGTM otherwise.

> +{
> +	struct rlimit hl;
> +
> +	if (getrlimit(RLIMIT_NOFILE, &hl) < 0)
> +		ksft_exit_fail_msg("getrlimit failed: %s\n", strerror(errno));
> +
> +	if (hl.rlim_cur >= min_limit)
> +		return;
> +
> +	hl.rlim_cur = min_limit;
> +	if (hl.rlim_cur > hl.rlim_max)
> +		hl.rlim_max = hl.rlim_cur;
> +
> +	if (setrlimit(RLIMIT_NOFILE, &hl) < 0) {
> +		if (errno == EPERM) {
> +			ksft_exit_skip("Insufficient privileges to set RLIMIT_NOFILE to %ld\n",
> +				       hl.rlim_cur);
> +		}
> +		ksft_exit_fail_msg("setrlimit to %ld failed: %s\n",
> +				   hl.rlim_cur, strerror(errno));
> +	}
> +}
> +
>  int luo_create_session(int luo_fd, const char *name)
>  {
>  	struct liveupdate_ioctl_create_session arg = { .size = sizeof(arg) };

-- 
Regards,
Pratyush Yadav

