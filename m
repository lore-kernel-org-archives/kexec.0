Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD1CC4332F
	for <kexec@archiver.kernel.org>; Tue, 15 Nov 2022 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d7b3TzMSYqOcEeH9p/hkqaGty6s2sfGRPlTr98ZIG48=; b=iVCwINQ+EkxxB7
	NUV5v3fdKnSXm70C1ylpr9WjAEXp/3hszBf8xKvFq36JaSu1AFqE4aS2F8RKtP4TtgJzlmacCcunY
	t2veIiFXpleUrt2KhPC7M95vihVk847m8oBg/7wq7q8ZBxhZiFOsHi4DS9Pv9BaOc1rwSdcpIhguz
	UrcyR2Z8pFgyGni7UlVfTp1JNfgYoE3KXwzYmvU1KAK8Wf4fPNjkOiKuSrgJDQEqQ1rGSnYB5PbG9
	8iKsQT+ZP35Qxh/nF1BViq5mFks2VrEAfwDtb+/nJA+tVFP4HZei7s9nOLEDY2K3a2Vpi2eS/Fvec
	j9OAmmeTNPx0Z0L1ggEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouubR-00AmHl-DD; Tue, 15 Nov 2022 11:59:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouuaU-00Am4k-AF; Tue, 15 Nov 2022 11:58:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A0F64616DD;
	Tue, 15 Nov 2022 11:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1476AC433D6;
	Tue, 15 Nov 2022 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668513525;
	bh=v7WQwVwUrmsME8ycelaHX9JZWXOub138m3ehvZfVnW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tE8J2hmdAW5zvK1kAOaeYoesuixtZPOIdomObZYKaTefyMR/hydRm4BlGwc56roLJ
	 /u7KoTeA+18aoBMrZxe+RGf0l92p73zBs4mONKVLWwoDDn0gOnXBxwXf9r5X1cluCx
	 /N3sDQO9LjwFypL81BFALJmDECtmzdMpo2/AzzpBERPXh1HUEHnMOG7iu2n9O8VgUy
	 zfIOXnW3c8kBFWjsNfmfMHYzTqavbwm4o7Lw5US9wnLwfAOoLyhc3RMPt6hKOJz+ZZ
	 abYTh+CIdGkouoYhp+nGMrzVlwNkQvDnnnMs8mAZDnc4oZfbxUPA+bcoOoUuhYpcqe
	 5dMZdRNJKOFZg==
Date: Tue, 15 Nov 2022 11:58:38 +0000
From: Will Deacon <will@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
Message-ID: <20221115115837.GE32523@willie-the-truck>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220711090319.1604-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_035846_424068_C56B6972 
X-CRM114-Status: UNSURE (   9.47  )
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

On Mon, Jul 11, 2022 at 05:03:17PM +0800, Zhen Lei wrote:
> v2 --> v3:
> 1. Discard patch 3 in v2, a cleanup patch.

Do you plan to respin this series, addressing the various comments on v3?

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
