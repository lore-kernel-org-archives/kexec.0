Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67924606A31C
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wmYa7vVC;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EWXtiPww
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PPAAuGCkNf6AXziZOLwAWEjxj7/iQ7j2Pi2J4zSJGhA=; b=wmYa7vVC00ceSp3QyDR+Op3yuV
	EdL4YGim/W5nGX33Sxj8QhABkDNdVrR5eNmv4BrXzu2j53kcCscE/rFTT8k7Oeyeoy5SaEhnsGaWi
	VUpSl+n5/Wvbotp+EJJoAMfd7Z1miF6BLofDqvI7jPorzOZ9x/d/mAPrsEb3k5hXRt0GIKjqnuILR
	9ESKfxMNBfcer9GLydY0eCCVDnY3K7r0pw4hgl0GsqJRYSbBUxCTOBMDpCdwLLYjFNjkmjRRrhm2d
	cR9JFBjxSOcuTMHmLmAv4JKlSQtVbXPgSYI/j2UqLw7GG3qg4eCk7YZeSk2aem7VLh8mr1+gVVIXI
	s2Qxvomw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQJdV-0000000HYXF-45J1;
	Mon, 09 Nov 2026 07:17:49 +0000
Received: from out-58.mta1.migadu.com ([95.215.58.58] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQJdR-0000000HYWq-3V1y
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 07:17:47 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=/5uZXVp2mOgdAcrra3SlHMiCdYY2Ioe8dE7NBeteCQc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794208662; v=1; x=1794813462;
 b=EWXtiPww36tCLiFN9TVJaTtmO6HgCIWE+DJamoW63xK8ksSw0QljAT8E9Kk2jWUJ+fdi1x2X
 YTZJSJytEFFaUxU8Hj9oklfmv8nVsE4SfhqxUmCoGbxn0E/036h/GOd01HwQpugPgkHZUV+cocV
 P70bAuTU664ri1Co3Su43J8k=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id d3e43e32f10b7de9;
	Mon, 09 Nov 2026 07:17:42 +0000
X-Mizu-Trace-ID: d3e43e32f10b7de9
X-Migadu-Flow: FLOW_OUT
Date: Mon, 9 Nov 2026 15:17:35 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Dave Young <ruirui.yang@linux.dev>
Cc: akpm@linux-foundation.org, rppt@kernel.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove myself as a kdump reviewer
Message-ID: <avFpU8yUF956ysKM@fedora>
References: <avFSU0f0aE-amdls@darkstar>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avFSU0f0aE-amdls@darkstar>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_231746_085071_DFD40EAD 
X-CRM114-Status: GOOD (  14.85  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave,

On 11/09/26 at 12:55pm, Dave Young wrote:
> I do not have enough time to review kernel patches though I still
> accasinally scanning the patches. Drop myself from the reviwer list.

Thanks a lot for your contribution to kdump development and maintenance
on patch reviewing, bug fixing and feature improvement in the past. We'd
be glad to have you keep contributing to kdump whenever you have time.

For the patch,

Acked-by: Baoquan He <baoquan.he@linux.dev>

Thanks
Baoquan

> 
> Signed-off-by: Dave Young <ruirui.yang@linux.dev>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e9fe9c2a39b..7e18fe93d4f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14145,7 +14145,6 @@ M:	Baoquan He <baoquan.he@linux.dev>
>  M:	Mike Rapoport <rppt@kernel.org>
>  M:	Pasha Tatashin <pasha.tatashin@soleen.com>
>  M:	Pratyush Yadav <pratyush@kernel.org>
> -R:	Dave Young <ruirui.yang@linux.dev>
>  L:	kexec@lists.infradead.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> -- 
> 2.51.1
> 

