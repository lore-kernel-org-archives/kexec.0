Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15F2F531FC
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 09:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fxwBN7YO9V94Y4GQk8ETQvEzVpW9hWWXbpkHLYI8vo4=; b=TaYTovgzSItEc66pW4Yc6oZx6w
	jms2mqYe9R6KTu6xUqyXgUMjUo6hQg2kx76Ly4RPpqBdVqm3MPRaavARdOt4+JfBNx+TtPQcN8rv9
	efbO1VEsxvs5MOuIBX+83EmlfeppDQLZAbN5/EbRTO64wT3+mx2Y6BqnveVdusfTr7NFpydzGqDoH
	me0B69iQwGp0W0aka5PDt/WtKb6vhN3mDWxtTrfx4mXV99xgBPyMLDf+DQMaxlsURe+tnFVopThBK
	xYDd9dCISbv2ggWKz1pDp8pQJIUtxta6OM77gF2G9/QQse1yiJdaAdXZL19Lkk6g1JT+GMbVIttXF
	MIoOJtWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCwME-00000000snR-1fek;
	Wed, 15 Apr 2026 09:16:26 +0000
Received: from out-183.mta1.migadu.com ([95.215.58.183])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCwMA-00000000slf-2Y0Q
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 09:16:24 +0000
Date: Wed, 15 Apr 2026 17:16:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776244575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fxwBN7YO9V94Y4GQk8ETQvEzVpW9hWWXbpkHLYI8vo4=;
	b=Z/7dno3bxnuyETOg2pGfAOv2+66IPZfm6EyBNEs8pbQ/V14ZDq0jSbL42fZCJhqFLR7EAG
	GHARl/rw0Wxc6oA88KoKiAi/izIE4ObLrHW6weWn2Ihwdw0BCadcRZV0gz7uyu/hGg0pQz
	vIzxoeIBgo53tgDH2Lv3Ka3iYzZxSmM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Dave Young <ruirui.yang@linux.dev>,
	Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Dead link in kdump section of MAINTAINERS file
Message-ID: <ad9XWAXVxYFc-dWd@MiWiFi-R3L-srv>
References: <e1e9e200-17d7-4ae9-b0eb-71300f4eb1ac@linux.ibm.com>
 <ad8rrO55DGZqSyZy@darkstar.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8rrO55DGZqSyZy@darkstar.users.ipa.redhat.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_021622_957296_C0999DA4 
X-CRM114-Status: GOOD (  12.82  )
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

On 04/15/26 at 02:09pm, Dave Young wrote:
> Hi Sourabh,
> 
> On Wed, Apr 15, 2026 at 10:26:20AM +0530, Sourabh Jain wrote:
> > Hi all,
> > 
> > Noticed a dead link in the kdump section of the MAINTAINERS file:
> > 
> > W: http://lse.sourceforge.net/kdump/
> > 
> > The URL no longer seems to be accessible. Could this be updated
> > or replaced with a valid reference?
> > 
> 
> I have no idea about the old link, I suggest to remove it if nobody
> knows.

Yes, agree to remove it with a patch. There's document inside linux
kernel, no necessary doc from outside.

