Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E1DD15D84
	for <kexec@archiver.kernel.org>; Mon, 21 Oct 2024 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uqZeiDoJTx+GXim1BjqT6HHLjlNq4rrV+kjn5F0o1oc=; b=3BMBE87v7fxeY9
	kBBW4T7FVfXTdVKFUWzPIw0g60nziLrT9XUTDXJJw0HMoF/TFm1UTq9rdG2P4zaEZgFrvDiykqqOq
	IR0FVoXDoNBhWNdTFTfhyvfguq6oa8q0wGHGKDtenbxphR9NTDWvsXSygYl/mnUr+db+1e+9Uh23N
	IgTUbwx7KsuIPSlvHYrjNW3FtIdMKVO+/SJ3N6JVoc8Qqoox/Zqqc1Tp3qPP98lcOLBu2CkrglOkG
	8VqOWDFrSc/6UGrv19vRJMM7yntdvhgHCEj5N3LqWzSvNGD6+gG9AYGp37Dihj+SR/BJ6x9LHcWIy
	XJfticg4DvQMwI1SWXug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2r3t-000000078KJ-3Jtd;
	Mon, 21 Oct 2024 11:59:01 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2r2t-0000000781Q-05Gn
	for kexec@lists.infradead.org;
	Mon, 21 Oct 2024 11:58:01 +0000
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XXDLb50n8z20qf2;
	Mon, 21 Oct 2024 19:56:55 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 52AD71402E1;
	Mon, 21 Oct 2024 19:57:45 +0800 (CST)
Received: from kwepemj100014.china.huawei.com (7.202.194.8) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Oct 2024 19:57:44 +0800
Received: from kwepemj100014.china.huawei.com ([7.202.194.8]) by
 kwepemj100014.china.huawei.com ([7.202.194.8]) with mapi id 15.02.1544.011;
 Mon, 21 Oct 2024 19:57:44 +0800
From: "chenhaixiang (A)" <chenhaixiang3@huawei.com>
To: Simon Horman <horms@kernel.org>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Louhongxiang
	<louhongxiang@huawei.com>, "wangbin (A)" <wangbin224@huawei.com>,
	"yangyanchao (C)" <yangyanchao6@huawei.com>
Subject: Re: [PATCH] Before adding to usablemem_rgns, check if the memory
 range is already included.
Thread-Topic: [PATCH] Before adding to usablemem_rgns, check if the memory
 range is already included.
Thread-Index: AdsjsFBzKsd6W7MkS7iciiSRDB/3DQ==
Date: Mon, 21 Oct 2024 11:57:44 +0000
Message-ID: <abdfbc8ef5374d3897b5cd7a60341550@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.95]
MIME-Version: 1.0
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_045759_340637_0EB995CD 
X-CRM114-Status: UNSURE (   9.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


> > When kexec_iomem_for_each_line() reads from /proc/iomem, concurrent
> > modifications to /proc/iomem may lead to usablemem_rgns recording
> > duplicate Crash kernel segments.
> > This can result in the number of retrieved Crash kernel segments
> > exceeding CRASH_MAX_RESERVED_RANGES, triggering a realloc of the
> > crash_reserved_mem in usablemem_rgns, which could crash the process.
> > We should ensure that each range added to usablemem_rgns is unique to
> > prevent these issues.
> 
> Thanks Chen Haixiang,
> 
> This looks reasonable to me, but, as per Kernel submissions, I will need an
> Signed-off-by line [1] in order to apply this patch.
> 
> [1]
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign
> -your-work-the-developer-s-certificate-of-origin

Thank you for your feedback, and I apologize for missing the Signed-off-by line. I'll resend the patch v2 with the required Signed-off-by line shortly.

Best regards,
Chen Haixiang

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
