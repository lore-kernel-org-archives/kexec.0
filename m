Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BAFCD4F47
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qSvR3pUa7/2OkCu/xeQoYakjb0Jx3U+q13XWt8GPix0=; b=wtTvBtEv8mmfOTyI8y8Rj7LTuS
	zBiLL1194eDxYAaWA6bEwdNeVCm514HW7BZUBBH1dqjujPf1375jrE0GsIa/pvucKIAJPU0wB01pQ
	7tEUDe0eahRawgR3gLcgtpeEVogqkQVf5kYW8BCKW9Vc53fCld/3Gb1wwo/g5km0xs3OzCSzcV4Dh
	J9e6is6S3Wwm6zNvWD3WuOhnczBEytK//Dgz5m9Nm2R5H3aV8F37C3EB4hWua9yhVOImGYOdi227k
	GdmI9H7uo6Q5tlQNWUQBfya+pQC0wuwyLGDwAsLlbm9SvwcjOzUvESp4Rb4BjguvhfdZi3r6Evs8M
	JTm1El1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOgMd-0000000DFA9-0iic;
	Sun, 17 May 2026 18:37:23 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOgMa-0000000DF94-3mG4
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 18:37:22 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-910f734b477so210913985a.0
        for <kexec@lists.infradead.org>; Sun, 17 May 2026 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779043039; x=1779647839; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSvR3pUa7/2OkCu/xeQoYakjb0Jx3U+q13XWt8GPix0=;
        b=HLgGS/3G6ZjiKpSkMU0IpSqgnTJ82IE+iym7U0q2B+G0ri/24Ot3Q0HCXZ7Tkaw1Qe
         gDENJ6V2TzWQT2w2v4C+lvLyB5M3vpYr2MQz0pHjCTTSsO0mZQC/POM/LXQv7TO9qIvT
         trx2lrVGndtMjlO9RGxq7mMtAxGH9pqVhjMbs08d8wzVVZZNjyGF3G7OSe1SgdMkS8j3
         /Ht2oYJW4M6Wlssxi2IhKPTHe45ae8SmGluL+naWBEsLSezz+awhZG8MdFYcH529hGB4
         E0WyU3ukMCrxg0lSdBhpZNMzFwls7xwrdRJDSJaa0BQD54Rhghk4FmH16gu6SC9DyH5Z
         nBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779043039; x=1779647839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSvR3pUa7/2OkCu/xeQoYakjb0Jx3U+q13XWt8GPix0=;
        b=hE4vRdz0xVGBCrB1H+bu0AGefeCvZzs3jbtpn36iM+hVinzzF2PEGvdPfJMaN0toxT
         vkv8Vpse/ZfJIFfpUa4gwySF4HHV7EK+Csvha107oAsAxfovDwaa27cZgiikd3E1Xrx9
         4Z9QNNGRuYW2DMztxVbkUsvA8coFDByV1u5nD+VwvCT9/Tw/0dWi5033qhtIlCNIlp3r
         PPGQdoPHxxAhDKKWEFqDgfvoh83Jya9w/syKcRI7p+1aHV/S42atkTfWCbk9LBJHpVw/
         1XlOSugg5ZragmAtrT6gfse3xuRYFU+zjvih9KDIOd0cLKZokc6GFPxtQpjTMrpZrZiI
         KzRg==
X-Forwarded-Encrypted: i=1; AFNElJ+zW8KElM5i2IVut8MYvz/iLOQIRz1CtbZnjbudPcmNKnTUJBLkQNblRZnAK5P0sofX7XfikQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzWujxp63I06Me2KjbW9Mhbr+sfZlYyysY7+nq2OL3w0taeVIwm
	w3PjNZt9fkTffRnFnDj3GaUCnKzcx3JRWBXJfSGOAqzjJB9dboq0sw1M+LHAxNJzKvY=
X-Gm-Gg: Acq92OGe43xXKq50d+gHJD2SojkeZqLoCQMdzFquRJCuv80RP9ffV1Vya5DDSxX6yQ1
	hQSi4P74tuHY2opn/oEa8/RI43JdoegwPzrieSoBAhLbAcRgYU3kgJMyNrfcSi9mtMPonZI3riR
	JkSd+z/pDzsiL7KUGFwSC160+/7eSoIHQZzahuYSdcshwZ8LGiY2r4QzvixrrkVVWGvmGQbcmeP
	KAlxsnHy3mRUAQMIZ9lFpnSYKYHkrjjsZYYI/5xMMcPykQ7bfMQG9OFL0hbL48nU2O819XmhXMn
	W2pJZYyS9F5QPk/ps4w+xgSQMxQ6mYswkM82WGdALYq1jUA1HDEav1QuoXxoCApkEIQcfGUxsyw
	7qJu6U6rqLizB85mxwCG/32Q22CjTRg7ftjiFPzkzzFrSmA/91n/Pe35KJNl5v7A7P8+7vGcFTE
	K5pGB7GGE8oU4+4ZEZyY3ZkKBFOt57u/cZwg05KvKtW2QeUspaTZM=
X-Received: by 2002:a05:620a:258d:b0:8cf:c513:349c with SMTP id af79cd13be357-911cdd431f7mr1842710185a.9.1779043039579;
        Sun, 17 May 2026 11:37:19 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e1acsm1238613585a.3.2026.05.17.11.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:37:19 -0700 (PDT)
Date: Sun, 17 May 2026 18:37:18 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v2 02/10] liveupdate: Extract luo_file_deserialize_one
 helper
Message-ID: <agoKzw8mR21K7cCJ@plex>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-3-pasha.tatashin@soleen.com>
 <agn50TRvhDpGm_9v@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agn50TRvhDpGm_9v@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_113720_944087_93C80684 
X-CRM114-Status: GOOD (  13.57  )
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

On 05-17 20:24, Mike Rapoport wrote:
> On Thu, May 14, 2026 at 10:26:20PM +0000, Pasha Tatashin wrote:
> > Extract the logic for deserializing single entries for files into
> > separate helper functions. In preparation to a linked-block
> > serialization for files.
> 
> It would be nice to mention that this is a pure code movement without
> indented changes.

OK, will do that if there is another spin.

>  
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/luo_file.c | 77 ++++++++++++++++++++----------------
> >  1 file changed, 44 insertions(+), 33 deletions(-)
> 
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> -- 
> Sincerely yours,
> Mike.

