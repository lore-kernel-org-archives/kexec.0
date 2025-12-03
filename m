Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC427D15DB7
	for <kexec@archiver.kernel.org>; Wed,  3 Dec 2025 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PdnmIzQS6elf4FE8ILYiRLrCGZr3Vg2tDK8Hzg+rvRc=; b=xwxflKwRWbb4Cy9iUfzUd6XhIU
	A6Kv+1RGBJFvC5GZ6kET4889q+ZlXpL5HV4Y5AuPCYxSs4Y8fwuHL4KAYuvYZ3q69SGsLkshlVSgn
	yN5Q68dnlj18UaRaQLUOgWXXbVw8GmReHRO24leABV5E61ZaxcJC7BK21+l3QIufrmdItmJp4I5z+
	+WkKdTGnYmTgLhiVV1/7ZmERfHm12AJnapjPmWiS4ZqjGS+2M51JFMDhxnPeDf8QHhpbCjn1gRXRT
	ElA7I0Jm8kKAdPHkChTwKW/2yVfDpSxiynXMNgBOQTwqNk4mB01/ceyqYomP4VAEwtyksr8I08x+P
	WLHfMUVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQqaa-00000006rNC-3E2G;
	Wed, 03 Dec 2025 17:24:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQqaW-00000006rN4-2hvi
	for kexec@lists.infradead.org;
	Wed, 03 Dec 2025 17:24:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B6BE9601E0;
	Wed,  3 Dec 2025 17:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932E6C4CEF5;
	Wed,  3 Dec 2025 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764782663;
	bh=lt+t94/88oCd9TKrXmN4lVzGQUSINuL09Yxsh68lgnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcONzTDp6TxLmAk2dP1c1NngY3/72+eVQ6S/tpWXXXNX/zmwNw12DfH/D/XxLlLKb
	 bj6THuKVgjL+pKY+7ChEyXRnPwuNF9QTH/JD3imVheR2mP0pzi018j1f1mIWOdDLn7
	 iWxCsvq8HLWPT12efmUuo5OtWkO6KCzbdfNaFmiFl9pym67ZcMR6U+WatJZVCRkgBc
	 U4OOyDnilpvFodU6ibUCYfodO9NJ7D1ni6yowAUN8y1c+nOXSV4poRljtfI4HXVz2v
	 3jEOGLfKNyj48s+V7YLHAIW79gYWfivC3AyKCIH8DE9Q3Cri3Z7ZxFgyBzhi+JRUpD
	 ZWhgdqa5kuLJg==
Date: Wed, 3 Dec 2025 17:24:20 +0000
From: Simon Horman <horms@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: kexec@lists.infradead.org, Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH 1/2] kexec-tools: powerpc: Fix function signature of
 comparefunc()
Message-ID: <aTByRNlpW0Wh_r2I@horms.kernel.org>
References: <20251022114413.4440-1-glaubitz@physik.fu-berlin.de>
 <501429ee083aa7fb07db910e167411fa7707a0f6.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <501429ee083aa7fb07db910e167411fa7707a0f6.camel@physik.fu-berlin.de>
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

On Sat, Nov 22, 2025 at 12:11:47PM +0100, John Paul Adrian Glaubitz wrote:
> On Wed, 2025-10-22 at 13:44 +0200, John Paul Adrian Glaubitz wrote:
> > Fixes the following build error on 32-bit PowerPC:
> > 
> > kexec/arch/ppc/fs2dt.c: In function 'putnode':
> > kexec/arch/ppc/fs2dt.c:338:51: error: passing argument 4 of 'scandir' from incompatible pointer type [-Wincompatible-pointer-types]
> >   338 |         numlist = scandir(pathname, &namelist, 0, comparefunc);
> >       |                                                   ^~~~~~~~~~~
> >       |                                                   |
> >       |                                                   int (*)(const void *, const void *)
> > 
> > Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > ---
> >  kexec/arch/ppc/fs2dt.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
> > index fed499b..d03b995 100644
> > --- a/kexec/arch/ppc/fs2dt.c
> > +++ b/kexec/arch/ppc/fs2dt.c
> > @@ -292,7 +292,8 @@ static void putprops(char *fn, struct dirent **nlist, int numlist)
> >   * Compare function used to sort the device-tree directories
> >   * This function will be passed to scandir.
> >   */
> > -static int comparefunc(const void *dentry1, const void *dentry2)
> > +static int comparefunc(const struct dirent **dentry1,
> > +		       const struct dirent **dentry2)
> >  {
> >  	char *str1 = (*(struct dirent **)dentry1)->d_name;
> >  	char *str2 = (*(struct dirent **)dentry2)->d_name;
> 
> Ping for both patches.

Perhaps this email [1] got lost somehow?

[1] https://lore.kernel.org/kexec/aRM6sOfZdcyB-2j3@horms.kernel.org/

FTR, they have been applied as:

- kexec-tools: powerpc: Fix pointer declarations in read_memory_region_limits()
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=6c878e9b8a50
- kexec-tools: powerpc: Fix function signature of comparefunc()
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=2786f8eb3e5e

