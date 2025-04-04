Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9666EC36010
	for <kexec@archiver.kernel.org>; Fri,  4 Apr 2025 23:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GI8K8fXDBCh2FPVk7FuAjB9WmhRKTpeT98nexJxBQqw=; b=v0JmVekB5B/m3vwwYhNDz6jM2W
	2j75GmuemmO8mKmdfHrp+BeKOwWgayGaullXxHZBqL2xLH6WIcmBsgPU3XkWaAezBkkKkGFz03Lyy
	7/JfpePDb/zUjVf5ZJ/Mq65qCrs+/X1dPGEdhUweVuAmWsWHtm5PbxFrY4XC14LaJZ0FlFRo7R5zn
	TChu9quGVj4PFhu5uVtoY6g53HVbDphJn+vCD6qmuIpd0nx+I8vGaEXTHTrwTwO97UrtuvBueqHAN
	zyD53Eyc6InVJMVTpADfs1h5NCreKrYpsREC3wl0EQzDb4vALkUGJ3C7OkuFQp4hb6Ca+/bUMJLPX
	IkSetTdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0qbD-0000000D69o-3GtK;
	Fri, 04 Apr 2025 23:37:23 +0000
Received: from out-171.mta0.migadu.com ([91.218.175.171])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0qbA-0000000D690-2Mht
	for kexec@lists.infradead.org;
	Fri, 04 Apr 2025 23:37:22 +0000
Date: Sat, 5 Apr 2025 01:37:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743809837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GI8K8fXDBCh2FPVk7FuAjB9WmhRKTpeT98nexJxBQqw=;
	b=uNXGvnNdzQlXu9Jvln8BKbLoHI2I6EhtvGmXw39XHygcZbI1Ph6xc8LOngN7VwUnmel0iK
	198ALO/ZF31C4Cw2P6/mehcV3hvLRmeXxWyoiYVn952yt1IcKpqTi7oO2FEZjeV22nEjRB
	8rsAbQvNzfdC48WScsCSgjKqAa0FfC0qDkldZTFvyBqKoCVVuNaunnck/GW28gwgr4sHGL
	L3OcEDfyd07EY1cQxRKSNXSFwHupvyuojSVyDGuvxBevPjBuwvddjBr6bW+T1sxktlLIz+
	VxvkkfCiFGEoC7wBBMf8uV6kJ3/cakERzlPY7xemL+/OCfmE45dXCpDMy7DJGg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, ebiederm@xmission.com,
	rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, msizanoen@qtmlabs.xyz,
	rafael.j.wysocki@intel.com, yu.c.chen@intel.com
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z_BtK43rKhxw28l4@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
 <Z-c7V2hptt9U9UCl@desktop0a>
 <Z+dQZozsbdls6yqJ@MiWiFi-R3L-srv>
 <Z-hYWc9LtBU1Yhtg@desktop0a>
 <Z_Bry0JcB1jqPztR@desktop0a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_Bry0JcB1jqPztR@desktop0a>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_163720_747705_58D611CB 
X-CRM114-Status: UNSURE (   5.14  )
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

On 2025-04-05 01:31 +0200, Roberto Ricci wrote:
> I've bisected this other bug with kexec_load. I found commit
> 62a03defeabd PM / hibernate: Verify the consistent of e820 memory map by md5 digest
> Reverting it on v6.14 fixes kexec_load, but not kexec_file_load.
> Also applying the patch suggested by msizanoen fixes kexec_file_load, too:
> https://lore.kernel.org/all/Z_BDbwmFV6wxDPV1@desktop0a/

I mean, doing both things fixes both bugs. The second thing fixes
kexec_file_load only.

