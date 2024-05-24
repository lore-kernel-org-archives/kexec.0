Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347DBC25B79
	for <kexec@archiver.kernel.org>; Fri, 24 May 2024 10:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kqtrcHKlFypKbiuXh0Km1FiBeLAytZsfS8nr4CoX25M=; b=rDhZshIVVTmRvZ
	7f92vhJK0LBSEhQ4JBH7RkQ6jJmA0JQ7Rt8w5UEdhuVXLMT5nfmEnzHf5rqBp3gokfOE2y0YQvzh/
	XjBZ/ERUly5SX5kc34NwXvUUbA1EsE7hY7/ynRwq0yO45zMXL4AbA8FBnGJAU5dn6oFeWvGO0p5jU
	JC/2tbtz4fkwA6TqQ1SIKUW4SERWXt4n0ooO01uULhLXNnNAktzVeOh5tJUX6x2YR4IhE9wdTs9mu
	KscZ7AMTyADgHBQnOY+9WrzfsY3burutP8AIhbvJKoAzRn5gzsKQfVtJcunbRt1G456lhpfQjXikw
	hlTrUEAPLRHXgRzJhLqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sARkg-00000008cpa-3c6k;
	Fri, 24 May 2024 10:02:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sARkc-00000008cox-1Fw7
	for kexec@lists.infradead.org;
	Fri, 24 May 2024 10:02:17 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3686D339FD;
	Fri, 24 May 2024 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716544930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/OEvrzWeGwb1dUHEq64+dHG7ZwZd+5GEDO1Ba+pFW4=;
	b=XhRmepdGTrrFnqxO+ClvvJHopazd1ctZTY8rYZEh7ZSjX3gtbirDqMCdhsffm3L2f2IbRo
	5nLL/RiI/xU3qYdsnvPwOIS5xfSElPEUHP6SQhBiKdgxpOfSBWQHXPZOLvRtWMmX0s6Ink
	2TbcJeOeXMaJMy3cohOlYyOgAn22wRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716544930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/OEvrzWeGwb1dUHEq64+dHG7ZwZd+5GEDO1Ba+pFW4=;
	b=Mm108XQmAJJG6HE75E4M537VgfCYxaPopdC2tzOKUEioGzeAIg5vJg/J2em9jrR1aKmFO8
	V55JzhDyP4Ks1oAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716544930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/OEvrzWeGwb1dUHEq64+dHG7ZwZd+5GEDO1Ba+pFW4=;
	b=XhRmepdGTrrFnqxO+ClvvJHopazd1ctZTY8rYZEh7ZSjX3gtbirDqMCdhsffm3L2f2IbRo
	5nLL/RiI/xU3qYdsnvPwOIS5xfSElPEUHP6SQhBiKdgxpOfSBWQHXPZOLvRtWMmX0s6Ink
	2TbcJeOeXMaJMy3cohOlYyOgAn22wRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716544930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/OEvrzWeGwb1dUHEq64+dHG7ZwZd+5GEDO1Ba+pFW4=;
	b=Mm108XQmAJJG6HE75E4M537VgfCYxaPopdC2tzOKUEioGzeAIg5vJg/J2em9jrR1aKmFO8
	V55JzhDyP4Ks1oAQ==
Date: Fri, 24 May 2024 12:02:10 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2024052106-CVE-2023-52823-3d81@gregkh>
X-Spamd-Result: default: False [-3.47 / 50.00];
	BAYES_HAM(-2.17)[96.01%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
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
X-CRM114-CacheID: sfid-20240524_030214_510199_1FF02E50 
X-CRM114-Status: UNSURE (   8.06  )
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

On Tue, May 21, 2024 at 05:31:59PM +0200, Greg Kroah-Hartman wrote:
> kernel: kexec: copy user-array safely
> 
> Currently, there is no overflow-check with memdup_user().

This is false. 
Therefore, I'd like to dispute this CVE.

The overflow check is in the kexec_load_check()
function called shortly before the memdup_user() call:


	SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
			struct kexec_segment __user *, segments, unsigned long, flags)
	{
		result = kexec_load_check(nr_segments, flags);
		if (result)
			return result;
	...
		ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
	...
	}

	#define KEXEC_SEGMENT_MAX 16
	static inline int kexec_load_check(unsigned long nr_segments,
					   unsigned long flags)
	{
	...
		if (nr_segments > KEXEC_SEGMENT_MAX)
			return -EINVAL;
	}



Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
