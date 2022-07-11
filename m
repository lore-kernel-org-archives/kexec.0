Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FBFCCA47B
	for <kexec@archiver.kernel.org>; Mon, 11 Jul 2022 12:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hux4CNWwzld2y9gBL9zH+4OyEMqUEKBmbN3FX/2fEiU=; b=KNP+hijAi9lFN6
	XsCj5+M1SBt7blbPpmUT2YMPzvQvhs5H0cKw8fYhpChAB9cCewgcrS+YaH6wNdhK03aCq4rOvuEXq
	p6Y7HUDVi+rqcK4lF9cS2mup5u7dajYOwTz8afqLxfF8H6jryWWLPzTH0LOeU29c9S1nTITfmfcpw
	CGObJ/cD7Qe3CGwr7W2e1mh1LDqrQB8zIao6KRxHQOmW8kDv7PRhN3OxXbJG/hXTPlrDcQtPAMIzq
	IdPMRgoDyvZzaJ2639i+WJ78H/l262B1duwHEIllVbfYq5tTFJ40G2lJa0lTmTPeBo/eDEQ3fI+a/
	nKfz1DItc8HrUpSeGLZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAsNE-001MMR-2b; Mon, 11 Jul 2022 12:18:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAsNC-001MLR-Bw
	for kexec@bombadil.infradead.org; Mon, 11 Jul 2022 12:18:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PWKdgytGuJS/GqF7wkUB921LDsDRCbl9WqcuwqS4VyU=; b=WLBkkmsbL8JR/wP9knKzTxAJfu
	zgidLq04zQgTBURaH79ibOAB22d4EsQ4Bn7bPht4FFI6EFzIdXcuYGlbs7EFFAYnux/beYf/Itsor
	SdTXk/wJ9u8qT3cg5LSuaJ//YbNjdesxvxujy7rGIxjHLj+kft15iP8xYhVEpoud7awjayUdX3Ukk
	3nfaf5zL8hmCUNb3uHbPhEd2fMz57lYDqjU8SSYxjvMeTECWxdif2FL9ylYAwbpN3/RpHj2rsBxJ5
	JRAYco9YpARjcDLsprngrurBdRSY82Z9dqla/E6KhYGU48ZJCYkB+9z4UqW1p4S98pIOUx9ikOm8S
	K/PPxyXA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAsN2-005waR-QO; Mon, 11 Jul 2022 12:18:36 +0000
Date: Mon, 11 Jul 2022 13:18:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baoquan He <bhe@redhat.com>
Cc: Jianglei Nie <niejianglei2021@163.com>, vgoyal@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <YswVHNQX+OGz6IaQ@casper.infradead.org>
References: <20220711073449.2319585-1-niejianglei2021@163.com>
 <YsvWHwrltqqAb12h@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YsvWHwrltqqAb12h@MiWiFi-R3L-srv>
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

On Mon, Jul 11, 2022 at 03:49:51PM +0800, Baoquan He wrote:
> On 07/11/22 at 03:34pm, Jianglei Nie wrote:
> > elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> > kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> > predefined value. If parse_crash_elf_headers() occurs some error and
> > returns a negetive value, the elfcorehdr_addr should be released with
> > elfcorehdr_free().
> > 
> > We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> > fails.
> > 
> > Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> > ---
> >  fs/proc/vmcore.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 4eaeb645e759..125efe63f281 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
> >  	rc = parse_crash_elf_headers();
> >  	if (rc) {
> >  		pr_warn("Kdump: vmcore not initialized\n");
> > -		return rc;
> > +		goto fail;
> 
> Sigh. Why don't you copy my suggested code directly?

I think at this point, you should just submit your own patch
and credit this person with Reported-by:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
