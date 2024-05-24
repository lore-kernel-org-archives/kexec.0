Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AFBC25B74
	for <kexec@archiver.kernel.org>; Fri, 24 May 2024 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QX1rTXqDzUVT9SjvKnmzghOVyyHtJOAOw5HcQS7ZXB4=; b=12iLX2ZzbDSYNr
	dUahO1e8ZOye3CyQSq1/GeEs8vHW1htc7WmBZqh8Oo/twewfzhM9olVO+hERoxo5MshLuywt14j7r
	8L1P78jaAtC89kKDhSY+/h32E/GTkoAK+/bZPnLjp6m2zwhkgY0kzCx4BttlvTM5887rlt28UeLSh
	bUMaxjOepGOroaao3QI3TB/GuJ8xoaUWlqFkMJsvqpAZH3NThEKtYZosVf9Q6m3CbqSvAcTPaqthH
	kk4wYIgOZCXCf2BQ91o004hZCP7BcOFCbzT9sXaO+riZ/TS/ml6oyDzoNGg6nBlGMrreZ+ClRRchh
	zO9cqp0VCaRJTKKAvEUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAVgJ-000000095Ke-3Da5;
	Fri, 24 May 2024 14:14:03 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAVgF-000000095Ir-1URa
	for kexec@lists.infradead.org;
	Fri, 24 May 2024 14:14:02 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id ABBFA20A94;
	Fri, 24 May 2024 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716560033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENZk+YNrymrvrrD0I2MRl9n2PBLEnhCmMDbUSSQHsE=;
	b=hoCB6JU9XprYJdvuL8+l1iNbmT1ZYa1Rl5VRmYqZ0oS1KNS1EC1IJ8wJp1vSO/hvRptPz1
	S8EAzBSwXldgUqjrxj2QsbMl+eH0jp4MpyO53psZ0R2dXFuWThK9150jb9vDZrOhzM900H
	y9pH3EfD64HQ1lTur4u3nsgb7GzEZmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716560033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENZk+YNrymrvrrD0I2MRl9n2PBLEnhCmMDbUSSQHsE=;
	b=Au2a7eBmvLDVIBcZVVGbc+XGLHrRaIQIPCMaePnoTad5afSIwUqsgcrg/2VSin5J71GR9h
	PDXEX3hEV9NkHWBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716560033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENZk+YNrymrvrrD0I2MRl9n2PBLEnhCmMDbUSSQHsE=;
	b=hoCB6JU9XprYJdvuL8+l1iNbmT1ZYa1Rl5VRmYqZ0oS1KNS1EC1IJ8wJp1vSO/hvRptPz1
	S8EAzBSwXldgUqjrxj2QsbMl+eH0jp4MpyO53psZ0R2dXFuWThK9150jb9vDZrOhzM900H
	y9pH3EfD64HQ1lTur4u3nsgb7GzEZmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716560033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENZk+YNrymrvrrD0I2MRl9n2PBLEnhCmMDbUSSQHsE=;
	b=Au2a7eBmvLDVIBcZVVGbc+XGLHrRaIQIPCMaePnoTad5afSIwUqsgcrg/2VSin5J71GR9h
	PDXEX3hEV9NkHWBg==
Date: Fri, 24 May 2024 16:13:53 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <ZlCgoTr27AT_eg9A@dwarf.suse.cz>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
 <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
 <2024052420-clang-flatterer-366b@gregkh>
 <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_071359_565126_FD664772 
X-CRM114-Status: UNSURE (   8.93  )
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

On Fri, May 24, 2024 at 02:38:04PM +0200, Jiri Bohac wrote:
> On Fri, May 24, 2024 at 12:15:47PM +0200, Greg Kroah-Hartman wrote:
> > Nice, but then why was this commit worded this way?  Now we check twice?
> > Double safe?  Should it be reverted?
> 
> double safe's good; turning it into a CVE not so much :(
> CVE-2023-52822, CVE-2023-52824 and CVE-2023-52820, originally from the same patch
> series, seem to be the exact same case.

Same thing: CVE-2023-52758


-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
