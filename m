Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669FFCD4F4A
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0SVvrudyMWIoIq0kLhspON9LEtbwJPMngxEuTZrbdhE=; b=eCexJkGx3l3kBsjcyj/Th/pA/j
	PP1v542HcVnq8y5oQCRj3Qa357acdMYibJokEOeNBIxPTCyUjky6D5BcKIbW3M0zbybCrSLinqs+M
	WAUtVw5q6xFML6Ra4v6e3PYLrmsr6Sg5r+RlZJMlGneKp0pr1bh/SgSta+wi0tqSHpYby4jRc86c7
	el+UtlzAnpttLIMY11D8VPqLDghlM2phXD4e8IGr+GdxLbxbq3hjxq1th+EnwIi5YAlS/lD6hlIxI
	m9dLcq9zT9elS0whM/UosQW5//0o+5LAJoXVVQ0pC/+xM5m0yT5g/6AoOohSPFyO6iBt0aNvpf3Oe
	jsAQyGfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfKi-0000000D7RX-1y5G;
	Sun, 17 May 2026 17:31:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfKh-0000000D7RH-1HGe
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 17:31:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 57F84601E3;
	Sun, 17 May 2026 17:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918B0C2BCB0;
	Sun, 17 May 2026 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779039078;
	bh=+aUjJ1d0JLkcLl5wfHdzIg1GFF63EALYJshPzkwzzWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATudrdgAiAFP4FEfv8ThrK2psXtOQgx8sXHFshWDMMTTuGVH4CMNWy9K9lhSWo9Mf
	 5DupSbZ6y5SI6XPloBrlt3dCIIznNJP5tSCT1346pT17DNoLyE3dqQUUlMB/4TePD2
	 e9Mxeg6wnZm6SQ1vCGuvVSXXYbh+pvblsFS6QS2FCZi0DOdlL4Xd8V4qDG5h9L2Nge
	 jNFBff+2mssd62VCHPlFXyW0/c2eRPnTFjTnOYphBteuCELIYPmLh0KmQMdwSu+DNl
	 B3GTtS9UqqUjGy2KBciMoaQqQcVlWBJbJ4Gq8HUayIbjktidN91bW44PVTrzbhnofm
	 d8+0D1W3PgWkw==
Date: Sun, 17 May 2026 20:31:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v2 05/10] liveupdate: defer session block allocation and
 PA setting
Message-ID: <agn7XnuO7VU4eK52@kernel.org>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-6-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514222628.931312-6-pasha.tatashin@soleen.com>
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

On Thu, May 14, 2026 at 10:26:23PM +0000, Pasha Tatashin wrote:
> Currently, luo_session_setup_outgoing() allocates the session block and
> sets its physical address in the header immediately. With upcoming
> dynamic block-based session management, this makes the first block
> different from the rest. Move the allocation to where it is first needed.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> @@ -77,15 +77,16 @@
>  
>  /**
>   * struct luo_session_header - Header struct for managing LUO sessions.
> - * @count:      The number of sessions currently tracked in the @list.
> - * @list:       The head of the linked list of `struct luo_session` instances.
> - * @rwsem:      A read-write semaphore providing synchronized access to the
> - *              session list and other fields in this structure.
> - * @header_ser: The header data of serialization array.
> - * @ser:        The serialized session data (an array of
> - *              `struct luo_session_ser`).
> - * @active:     Set to true when first initialized. If previous kernel did not
> - *              send session data, active stays false for incoming.
> + * @count:       The number of sessions currently tracked in the @list.
> + * @list:        The head of the linked list of `struct luo_session` instances.
> + * @rwsem:       A read-write semaphore providing synchronized access to the
> + *               session list and other fields in this structure.
> + * @header_ser:  The header data of serialization array.
> + * @ser:         The serialized session data (an array of
> + *               `struct luo_session_ser`).
> + * @sessions_pa: Points to the location of sessions_pa within struct luo_ser.
> + * @active:      Set to true when first initialized. If previous kernel did not
> + *               send session data, active stays false for incoming.

Hmm, why addition of a single field changed the entire block? :/

>   */
>  struct luo_session_header {
>  	long count;

-- 
Sincerely yours,
Mike.

