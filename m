Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CEB606A32D
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UUAwhRjK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvpqEnSe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bpN98SL1MCwWUh8dbQ9cdj1LeUak/IvNk2HcKSVXVCU=; b=UUAwhRjK2rYVLk4hFj2NnxtqgX
	VPA+ZPVclUezoC2hDVJNnAMDdn5bpUvtwdGmXuYQU93uBvuaK5borRflSte/dGZXnQ3WawQ63XYdA
	SGmzxmarjH9ioEMBoIAitZjLiS5dKxs4HY7+hkhDFH//Ar/PIv5aFBqZtBG6OyQ0hGA69qbitPs1w
	/k21HI5ezjBxWkpaC2Op23ABEekf0AU5tVuDrKBwG2xJC5Wt/rnf/lIzDhdLgF2ikHoA+UNpdBvzf
	p8dW4ceaqlzQ1uOpHYggmhrWTq+WjZpJfRr4/KZOvjQEnsd/Yu7duLS0KkcRDJuxyIm6bn67LF/jH
	Gx5o5L5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVs1x-00000006q46-1Wnp;
	Tue, 24 Nov 2026 15:02:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVs1w-00000006q3j-43CX
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 15:02:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 58932626E4;
	Tue, 24 Nov 2026 15:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46441F000C6;
	Tue, 24 Nov 2026 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795532519;
	bh=bpN98SL1MCwWUh8dbQ9cdj1LeUak/IvNk2HcKSVXVCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CvpqEnSeLHdFWrDFKh4NESXYRXxCNwsUxH1ZphnZjzzbCIqUtfW6dlKYZGajy8KQk
	 RfX6y0ZICxAhtoFbDmsWSn8mWAtDMJO5djVWCae7DM0njZOPcxAnbVRf7hwteiRjL6
	 v4WP+z2OLTf9dT8LohKTNHFGAvFEZF8vkxsqSiIJJO+IaBPVBwKat9UIi1tk7NgVww
	 fyMQZRSt/jhG0yxsupW2BsSVIR3ythnN1476qB+ZvbJJIUM0k40Hnb73E1h50dCuqG
	 UkfjY5pWlgVb0OQ3D7ZXZT6+h+hl4TRSnJ7AAAHBI9DtV0Uktm2+YeQUj5mBZEru+f
	 MEzhXdmMt1Jvw==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Alexander Graf <graf@amazon.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: Add missing files to KDUMP subsystem
In-Reply-To: <20261124-fix-kexec-kdump-maintainers-v1-2-79c6a6144de4@csail.mit.edu>
	(Srivatsa S. Bhat's message of "Tue, 24 Nov 2026 01:37:54 +0530")
References: <20261124-fix-kexec-kdump-maintainers-v1-0-79c6a6144de4@csail.mit.edu>
	<20261124-fix-kexec-kdump-maintainers-v1-2-79c6a6144de4@csail.mit.edu>
Date: Tue, 24 Nov 2026 15:01:56 +0000
Message-ID: <2vxzbj7ez317.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24 2026, Srivatsa S. Bhat (Microsoft) wrote:

> The KDUMP entry covers crash-reservation code and the vmcore interface,
> but omits the crash-reservation header and the vmcoreinfo implementation
> and header. It also omits the dedicated kexec/kdump and vmcoreinfo sysfs
> ABI documentation.
>
> Add these files to KDUMP so that scripts/get_maintainer.pl can recommend
> the subsystem maintainers and kexec mailing list for changes to them.
>
> Signed-off-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>

Thanks!

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

