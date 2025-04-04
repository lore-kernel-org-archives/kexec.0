Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41B4C3600C
	for <kexec@archiver.kernel.org>; Fri,  4 Apr 2025 02:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vqgQZ33wcq/hpv8n+1Ly9smcoDQEdPOPf9R8b9HYxu4=; b=d7e/OrnZIVUx0k1bmiFtHw5a8b
	nJ4nKGALcv7B9/laDHdoLl1teYFfyImh1ekueZ3w9jsqwpYguTXRCyhGbWiqfzIg2/qX2SrT1kPzv
	G1T3CVvntID2gqIVGK/XBqrpWdePidElaKqRtRmDuGykeFE+gSXeEFrqAmb3FaT8n8E85mVlqKS2G
	MdsCcvpKYHDpYJnUrYwz3MdfDv7IoZNjtsuUG1RycLrGu8bYd4y3pNwuwVmcbIiWsH1POUtIUDK1Y
	K7kHKzETfARTpsyjgVBtF/bD0lWswfUPobLtp9m6w/p5mOVwS7SNhZi2U1Yuh6elTD4Gum5unU+zZ
	LdFIlybg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0XCS-0000000AciS-2SIy;
	Fri, 04 Apr 2025 02:54:32 +0000
Received: from s1.g1.infrastructure.qtmlabs.xyz ([107.172.1.117])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0XCP-0000000Aci6-3mZT
	for kexec@lists.infradead.org;
	Fri, 04 Apr 2025 02:54:31 +0000
Message-ID: <691be719-7d4c-4cb1-87d6-cca7834547fe@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1743735263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqgQZ33wcq/hpv8n+1Ly9smcoDQEdPOPf9R8b9HYxu4=;
	b=YU3bBWRAz9g85BvWK1a7ViAWfYuYZn9JzeI14o9bsJF8Z0lDQ42Qfwd1o9TbrktO7M28C8
	6zVnmzA5A183utZkTS1dyP9rcvRhVjSo4bDTT3+spyroG2PgnXwdfVGlCjCp1VrPVCNfn6
	iKrgIB1hD35/HMnEZr8Xvi3q2IsDQeHZ2WfU0UldEqzGK+F8WN3A0g65EEOUJ5+7PhFPVP
	TdrxVVOk+cJDCuF+YqhZHlyQWAmCH9Ehh8lTA7OTr5/1Llv7R0v1phLKbGGbtiLpZvNlAv
	WHqcFRl33vxRUaEJ6AR5qzSs3zOW7rInO21s/J6pLGfal9OeJdagSDG0QDgVVw==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=msizanoen@qtmlabs.xyz
Date: Fri, 4 Apr 2025 09:54:16 +0700
MIME-Version: 1.0
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
To: Roberto Ricci <io@r-ricci.it>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
 ytcoode@gmail.com, kexec@lists.infradead.org, linux-pm@vger.kernel.org,
 akpm@linux-foundation.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <Z4WFjBVHpndct7br@desktop0a> <Z4WGSMdF6seQm9GV@desktop0a>
 <b9f6ed5a-74b9-47c0-b073-9922dbe6119b@qtmlabs.xyz>
 <Z-8E-LLs1dFWfn6J@desktop0a>
Content-Language: en-US
From: msizanoen <msizanoen@qtmlabs.xyz>
In-Reply-To: <Z-8E-LLs1dFWfn6J@desktop0a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_195430_109082_EEA407FE 
X-CRM114-Status: UNSURE (   6.93  )
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

Can you send the dmesg logs for this case (6.13 + mentioned patch series 
backported as target kernel, using kexec_load)?

On 4/4/25 05:00, Roberto Ricci wrote:
> On 2025-04-01 19:59 +0700, msizanoen wrote:
>> [snip]
>> It seems like `e820__register_nosave_regions` is erroneously marking some
>> kernel memory as nosave in the presence of sub-page e820 regions. In theory
>> backporting
>> https://lore.kernel.org/all/20250214090651.3331663-1-rppt@kernel.org/ should
>> be sufficient to avoid this but a fix for the actual root cause is
>> preferred.
> When using kexec_file_load, this patch series fixes the issue not only
> in theory but also in practice.
> But the issue with kexec_load (see
> https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
> ), which might be related, is not fixed.

