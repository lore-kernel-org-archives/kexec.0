Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DFDC433FE
	for <kexec@archiver.kernel.org>; Wed, 16 Nov 2022 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M0UQUruIcYbDchU8kY6USCfuykdlYlmpI0/B727Ov/4=; b=tx7wssOyWik8up
	6vcYYwTdePYUQptkRxVHMLm5Zps5Lp8sgqNNFfcmnsMiD3m59F1tujqKNexTVIsY9FbINFkYaLIZf
	18RxZYyOc7rJmBsFJuKjX65dzJ2zpRxhyWn10SCeOXdobVzw/WVIVypYelieeo9/bQeKGnVr0VZWd
	wGF8nY9z9fPGy9NSB7whEe1IlV+L8c7wiTBbEwyxraH567wloEpHZvDcAjNWqRUgNh7pHiYtpjywu
	zUGxxos8aertTH2pH69/BfsVMN8h0b1qpU/U2mosEJ+0jch35kNnicGID4uY1ZZEhp6pIa/DcSGBB
	jsc8uurGzMAu0iLGe5aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovK3w-004yKx-Gu; Wed, 16 Nov 2022 15:10:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovK3s-004yIN-V9; Wed, 16 Nov 2022 15:10:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 17B4E61E7A;
	Wed, 16 Nov 2022 15:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16917C433C1;
	Wed, 16 Nov 2022 15:10:41 +0000 (UTC)
Date: Wed, 16 Nov 2022 15:10:36 +0000
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
Subject: Re: [PATCH v4 2/2] arm64: kdump: Support crashkernel=X fall back to
 reserve region above DMA zones
Message-ID: <Y3T9bPbX3V9TYlKQ@arm.com>
References: <20221116121044.1690-1-thunder.leizhen@huawei.com>
 <20221116121044.1690-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116121044.1690-3-thunder.leizhen@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_071049_094187_827E1F81 
X-CRM114-Status: GOOD (  10.02  )
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

On Wed, Nov 16, 2022 at 08:10:44PM +0800, Zhen Lei wrote:
> For crashkernel=X without '@offset', select a region within DMA zones
> first, and fall back to reserve region above DMA zones. This allows
> users to use the same configuration on multiple platforms.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
