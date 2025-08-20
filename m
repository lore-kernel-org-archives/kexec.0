Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF7ACA0EDC
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=of0EpYZMc60tijt952hk19vL2Z+k8maUSxNdRLvEe+I=; b=F2D6TvIHjWbNB7+JR848cUUJ9y
	V3DvB5CqJH6auv9SW0AvZxsEdOIO7B0xID9ah2r984DQFqBT2LJJzfDH3iOxvS+L/cjzEMhYBEAVB
	OZTualDgFB5Dc8tf6xL15HLy/gcoqkpa3sNfljuTg6Ma79XXz3/zj2GCBCu6cEGBDypl7FPBpTkcf
	Ai5vIkoC6PdyD9cMOl4TBbaFOGczd+jVh0r2AyRpv36y9rhxSuskBK6DAhOHR0YqO1NXB5smnVar0
	yzITIqZLnViZByqJvBqvWAFvIAdFzc6DxPCRSgxly0R6IOz64VtRIenKFkYyo1+a89b0LXy/sYg0I
	q1/9XsgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoplN-0000000EtNU-3xw1;
	Wed, 20 Aug 2025 20:50:30 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uolXs-0000000ENSw-3Xwv
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 16:20:18 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id C1D7B1F83B;
	Wed, 20 Aug 2025 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755706813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of0EpYZMc60tijt952hk19vL2Z+k8maUSxNdRLvEe+I=;
	b=sXKhSfF60sU0oyczH2gIBe1RzsaWIYhAMs8FqjfzZB1781Z0mUmc3VTrLtBHyCQXhpIQbT
	dcYqBqdyktFou9LdN2fUP8+U7paXKyzkqKBLDU0cqU90JnlKAX+GOtOIRQWGpFMWONhV1U
	PTM2zJ6XBSO0FolyZTcXpMRT3C1KyEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755706813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of0EpYZMc60tijt952hk19vL2Z+k8maUSxNdRLvEe+I=;
	b=Fq4P9uoNy2MFtajWD5ryUxhCby68I3EkKpRKY0/jKmM3TEQ/6Znt+jZnyg2YdAhKRjHKiS
	ik6VcvZ6yBAHYTCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755706813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of0EpYZMc60tijt952hk19vL2Z+k8maUSxNdRLvEe+I=;
	b=sXKhSfF60sU0oyczH2gIBe1RzsaWIYhAMs8FqjfzZB1781Z0mUmc3VTrLtBHyCQXhpIQbT
	dcYqBqdyktFou9LdN2fUP8+U7paXKyzkqKBLDU0cqU90JnlKAX+GOtOIRQWGpFMWONhV1U
	PTM2zJ6XBSO0FolyZTcXpMRT3C1KyEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755706813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of0EpYZMc60tijt952hk19vL2Z+k8maUSxNdRLvEe+I=;
	b=Fq4P9uoNy2MFtajWD5ryUxhCby68I3EkKpRKY0/jKmM3TEQ/6Znt+jZnyg2YdAhKRjHKiS
	ik6VcvZ6yBAHYTCw==
Date: Wed, 20 Aug 2025 18:20:13 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Breno Leitao <leitao@debian.org>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aKX1vbE5jWVUr298@dwarf.suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <airxp44zdyxskfwrhhveis7gd2vsz5m4f3ipidsghi2x55h64c@s37v5rkuoega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <airxp44zdyxskfwrhhveis7gd2vsz5m4f3ipidsghi2x55h64c@s37v5rkuoega>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_092017_182345_78747478 
X-CRM114-Status: UNSURE (   7.63  )
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

Hi Breno,

On Wed, Aug 20, 2025 at 08:46:54AM -0700, Breno Leitao wrote:
> Hello Jiri,
> 
> First, thank you for making this change; it’s very helpful.
> I haven’t come across anything regarding arm64 support. Is this on
> anyone’s to-do list?

Yes, I plan to implement this at least for ppc64, arm64 and s390x,
hopefully in time for 6.18.

Regards,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


