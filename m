Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5F5E68949
	for <kexec@archiver.kernel.org>; Thu, 31 Oct 2024 03:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vrn4rQBsik8te7cFYwBgFRn8Y0Y3NZHTFr8sxj2J4Vs=; b=jk3F+S/9IMmJvu
	NNW5wwRoCcnEHR+pUwIzq+R/I2Kjw1BPyetYqsuZcE02vU/o+uBw+IgCAvS5+CTtL4qUh9xzCe/L5
	2HVY6nfFI5Gh+byUQ1aE7vUYU103O10ayLenvS+RBrwkkiBo7mw9iMhKLFHTzbQCi46fwV8+PK+da
	pwirGAADdgv5W0li7csL+BT38uOkN49c/4+HIZic+a8H+XcaLlv9Efyajl6u2tnDhuS+sRHYUjFn6
	oyvQKBBd7mmzZz5K9BUsBfxPV2ugv5+Z7qAy3tGARGwuINUf4eTKGJaeCJoIvzS0TBjVgJOGKXVqG
	CLBBFjS2jvvmsl2bdGAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6M3u-00000002RjS-3275;
	Thu, 31 Oct 2024 03:41:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6M3r-00000002Rin-09Nk
	for kexec@lists.infradead.org;
	Thu, 31 Oct 2024 03:41:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730346084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mzos0guM5CCjsx4ktHYZDA2/aTNVPouGHC3JHAxwbeI=;
	b=PQoHyQfHSvO7eixAYtjDzledyCxiNP3NaorzeWMGgX9s0dy8jJ9ZrdwDTmy30bbrtLNH/9
	XOGb1DDI+/jPgttJ5mqDkLBHhTwcmTYTF/beYxDYSWOw1HcWz4RannfEXX92bN1oGq85Tp
	PPtzgPxjFVrvsLgrMnik2VRsun17LW8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-bWcVKkV5MF678Gqq89Il1g-1; Wed,
 30 Oct 2024 23:41:21 -0400
X-MC-Unique: bWcVKkV5MF678Gqq89Il1g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99ECE19560B1;
	Thu, 31 Oct 2024 03:41:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.132])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AA2A1956054;
	Thu, 31 Oct 2024 03:41:16 +0000 (UTC)
Date: Thu, 31 Oct 2024 11:41:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, dyoung@redhat.com,
	daniel.kiper@oracle.com, noodles@fb.com, lijiang@redhat.com,
	kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_204127_171505_A9BB3136 
X-CRM114-Status: GOOD (  23.63  )
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

On 10/30/24 at 07:49am, Tom Lendacky wrote:
> On 10/29/24 19:53, Baoquan He wrote:
> > On 10/29/24 at 07:11pm, Borislav Petkov wrote:
> >> On Wed, Sep 11, 2024 at 04:16:14PM +0800, Baoquan He wrote:
> >>> In function early_memremap_is_setup_data(), parameter 'size' passed has
> >>> the same name as the local variable inside the while loop. That
> >>> confuses people who sometime mix up them when reading code.
> >>>
> >>> Here rename the local variable 'size' inside while loop to 'sd_size'.
> >>>
> >>> And also add one local variable 'sd_size' likewise in function
> >>> memremap_is_setup_data() to simplify code. In later patch, this can also
> >>> be used.
> >>>
> >>> Signed-off-by: Baoquan He <bhe@redhat.com>
> >>> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> >>> ---
> >>>  arch/x86/mm/ioremap.c | 18 +++++++++++-------
> >>>  1 file changed, 11 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> >>> index aa7d279321ea..f1ee8822ddf1 100644
> >>> --- a/arch/x86/mm/ioremap.c
> >>> +++ b/arch/x86/mm/ioremap.c
> >>> @@ -640,7 +640,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
> >>
> >> Huh?
> > 
> > Thanks for looking into this.
> > 
> > I ever doubted this, guess it could use the unused 'size' to avoid
> > warning? Noticed Tom introduced it at the beginning. It's better idea to
> > remove it if it's useless.
> > 
> > commit 8f716c9b5febf6ed0f5fedb7c9407cd0c25b2796
> > Author: Tom Lendacky <thomas.lendacky@amd.com>
> > Date:   Mon Jul 17 16:10:16 2017 -0500
> > 
> >     x86/mm: Add support to access boot related data in the clear
> > 
> > Hi Tom,
> > 
> > Can you help check and tell your intention why the argument 'size' is
> > added into early_memremap_is_setup_data() and memremap_is_setup_data().
> 
> That was a long time ago... I probably used it while I was developing the
> support and then never removed it in the final version where it wasn't used.

Thanks for confirming. Then we can remove it to avoid confusion.

Hi Boris,

Should I send the fixing patch alone and clean up the useless argument
'size' later, or squash them into one patch?

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
