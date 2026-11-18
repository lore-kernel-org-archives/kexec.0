Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545C606A320
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Llb6PYc6;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=WKGNZWqS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gN7nvCApkpNJjBBl+gdS00SQSe9taX0A7DICocon5Uk=; b=Llb6PYc690CIEw
	t/x0EeHel2OVOKLxUlioE3+QVbnoWRjYfNLqhcDu0Klcxbo509H7w7b02Umidm6Qkj697hUf7hKkR
	fgLwp9Mgw4kUq4xYQwFi83537msTIksQRyHGg2im/U7K4LwwhojnXEOAPDIBkHiAHDxZtTwUfZ3eI
	nckvIMann9jPB94jwcPzhg6c3lXiBCs7SJAPiO8kJGuZY8Bun4J1bbqFPJGdn0bMtRp1cZ/xaGjZO
	3Lq0QjbtYqbluKveOClYeoosqSt0K7akTmfLw2dDkq/UNUUkl1tXxXUqAbB0lZHZHsLeP7QiVsEIj
	Z1ldpWAz31BRR3R0YzUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTi5B-00000009OMU-30bM;
	Wed, 18 Nov 2026 16:00:25 +0000
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTi52-00000009OFT-1eeT
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 16:00:18 +0000
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so810814e0c.0
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 08:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795017611; x=1795622411; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gN7nvCApkpNJjBBl+gdS00SQSe9taX0A7DICocon5Uk=;
        b=WKGNZWqS5o6w54DxZhdFNwbV8ZuzPSrBoFZkWjOFl+anQ605b5CIowiEBQE115YK2A
         LqObCdBrLKnPOgUE/I3KXwCVCXPoJ0Y9cIAu07yAKtmJkqCvt+znl34TbfMPKYn5slwP
         fdqdDCOsaTdAMgFsa4h9rqClEypJMOzDGgrq/VHFBuZTorERolCQAErocG+nRuXVe+0y
         JlKdi4xt9IsdPMaz+2RVYfhGR3pVo9BbqL9fp1+RIz86MFb7aMtdx8rNGhXrDgXiLnAo
         FFX5GKWy4bQv5sIam/gt1HXMMUhO+22ASZdv+7aNX/7luPOmHCpbafFA9nTP0V1DEezn
         PY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017611; x=1795622411;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gN7nvCApkpNJjBBl+gdS00SQSe9taX0A7DICocon5Uk=;
        b=oil5XXedd5JB13T+w52mIQ4eoJwMQUyvmc8bJ/Nubffk9r4h/rLl3Z0twOGtzBWeiD
         5LQeA+GHHK4ADbDs66dyE3jRswTeK+yx1Zl0FZTiQBM+E3mS0rJU9a3I3ESwR9jR96qn
         2ZXgzPa5sYRWkL/UVAm0u1D0etjzQ6V7bbvUYlU+sxkrfd7nBZ73cF+Xkpw70wh+J926
         Z/xcQ1KLTV5CBAwgmjp4C4eXMqXpyGsPuwXqHlnEpMruVz22aT20wZblakWlIkPlphwl
         uoI3b4ekKNBG0GCiR19/euSeLbVO6J4IB6s9wMfeMZmQC8V2N20x0s2v7Xa9vE+PqgAw
         k6IQ==
X-Forwarded-Encrypted: i=1; AL+hErF4kJYP+kkipmk9tF5PpqIuuh2qDXlx6OnJH30r6SbmGZ9Eb8wB5eRDxSKd1DzOpwSogyeEVg==@lists.infradead.org
X-Gm-Message-State: APuU4Z/CwBhvAMV9gJ9hOuef684f5Q6/TSwoHVh3c086xIwck0pQIAov
	tlTnOCk0cdGL0mN1aNCN82fMAbqdjxnUdHJzBgFPyUe7Aog/gco7byUE38OwDuUrOOY=
X-Gm-Gg: AYBFou00uk/6f7KVumNZW5C7k22GRqsWErDi20zV79qwbCyh4eeVrGIRp0B6+oXSZhS
	sYtHKXrMCFuYV1XoAT519LiCw7qzIOQFm0xYG7ss6xwpzvT0LmdnnqZZ1RT3xKZyYbB0sBZQio9
	kzusoCOEELic/cNHMfCr4VSFDbYAW76lSMIhRn5Z/8bgqi4jfRwECSZw98sjyrKH7B2v4Vgam8J
	sRAUOyhEMsZrPF9emQ5JCbR4ySoRximwrnEu9EmCmLRQwkRt4frLwJIrKRM0a3msHO05cWB+GQx
	5jOup1W1+X5iOgHAxqOhONTb/dSAOYv5uodW8RM3iNejKq8aqprHM6HvMTX7zlb3TptfL0SqOpJ
	Zk/YPyAscQm9aYnc+pKpNRzGlfyaeEf0Nm0mkPfIA5EbROqTzh9rh5coEGgL0jCqN43AwyxCvzF
	Bydb0CXxJcTKTKaLrw9+4dxZlKBuyxbOshO5JyIorR536jikcjOpH9Mdkg0WUyQ6KgPe4mopOsW
	80mAcBIHSYEBD3THDbRHsvebt+3QEfAJ6GTRTFyxoVijVsjPn/Q1GNCswmi5n1B7D+MS4nNi2ed
	SXkogzo90laPu4sHmCm374Qts0ArITr3YFoLBeQWuaW9DGMisMKFHt3r3x7qisLf+64Mp3Zj7z0
	qRYg5HiBdJVTWF1h5EsbWHiBxayHpGvW1Jip6YskCYOQcBHj6MA0EoL/WG2+7tZy2nX/3
X-Received: by 2002:a05:6122:3a15:b0:5ea:389c:51e4 with SMTP id 71dfb90a1353d-5ee645faa03mr1663031e0c.2.1795017611348;
        Wed, 18 Nov 2026 08:00:11 -0800 (PST)
Received: from soleen.c.googlers.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64ec2730sm2002506e0c.14.2026.11.18.08.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:00:10 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, 
 pratyush@kernel.org, graf@amazon.com, shuah@kernel.org, 
 Chen Pei <cp0613@linux.alibaba.com>
Cc: guoren@kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261118091603.979-1-cp0613@linux.alibaba.com>
References: <20261118091603.979-1-cp0613@linux.alibaba.com>
Subject: Re: [PATCH v4 0/4] riscv: Enable kexec handover and live update
Message-Id: <179501759947.250261.1712117569683645423.b4-ty@b4>
Date: Wed, 18 Nov 2026 10:59:59 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=yx/6YU4ftdolIH+TM3tFCIqxwpFna+tV5pnuszpTgAM=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq/cuKW1Ven/TsYWcH9R9JVtNZvIr/Wrzbj9eUF
 VZnu673CJ2JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCav3LigAKCRC7dyhM23N6
 3l0zD/9GkT2xiw3xOPo4dtrl50v/Zo+28SEOr65ml35aBi52o28TK4homX8OAljUtDYygGhutpM
 WxnvBmRGuzLI5PV5A7/SV+WgkIZ52fXibj+mPS9LI2vYsbaTB7qWpXD/tPjUXOLL3sp8s0nWgA/
 xzgDZjJbri0YhMen/qMzef3v9u09p3Wn4uVIdtlK0LLcBqgYpEtW1xCFKqg8Plgdmm8VzBkMBqm
 201gts8eO1QmJ87giSN1+mgcvDTecZXC7TLBmWsfh6zueYb2h7iy18luOHRy2FcgK/fG6x6oK+/
 q5kb3mOX9vuWeOn4JfkYG9JvRemmTyttU4mvzXS7wc56lZd8ObMBpcWCRJaliTNo4Fwky6rrbSU
 ubyyFqvQGzUjfL2/Rp3rc+Cie1RnXgh0XXw4RSGXf6YrqAi8dVFfXKbWikrk5D9dqJ+2t6zEbFK
 +GHKpssJeeElG+UOr2KEGjpeWljj+Alhh73XBEVezYA9oWQYDth78nJKELwFtPq8Xcfc4Br9O1V
 Iu1DpxwaZOV4fUHtQpY9XdoUQSLklPkalqeaaIppy2vDIKY2IMWWeLNhVX7XrCsNIO3L/BO4EIS
 BjJYaBZ3qqGAfTeisqH8//T8U/uQq7h8rHx7J2zXA1bXqN+ErinqAopKFwtALn0trP8D1sYJivX
 Ntme4+UlYo8oAIg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_080016_458477_97ADD238 
X-CRM114-Status: UNSURE (   7.18  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 17:15:59 +0800, Chen Pei wrote:
> riscv: Enable kexec handover and live update
> 
> Host kernel updates in the cloud should not require draining the
> machine: next to live migration to another host, replacing the kernel in
> place while preserving selected workload state ("live update") is what
> KHO/LUO were built for, and LUO's documentation names hypervisor hosts as
> its primary use case. This series closes the gap for riscv64 and
> validates it with both upstream test runners.
> 
> [...]

Applied, thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=liveupdate-7.5

[1/4] riscv: Call early_ioremap_setup() before parsing the DTB
      commit: dc821c9badf7b2558e206804c2adaae28d25477d
[2/4] riscv: Add support for KHO
      commit: 48ea610913a6d6fc513d082afad04ff342120931
[3/4] selftests: kho: Add riscv support
      commit: 30c6fc85b4fb89fc867bdea413403bf169e7e194
[4/4] selftests: liveupdate: Add riscv support
      commit: 9615c5074cdccb651684e61cd8872ca8b0b30e52

Best regards,
-- 
Pasha



