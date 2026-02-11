Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A9CEB594B
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DlxKDEX9Ctkf0ydS0qNB4rwbKcVtPfAX274yJ3VsAXk=; b=EAOrvmBPCreER1CqTqbLGqMERg
	AVu09RtZodg3jteUQp8FIAIbuL5ZCUth2+6fTu2tjIk+cHLB/isejFF/fApNpCBUywGH2V+9WUTQa
	DwQ7KuSml6dQ7AOp4Lc3TqLbY17UtO3gZ56yvsbRHMKZCJumDWHdXOQPwN3ZJxm+FPnFavEK2XADg
	mqiZirm4rS8eGTKnHl0c1l8Ck6d5H7MiFl3/lxdvhUSn6FUikma78BFlA6uvcrWRYnVr6VeviQlDP
	g1lXL/u1T4kjPM5e+r+Y8eEmyGWRo5COZrbjA4drpIIpU1ALzScUp3sNIngqw/9XX+3fg6H+ygQKi
	U6zNi64Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq0vg-000000009i4-1NVG;
	Wed, 11 Feb 2026 03:30:16 +0000
Received: from m16.mail.163.com ([117.135.210.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq0vZ-000000009gB-10fh
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 03:30:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Dl
	xKDEX9Ctkf0ydS0qNB4rwbKcVtPfAX274yJ3VsAXk=; b=cvzJ3MJ+YOEPmUlHfA
	KOHspA5h8LCAicPdcvUEdYV18aaeGrO3E19tTcpfRbhyz+0FpPt/Q88gXXsitx+m
	iShjgzO1T5xxdtdVWCoRG1dHMeoS0PSNUT51VDxIUJoHIXn1kin+mswPDpDhd/7N
	wnPJMtuu9EA75lXxErsC3AsiA=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3f96j94tpMZp0RA--.2981S2;
	Wed, 11 Feb 2026 11:29:40 +0800 (CST)
From: ranxiaokai627@163.com
To: graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH v2 0/2] two fixes in kho_populate()
Date: Wed, 11 Feb 2026 03:29:35 +0000
Message-ID: <20260211032937.208353-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgC3f96j94tpMZp0RA--.2981S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4Rf9N-UUUUU
X-Originating-IP: [117.176.243.201]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxgRksGmL96TACQAA3u
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_193009_668728_3C9867D2 
X-CRM114-Status: UNSURE (   4.68  )
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

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Patch1 fixes unpaired call of early_memmap()/early_memunmap()
Patch2 cleans up unnecessary call of WARN_ON()

v2
 - Improve code readability suggested by Pratyush
 - collect reviewed-by

Ran Xiaokai (2):
  kho: fix missing early_memunmap() call in kho_populate()
  kho: remove unnecessary WARN_ON(err) in kho_populate()

 kernel/liveupdate/kexec_handover.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.25.1



