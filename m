Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35460A261B
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Oes0VuAV;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZLuvAZKg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4Gp5QAphXPOU9Urmv4w5lLuRS2sQ7D3ObztsA4P01E8=; b=Oes0VuAVH+9sqV
	hyubs6mj8pyIT0OejEjJfXgcqYMNZqs3visEAxAG0S6c1Mz/4KAB/gEmkKayImKyBze19tgOl53++
	nnKwmLWin7WVGMs8oEjYHMeQcS2v1XvpL//yIyLBJM/KAWsWBYuvMoDOIBOwsLLUgWcHG2DSciiBD
	iUgPBvTvFnZ3M8//0PfmpXV1krFJv3muhClRWpCjxxwiw6vyC+ldfPBG6mx61qRToVVWGHQGjDlaw
	1Gk6uN4KL/ENduMRVnMN/7DQCoTnQL65homAgmiyW/lx0mzuk//FjK0IYy1yLH6x4xsR66zY7vgMq
	IN/PVSxCLLax2SuRXQ6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRmWh-0000000C0lW-2npx;
	Fri, 13 Nov 2026 08:20:51 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRmWd-0000000C0iV-2lrW
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 08:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794558045; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4Gp5QAphXPOU9Urmv4w5lLuRS2sQ7D3ObztsA4P01E8=;
	b=ZLuvAZKgSIFEOC2LzBDygHQRlofg3GWWb6VszCy+ZvY6bNNszQLCgJNEXyFuawTExbJWN3WXsksoXrwG47oCs737tpsFZI42dwHyFJeTU7HeoE+hKiieAz5WmSLiATYkO2QX7dTGYNfxW8JMsWyGk7HOgCl9MfbAygoC4JzJ/CQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XEeQ124_1794558037;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0XEeQ124_1794558037 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 16:20:44 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: bp@alien8.de
Cc: dave.hansen@linux.intel.com,
	jarkko@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-sgx@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	challvy.tee@gmail.com,
	xiangzao@linux.alibaba.com
Subject: Re: [PATCH v2] x86/crash: Disable SGX in the kdump kernel
Date: Fri, 13 Nov 2026 16:20:36 +0800
Message-ID: <20261113082036.52175-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <0E3109CB-AE2B-475D-95AF-BD5465748ED9@alien8.de>
References: <20261113035019.3747461-1-xiangzao@linux.alibaba.com> <0E3109CB-AE2B-475D-95AF-BD5465748ED9@alien8.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_002047_931107_1C2F97CF 
X-CRM114-Status: UNSURE (   5.97  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 06:19, Borislav Petkov wrote:
> I don't think you even read my mail.

Sorry, I misunderstood your point - language and my reading
comprehension got in the way.

Based on the v1 review and your feedback, my proposed approach is a
small kdump_disable_features() in the x86 kdump code that checks
is_kdump_kernel() and clears the cap, called from setup_arch() after
parse_early_param().  This keeps the disable in x86 kdump code without
a parameter hook.  Does that work for you?

--
Yuanhe

