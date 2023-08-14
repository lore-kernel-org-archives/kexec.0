Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92272C04FDF
	for <kexec@archiver.kernel.org>; Mon, 14 Aug 2023 22:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h4K8CT5ZZv3Ogl6hjT3LhvdxrOZAEpqFn6rmfMgpnCA=; b=O06fCHDVzmbdbM
	QHxJIPwRn+gsh/T+wXms10HFfCoylefECf3cNQo5W8XHF+PB8j4OLiOuU1MOyyDx55yeCx8UQQrbk
	YAl4pVEyGR3lwgUKBg4MKeFanJhiN1VSGSSNgq4UFwf7vGfFM/05jiWBGjqx9jzzLRjs+ru4BJwF0
	2rT/E2MrkxUu9CEwJvzMiy8ze3dOJWmUPRpdz0yNs1z6KMJaA92L8Oo7JArmMvYZqTda4z6dE9bvp
	2y+KLSTrounkk/ekBaF6NixcLGsjYjnG+p1j9QX6+weA0ynlHl6JB06n/NgBFMkE0sob2YfOIT9D0
	CbJdS0avx3j8u+Rj0GGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVg88-000SpV-1C;
	Mon, 14 Aug 2023 22:33:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVg85-000Sol-1F
	for kexec@lists.infradead.org;
	Mon, 14 Aug 2023 22:33:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B821564B32;
	Mon, 14 Aug 2023 22:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04615C433C8;
	Mon, 14 Aug 2023 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1692052420;
	bh=wucllKs3sBBWi3/TESmbyIF4E7TLR7lcxIjXe6mBVj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2kxxAv3285i5N4BOywPZAeFfWe5Hdh2DHc0pUiJwWEfe+BopgSu2y14g88VA7Lg76
	 kRKGrBF9cWLBm1vv5kQ2IY1SX/Chsyx7Eg5YD21Cphc485OmlwkZTBaOF+mxSQXPfC
	 nK37MUXJlS18ocGFI28dJud5OS7jGuHDoIcCcgCk=
Date: Mon, 14 Aug 2023 15:33:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
 ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, vgoyal@redhat.com,
 dyoung@redhat.com, lf32.dev@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
 seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, sourabhjain@linux.ibm.com,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v28 0/8] crash: Kernel handling of CPU and memory hot
 un/plug
Message-Id: <20230814153338.79164562f1d2810a18f495dd@linux-foundation.org>
In-Reply-To: <20230814214446.6659-1-eric.devolder@oracle.com>
References: <20230814214446.6659-1-eric.devolder@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_153341_511736_40B3BA41 
X-CRM114-Status: UNSURE (   9.95  )
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

On Mon, 14 Aug 2023 17:44:38 -0400 Eric DeVolder <eric.devolder@oracle.com> wrote:

> This series is dependent upon "refactor Kconfig to consolidate
> KEXEC and CRASH options".
>  https://lore.kernel.org/lkml/20230712161545.87870-1-eric.devolder@oracle.com/
> 
> Once the kdump service is loaded, if changes to CPUs or memory occur,
> either by hot un/plug or off/onlining, the crash elfcorehdr must also
> be updated.

Thanks, I updated branch mm-nonmm-unstable to this version.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
