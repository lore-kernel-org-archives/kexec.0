Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB632C64EC4
	for <kexec@archiver.kernel.org>; Fri,  3 Mar 2023 09:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Yu/+1uxyK9UvxS61rQzXdkifyvrI/cf3h6uoQ5vUDo=; b=L+gAm3C/ctUvIf
	GwlxTGDUWX+7L0mhqKexUuxlNA7IM33dO4rLJDZx6gLNWSYWqToBcQVjZKI4HMON56fcgSLJtR0pv
	v9L+jOuiVEmo9LPbi7C+G86u3c1wJpfWsIYPb4MgNJkJ+KVIWnZTFX/zxmw2+54LDxGfaIKvdyAfl
	EhXgRi0jO+hNibqwCOP13pyQdS0BHWZubft8FdJ8vKmiJ+sxUV/8/SCesU4hxoxZWQevHTyYyJjni
	YUo0jv9NjcEJFcGLD4+NYu4SlSftYT65gpg0VweibDr017FIGS1hm+sVHEJUBASbKP/l3xQj/gClB
	QSBQ7gt60P8lsttr4eYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY1pD-005nvB-56; Fri, 03 Mar 2023 09:35:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY1nA-005moX-Nt
	for kexec@lists.infradead.org; Fri, 03 Mar 2023 09:33:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 89BB861797;
	Fri,  3 Mar 2023 09:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF26EC433EF;
	Fri,  3 Mar 2023 09:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677836010;
	bh=m/rTKoecB8BYYa1TAp7wz3n+kpjjJ7cHkyTXhrMKzYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LseXr0nRtAhMbwGYSMhniPvywl24L87XVITAQfYSuuNF1rLAiKw3X+GXUQ9Gz+ZSj
	 0wCF8US2zl5w225Wnry8QbbvTxq7zYfukzP+EUFFmqjym+s+uHMvcrFszhDkUhJXLr
	 BNpgD7yngp6h6BifE5FFH3+c1V3HTrfZaH+Ny85s0Jwpfb6FXAxPV5lUWs6PHTGi83
	 igIXNeKWneGOE+BUbVpqTtMj66BVvFA6cQBMG1Vp8Ty7IFjV0QLkemwfetbx5luLqn
	 weehEpkqosy3GEa1vEmyy6LDBhHweFYLERwvl+7AZ0P8QRnTyOSBvVOG5USgows+mr
	 G9QegZsLBhWUA==
Date: Fri, 3 Mar 2023 10:33:26 +0100
From: Simon Horman <horms@kernel.org>
To: Gautam Menghani <gautam@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au,
	sourabhjain@linux.vnet.ibm.com
Subject: Re: [PATCH] ppc64: Add elf-ppc64 file types/options and an arch
 specific flag to man page
Message-ID: <ZAG+5l0gYU+4S6n9@kernel.org>
References: <20230301085819.117295-1-gautam@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230301085819.117295-1-gautam@linux.vnet.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_013332_855242_FC79E2ED 
X-CRM114-Status: UNSURE (   9.20  )
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

On Wed, Mar 01, 2023 at 03:58:19AM -0500, Gautam Menghani wrote:
> Document the elf-ppc64 file options and the "--dt-no-old-root" arch 
> specific flag in the man page.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.vnet.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
