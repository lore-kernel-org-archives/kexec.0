Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96796CD37B5
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 11:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b3jDWeFYJ1RQc2SiIxMoyibpKT8QV19rCafUv4Y8bAE=; b=G07A8S4Yqf7L0+de9q9wzorrIx
	QK0uLMsMOuLlTMkcjW/Tu7dIK476UgpdvrXh3ZuQz4zE0GdcA/Ru6/wiIjNklWQZ0yoeLR2Rz66+n
	WbXEu5KE4S3XaCymeiBAYEffRFCRx7/HihdoGBA74AElnMRD0jvt7IVxYmTgPMATVFSA43WvoVsWz
	SawQlFUP32OYjbr6vrpkb9fNz0S25CCMlzHF3RVj95yK9q2SXuqKQdIhlzq1Y0eZNcTAlMQrGGwlK
	aDfp+4Py5s+W7KTK/LRMVJ51dcXc6x6rI885RE5Cn6BJN+gG6Ji0/p82S7Nl3OV5KYz2N86DM8Q4B
	FBE5Rjyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOQI-0000000DDYB-2IY7;
	Mon, 11 May 2026 11:03:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOQF-0000000DDXB-3Y6t
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 11:03:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D282F4195C;
	Mon, 11 May 2026 11:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9F3C2BCC9;
	Mon, 11 May 2026 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778497418;
	bh=TSs/vN70p0uwNlsWNWNw+qqsmsV+31QSlkIJ+FyA3Sk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aJNb3rG9eLyETc+c7dCYcxs8r8eBXcRmz0vVg8vuKZW2GoHqqFbVgBbrVrjq9Dysp
	 WTN60mY3CklTkxWRllzkM7NyNddnqX0/Gbk76qbzyp8wTw6rWxy+W9pGwrqyNJQ7Jg
	 tCYkIkvGdY83GQvSDv4miLSw7Aicx8OR2sy0Vo2GQIwntQXfT9n7YyhnZr2ECabXTs
	 ZTyOI7GATKJNiaOtKWAk4JH1C8JvH3iusGCdCP7yPGxxOhaO/c1q0+4hm2DsPJoGGT
	 B/UTvqYPlB1eCwgQ5D7QlRL4dWvxb6jGXRe4b6V7Wwv3UgBlPriRN2fX+5nm4PsXUS
	 mwrDtr4syMDGg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org,  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  linux-mm@kvack.org,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  graf@amazon.com,
  changyuanl@google.com,  mario.limonciello@amd.com
Subject: Re: [PATCH v2 3/3] liveupdate: block outgoing session mutations
In-Reply-To: <20260506182039.2623553-8-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Wed, 6 May 2026 14:20:43 -0400")
References: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
	<20260506182039.2623553-8-pasha.tatashin@soleen.com>
Date: Mon, 11 May 2026 13:03:34 +0200
Message-ID: <2vxzv7cucint.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_040340_044191_FCD6C7EE 
X-CRM114-Status: UNSURE (   9.13  )
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

On Wed, May 06 2026, Pasha Tatashin wrote:

> During the reboot() syscall, user processes may still be running
> concurrently and attempting to mutate sessions (e.g., adding files or
> closing sessions). To prevent this, hold the session header's rwsem and
> each session's mutex indefinitely on successful serialization.
>
> If serialization succeeds, these locks will never be released as the
> system transitions to the new kernel, effectively blocking any
> concurrent task attempting to modify or release a session. If
> liveupdate_reboot() fails, the locks are released in the error path,
> allowing normal operation to resume.
>
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

