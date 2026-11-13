Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431D606A323
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l4nbGMpC;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gGoBcuBm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sDUcwGzSfrw/FctpCec3z0ryFud5aUBbIS5aCK22y1k=; b=l4nbGMpCLY9Q14
	BA18wByKD+MO/XKQsigz2DajhfeNUKjduJfOw6mHQKIXheV0cCGh8Rp840EsHediJoTpYBZd22jCp
	0If039WzlT71Y3K5aADXYmHxS32MLE+NVBt+SDciUfA/YtwhzmRTCqL00kiTqQMhVfPRT/+qY0ckG
	4YDYgGpUCTPMlSTt3ZwxTV2UMlpIeDnNT9K+LxmqaMQgqh+PnfzDK+IsyebsgiVaA7IwBANydLpAA
	HRcMlqnEVqCpbXcHK9cztmK3yO64G5uVoaR7RwdZjpwWES8gBdmIoaAN/AAhduJ+A2iGlw8BxSS5Y
	ZyhoDkdLhR1/iamssmAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRkII-0000000Bjll-1vs5;
	Fri, 13 Nov 2026 05:57:50 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRkIE-0000000Bjkm-2Oww
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 05:57:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794549463; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=sDUcwGzSfrw/FctpCec3z0ryFud5aUBbIS5aCK22y1k=;
	b=gGoBcuBm424ex82QHIHnaW0g5OxSPElaAibBrQfDoiSOh+htJht5iJNfjypezCII2RngBDAY+Xil6nE+bclbLJMFUzpGkEoTbpZYbKF3RWBq+GzMQFDlpMoD4CoL6KUvY4YNRPoljiSFnEw+rS/dk8Le1hJRmlOU9fNukWkzvw8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XEe4XsM_1794549455;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0XEe4XsM_1794549455 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 13:57:43 +0800
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
Date: Fri, 13 Nov 2026 13:57:34 +0800
Message-ID: <20261113055734.3976582-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261113041516.GAavaO1CiqZ3otjh3I@fat_crate.local>
References: <20261113035019.3747461-1-xiangzao@linux.alibaba.com> <20261113041516.GAavaO1CiqZ3otjh3I@fat_crate.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_215746_786578_CDE5623F 
X-CRM114-Status: UNSURE (   7.28  )
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

On 11/13/26 04:15, Borislav Petkov wrote:
> First of all this cmdline param naming is maximally unintuitive and why does
> it even exist in the first place?

Thanks for the review.

elfcorehdr= is passed by kexec, so every capture kernel boots with it
on the command line.  We use it to detect the capture kernel, the same
way is_kdump_kernel() does: that helper checks
elfcorehdr_addr != ELFCORE_ADDR_MAX, and this parameter is what sets
the address.

It also keeps the disable logic in kdump-specific code in the x86
path, as suggested in the v1 review.

We looked at two places: adding an is_kdump_kernel() check in
setup_arch(), and this handler.  We chose the latter to keep the
disable logic in kdump code rather than the generic boot path.  As an
early parameter, it clears SGX before alternatives are patched.

--
Yuanhe

