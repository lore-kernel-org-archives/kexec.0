Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089F606A33A
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NztpFIdD;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=G9nW/SDb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wks6IuPqWWMlFcHqYGHAoryyAYjkkjwfVtcF5N3uln4=; b=NztpFIdDr9iBR7
	xLWpbKyrz4dmAcBsUswj11Qmp0CfPg8Vhu1n9wmnpl5arSskGOW1ntJrkRvHTHHfGb9v2nIwi0Fm0
	ivsZncHbQZwDEHFW3UzemmWT4TxEaXktvZfvrhZBh8wtEJrwB3ze0pu6hxozAj8BQRZC7y2hWhRqY
	8ZpWFZ0NJg+x2rUgcIWx5nVTbQAIeFKWzML6XcJAL7FMm3fWFaYNXCFM/Rb7VJ6HZPyfJoHJoqIMh
	d+wPMn0xllT0lgYsPh73kttDdaeSY0sQf36G/qlMlmSA06maSjH4rpyaYvgYfUVRH4rSm8xHkYy9Q
	/sHHCX7ihgE7R6GJB+Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ4ks-0000000GIw3-1hme;
	Sun, 08 Nov 2026 15:24:26 +0000
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ4kp-0000000GItS-2EDK
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 15:24:24 +0000
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so57002241.2
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 07:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794151462; x=1794756262; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wks6IuPqWWMlFcHqYGHAoryyAYjkkjwfVtcF5N3uln4=;
        b=G9nW/SDbK9QVJkwqUZg/hDWGOYG1F+tt0/vI4Juw1jc3HJFGJFdNAxKzCJoh1JDXMU
         4efiUzxXh/SvCFhFCYDSNZa3TRwK0syENrpVyu17jPmhXmWMgRgEcm/FYEBPFSTCF1hL
         IOumfMexjUqvTeSvMhacWSGOR41F0rPYP68g0Ksea5GGlUZm3O3fOReUT+LpFaQK4b8X
         RmjlR2G7hSixqZ7Ld8IM3Iz4uHVRel44MOUPywgTArr74g4IGdS0NSYz/IguZEmSLcGo
         WIbQbXuR+gY4+ziHORpB9MD6uXpZ3YowK3aYDx8WThtsDKaWH91ESTs3v7jzg5YVDd1D
         StAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794151462; x=1794756262;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wks6IuPqWWMlFcHqYGHAoryyAYjkkjwfVtcF5N3uln4=;
        b=BDRbPc46sxQchHL1xmDHWhtCsMYJuKAWEyw+hiZyqnJfZDbd63cEY5JkPiz1bkDgrA
         8Dj9wWIEHOTTqo3CZafVl7G+1dBb5/UOS7yua2GMpuNQE3WI2ooX3Qbn8urJ5rwQlVNQ
         4Fdb2y4/rgbeO0OMcrsjy/JAmzW9jJZMK+lCDwhdACeV0iWIObajhzIBmdzz/vs7H7Lk
         zuWTiSsn0WyVhzKKDLAOmAtx3sSs7rIVPCUkTKX0a8GHJmVCOQmUUEoXhkpwKlMLyIZ/
         5WiROEnWCOlnF64Uvo7hFSvI3mP6e+wvPvp9hkx34jkGTt2c/U9ygjVH7CsaAhNvl6sH
         +6+Q==
X-Forwarded-Encrypted: i=1; AL+hErEkMU86h80S7K/gQ9bxIQyMOiQOu+P31Zb8UytfPI21LL4RLZWf+f4eaEFWqZ3nH2Fuvt9BsA==@lists.infradead.org
X-Gm-Message-State: APuU4Z8hGC8Aq21w2HDOBOiawYy+nEBmrUkOGTpA8uJqSTwLVfxG2zfQ
	nwoS7dJwHK0Lova7THGyjM+7B9BooljAh/KsAaO+kvRE2U7ZMUXp9D7L9WAoPT/Nunk=
X-Gm-Gg: AYBFou2vVyrgk8gWkjDbOfH4sEGdmT49lgPdnOb8UfGv5yk2sc1s8Iu5b9nk1usX9s9
	HZyQ0FoyVpyor4kA/3TZPDf9gor8EVjGgVF8eTAdvTpg9nIy33tnwtxJDxW+wpLJ34qhut6J+DU
	tylbvOCr1YR3zkNQ49heBEmqE6GlbBINyabipTT+Z/RtXHYqDbvDTbVBqIUEOOSEL4oP5Rhn3jd
	oSToDSrA7wS5SYqLPbPa5LkIkFmlomK2gEp47AHCsz7Il030uWBwaYYRGYuW/JrTDC6FvIOAVQR
	pzZSZYTBk4qt99139J2r/0A2iw8BxNQlTM4m7mHSvJ23/ZEpnunXWZbRePMlHI+73QOYtoT+RL5
	mk8dPm9S/BN+41LV4HWkbLoKAPJDVyfbnkmXkgjD8kdhCaAjCWqXGb8LM4J1pgytISFp+4wKpDo
	2xsV/W9P3yz6k/eeaZxF4o99XsirtaggwVbRUzmS7iKFzEg+yCfDXMRj96l9dmiLAb0SzcbaDkq
	UxiJBsCDeeHX7lAG+aUliDgIHti2Yik7fRtgamdqGf2uaXCAuO4VjPYIA+fgqpT1IQDCDLvWZBp
	TYLY1gfZvs8HRHlJqHtnVzRjz+UPJFyb/oY61SSMfrvvD0ZqvqndnqBfTBi3lO6o9pcQg4PMNfI
	Nf3QamicPPEP05B/xbSMuDmL1DMoXrbnJ8GMc9fw59Gu3ds90
X-Received: by 2002:a05:6102:d92:b0:7ad:3ad3:997a with SMTP id ada2fe7eead31-7d2daa685bbmr485125137.5.1794151462168;
        Sun, 08 Nov 2026 07:24:22 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece60c1adfsm2166205e0c.8.2026.11.08.07.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:24:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 3/4] selftests: kho: Add riscv support
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, 
 shuah@kernel.org, guoren@kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261106071459.2003-4-cp0613@linux.alibaba.com>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com>
 <20261106071459.2003-4-cp0613@linux.alibaba.com>
Date: Sun, 08 Nov 2026 10:24:13 -0500
Message-Id: <179415145358.358073.2579925146371313024.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=279;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=2foYgeRjtLhgriBAFewI3QB5zsYy+0XWNuIAF3mfsnE=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8JQhKpBPG9CWddYheCPGKD+kNOAaT7Q0REO8/
 X0Xg5z+ESOJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavCUIQAKCRC7dyhM23N6
 3is6D/0UINh3QpPKiI0oOOWcH4They0T6KUWUtHH8paLMyiZTEZkaScs0phm5xLc845Ic9LxgmV
 Ob9G+SV8Wxahy4a/rO74Z83XKMVJDWYIpisVHoHivOtAWR+j/G79uLhwjA8WzmN5yO47Bk2nvkh
 ZzBpJEvC9rwTiftW3gZFajEGLRiM49GUVyVv//8qqXJ9Ikppz4DVWRb5Ym4oX6AGzPcIAbONe1A
 nh4nvYGHDQ8lBVPB66a6NO3U6WyIEfh6uZgSQ/++97wJ9wqMTtCfxkBkGLmKL0Yk1AOYpy90QwL
 CDTFSiHMVtve/xrQqdf0EWmvioVf5R+GdmTUyZYuD7pGWDiWkeuLrx8Fp9X79izbp51wQNuYxdM
 JdUKLm2Yg50CclKLaZ1Kfbx5gj3v9DkMLC70EqXxhq5F043Wk9G+Eja6C5cARA3buxzkWeBKNcT
 Ucgnb2XSQM/ctZe6Hg7U78wNzRetTB3KrvVsXeS8Bs4gsKjqptzAokRR3Ta5gTl3eFhb78CfB+0
 0xjt0yhEuEToGjrrg9yY6+cQe1olAah0ZoAIy3V59Ld0EoWxxy3a6V1KwMfNYvm1seTYH704eJi
 iPUZenreJsXOKLLBV3GO4GQh7ruky0RLLEMmdisjXOsYgfKc8xta8jxJJBAUKw1MxbYd41s0ZpX
 dEAw+5VN3pA4i9Q==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_072423_590684_776D2EDB 
X-CRM114-Status: UNSURE (   5.13  )
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
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 06 Nov 2026 15:14:58 +0800, Chen Pei <cp0613@linux.alibaba.com> wrote:
> Describe the machine the KHO vmtest runner needs to boot riscv64, so the
> test stops being skipped on this architecture.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


