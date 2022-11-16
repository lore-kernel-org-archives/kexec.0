Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C4BC43217
	for <kexec@archiver.kernel.org>; Wed, 16 Nov 2022 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bwLFXRxoZesYvSBJFWnJGYcDXtnL81EX0BVLw0nXloQ=; b=GX4StozqeRLJSc
	P0fEX8Tz/ubyXauDCOxW4031Xh17EkL0x+4o2kdvhR1Yg2WsUlxgGR7JucJSSI7a8B8TobK21/8fl
	nVcOcBpmG9B3VA5guyKCfC7CrpYAUUVxh0h4YJXo9btghUUP4EUJEXb/Z6WWZkazThrAid0WEoVK9
	tUc635PNBA73pySm0CgCas2V+vDNPTyg/QlmBbAD7kroRGh/HCBjaDJ+XGnQ+H0ELHVI+6e+me659
	5MpgQF9BbWU6ppfpBHYsMVM8AaMuaPrIXwZwUxVeibzDGv3LYIqQ8lkTcGEoyl8w9NjH2yOtLktvG
	JS6qPQCSWo7vFySlKo+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovK3D-004xsG-1U; Wed, 16 Nov 2022 15:10:07 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovK39-004xok-KA; Wed, 16 Nov 2022 15:10:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 39BABB81DB4;
	Wed, 16 Nov 2022 15:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DE5C433C1;
	Wed, 16 Nov 2022 15:09:55 +0000 (UTC)
Date: Wed, 16 Nov 2022 15:09:51 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v4 1/2] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
Message-ID: <Y3T9P7q8JgVV6Shq@arm.com>
References: <20221116121044.1690-1-thunder.leizhen@huawei.com>
 <20221116121044.1690-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116121044.1690-2-thunder.leizhen@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_071003_829122_AA57CFD2 
X-CRM114-Status: GOOD (  11.01  )
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

On Wed, Nov 16, 2022 at 08:10:43PM +0800, Zhen Lei wrote:
> Try to allocate at least 128 MiB low memory automatically for the case
> that crashkernel=,high is explicitly specified, while crashkenrel=,low
> is omitted. This allows users to focus more on the high memory
> requirements of their business rather than the low memory requirements
> of the crash kernel booting.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
