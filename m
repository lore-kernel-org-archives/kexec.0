Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7641C3601A
	for <kexec@archiver.kernel.org>; Thu,  3 Apr 2025 21:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5gWVPsaMeVoq3PEOblosd8Uc4uwzdadJ+Lx1YrHoDlQ=; b=y9cjmNbR9VlijiG270Gj9s820s
	tbKyxMYeDUqPj/BWutVr6QIznVAYuhGm/SRZgMa7ezyFCPAirMEHdxTJZ3ms1k4OrMTRM27mEYi9Q
	pajfrZzN0iycSo/hYb8pm8MGz8ohunDZfpAf+4dyog1Nru6p8kJFZejCRp6+3HYtqXX/4w4G7JDil
	k56Y6JNfZYeKxzbfGyWnG1YopKdlIwwV/CKiBER9mTaehQ8SpSQ9ibiAtx8tvB4e/phjqy3hDzR79
	qfc4Udmr+zE6ycDg6imp1f+5313BeJaxA2iZwPxFAY7PHKEjIa5cJTjUtE3Z+LiAsoUJe3fS+asAU
	IWi4ad9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0SbC-0000000AEcL-2GLG;
	Thu, 03 Apr 2025 21:59:46 +0000
Received: from out-177.mta1.migadu.com ([95.215.58.177])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Sb9-0000000AEZP-12jU
	for kexec@lists.infradead.org;
	Thu, 03 Apr 2025 21:59:45 +0000
Date: Thu, 3 Apr 2025 23:59:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743717579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5gWVPsaMeVoq3PEOblosd8Uc4uwzdadJ+Lx1YrHoDlQ=;
	b=heCR0QTKCfdNHBAd6RcJd7HR4EPXeNDV86iCUlXot0NbT94u9r7zuNR/T4a7O00k1+WKqo
	oRtCLMfj6x4eFUN86Pp2l2dQI+XpAgksb32jVziMbcvmXk3YMgG8YsZgHyKudc4zLuR8JK
	H9IoEon6Qp+mN5MbkcVpCyUrO9TWmj9xLhwqZCEkreb3gTKlp6YCDlwJv3fLabnBg7ejTo
	5EB4aJlzOX4yLv0CZzwVNnpdSfYdEU0R1f5CGIODXTQFDHz4MU55sF3an9Md9tpXB8wCnh
	gAjT52jzelVE83+Boqtxp9hTFRkrp7Mmx3+RCuybMq74qOYcIoXPNu3xrJ+p2Q==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, ebiederm@xmission.com, rafael@kernel.org,
	pavel@ucw.cz, ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z-8EwQksGi36v-QQ@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
 <Z-c7V2hptt9U9UCl@desktop0a>
 <Z+dQZozsbdls6yqJ@MiWiFi-R3L-srv>
 <Z-hYWc9LtBU1Yhtg@desktop0a>
 <CALu+AoTrPZS7ukuLsCTCwKNKVd8=PUN8nXwh9BdicyV-==-W=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoTrPZS7ukuLsCTCwKNKVd8=PUN8nXwh9BdicyV-==-W=g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_145943_924639_FB5B318F 
X-CRM114-Status: GOOD (  10.85  )
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

On 2025-03-31 11:22 +0800, Dave Young wrote:
> > With v4.9.337, kexec (via kexec_load) + hibernation works.
> > With v5.4.291 it doesn't.
> > I'm not sure how bisection could be done in this case.

I just found out that 5.0 is not what comes after 4.9 [facepalm].
With v4.14.336 kexec_load + hibernation doesn't work either.
I'm still having a bit of trouble finding the commits which fixed
various build and boot issues and cherry-picking them. But now at least
I have fewer bisection steps.

> Not confident, but maybe you can try latest mainline kernel see if the
> below commit helps:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2498e5c453b3d8d054d77751487cd593332f8c2
> 
> I noticed the e820 export is different for v4.9.337 and v5.4.291

Unfortunately, this commit doesn't fix my issue. Latest mainline works
when using kexec_file_load (but not kexec_load) because it contains
https://lore.kernel.org/all/20250214090651.3331663-1-rppt@kernel.org/

