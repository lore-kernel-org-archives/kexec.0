Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F5BC25B74
	for <kexec@archiver.kernel.org>; Fri, 24 May 2024 10:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gBldwHWmkR498ypcI4s3NGlddV8gjIfz99dqB6SWEyI=; b=nYqtTjsdiYS123
	3r1HNg8skDr7VJqIgze72Es48qcN6W2LbeJLvLappcirT4tEm30IGaS6HBEOzeHOyrG9z383864ZA
	7mGAAzVOEpgiXthD0TzUiES6KUojxgaf7thgS9xNLTNtw7sXVr9nLvG6L+zGnO9l16zGv/121zacH
	m3UFQNYktjtMjAyNsogALdJmfJ+9pUwNM3YoZhOD4lgOrq3iCyOu7CQFRMlDELR8G7fevp2TCjwir
	2zRALpXUjWOHwxfBcXODRRQr3lSv/Uuruo3/S+5cIRzmOQ5hP4EuTFXeNEzpn2z5LQ30ZY1eqipI5
	LCie+o4dpk9tb/zRXpkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sARxy-00000008e0u-30YW;
	Fri, 24 May 2024 10:16:02 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sARxt-00000008dzr-0BSG
	for kexec@lists.infradead.org;
	Fri, 24 May 2024 10:15:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1BE82CE1802;
	Fri, 24 May 2024 10:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD570C2BBFC;
	Fri, 24 May 2024 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716545750;
	bh=R5rYHQb1TAG58PbBXJgHJ+ttcFuaB23hec7lYtqwcMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIZ1OUEcDUHvmaS+RVIUyOCw/IBlOk/zRR5YB66EvWu45ufo84U1EvZznCiaRAVZf
	 3BeuhBX6I0HG1yYzKFQOxD6CgJhCyuI1Glg6DNYsWpF1N0VITNFcW0uP3vxTbvZCiZ
	 YdJiefejjI9QmHZQ4xp8g9V8wcpS2bKFX/in52JM=
Date: Fri, 24 May 2024 12:15:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <2024052420-clang-flatterer-366b@gregkh>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
 <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_031557_306561_906EE5DB 
X-CRM114-Status: GOOD (  13.30  )
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

On Fri, May 24, 2024 at 12:02:10PM +0200, Jiri Bohac wrote:
> On Tue, May 21, 2024 at 05:31:59PM +0200, Greg Kroah-Hartman wrote:
> > kernel: kexec: copy user-array safely
> > 
> > Currently, there is no overflow-check with memdup_user().
> 
> This is false. 
> Therefore, I'd like to dispute this CVE.
> 
> The overflow check is in the kexec_load_check()
> function called shortly before the memdup_user() call:
> 
> 
> 	SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
> 			struct kexec_segment __user *, segments, unsigned long, flags)
> 	{
> 		result = kexec_load_check(nr_segments, flags);
> 		if (result)
> 			return result;
> 	...
> 		ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
> 	...
> 	}
> 
> 	#define KEXEC_SEGMENT_MAX 16
> 	static inline int kexec_load_check(unsigned long nr_segments,
> 					   unsigned long flags)
> 	{
> 	...
> 		if (nr_segments > KEXEC_SEGMENT_MAX)
> 			return -EINVAL;
> 	}

Nice, but then why was this commit worded this way?  Now we check twice?
Double safe?  Should it be reverted?

I'll go revoke this, thanks for the review!

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
