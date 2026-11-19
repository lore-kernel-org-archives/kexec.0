Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046E60A2600
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Hy4DZMJ/;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvmSX7Hc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2iQ0+2zXaYo8rBW1GuAj8YJKBX93rhlTN+lHKRkNO2k=; b=Hy4DZMJ/A4vVyLp8vf7recxqpO
	nLIVJYhI3895u6ImvTNSvFjIolhspfQ7s+aDCWvYSs2iYnsdKnKTzMbFtta0r08YR7wc/viP5BhH+
	zQ+CbrV0kEDPyeuAjxfkKgNo1cG/EjwuY+megwdymc2d+LSVSS2ND9Js4rNEWKg23+3Q7McMWIBK+
	iEqbxQFbVT/Sz2goCwEGT7GZY3e0tdkDmO+rEnEafwSU7VOEWyoYhtpYdyolt1fjZp95KO8VBQFey
	6DRmFXge6Xnx/InHIg1cn7PQC0bhjoaSvMwQYiWqqLp3v4s3shtVEwqYzz2xe5h+VPxXPrk1YA6MT
	x7au11Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU727-0000000D21l-2POX;
	Thu, 19 Nov 2026 18:38:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU726-0000000D21X-0TEZ
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 18:38:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5865A60F74;
	Thu, 19 Nov 2026 18:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CDE1F000C5;
	Thu, 19 Nov 2026 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795113533;
	bh=2iQ0+2zXaYo8rBW1GuAj8YJKBX93rhlTN+lHKRkNO2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OvmSX7HcrPPojaHOsd8NleIm2QS/jlCNMIe69IhvmdlCp3xKGXevQNai3c5PWEhxP
	 kIaL8l3fUXCeUiH0LNCQ+X6kZwm5F3Dpc2i/PMstTdqP/nukUfU0b85PvAMxwF0LI2
	 heLb7Igind9TbtSXW+JFsUQswMaxQaFrf632hY2qIp07pZS7QEa9wlDGpb/24a/qnw
	 DU9iWW/loeye7T2UAzXxuqLow/iuGATHu1vfCouJLbrzX7fVu8aT+AsQoZabwkYUxj
	 Ui24b2/nklqI0U2yGVklRIgdVEwDdoqd/PYq/9l2I2QlHTnZdVQeWcEZDXxKwbCTYW
	 5hT5R8giR7ceg==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Christian Brauner <brauner@kernel.org>,  David Hildenbrand
 <david@kernel.org>,  Hugh Dickins <hughd@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Michal Hocko <mhocko@suse.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  Randy Dunlap <rdunlap@infradead.org>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Suren Baghdasaryan <surenb@google.com>,
  Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v4 04/19] liveupdate: Allow file handlers to mark
 retrieve failures as retryable
In-Reply-To: <20261111002358.1842967-5-dmatlack@google.com> (David Matlack's
	message of "Wed, 11 Nov 2026 00:23:42 +0000")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-5-dmatlack@google.com>
Date: Thu, 19 Nov 2026 18:38:47 +0000
Message-ID: <2vxzmrr43buw.fsf@kernel.org>
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

On Wed, Nov 11 2026, David Matlack wrote:

> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Add a retryable output flag to struct liveupdate_file_op_args, which a
> handler's .retrieve() can set on error to tell LUO that it hasn't
> consumed the preserved state. LUO then lets userspace retry the
> retrieve, and .finish() still releases the preserved state if the file
> is never retrieved.
>
> When luo_retrieve_file() invokes a handler's .retrieve() callback and it
> returns an error, LUO currently records the error in
> luo_file->retrieve_status and blocks any subsequent retrieve attempts.
> This is necessary when the handler has already partially consumed or
> freed the preserved KHO state.
>
> However, with user arguments passed to .retrieve(), a handler may fail
> early while validating caller-supplied parameters, such as a missing or
> invalid argument, before touching any preserved KHO state. In such
> cases, userspace should be able to fix the argument and retry
> LIVEUPDATE_SESSION_RETRIEVE_FD.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

