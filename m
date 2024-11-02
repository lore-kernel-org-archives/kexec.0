Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C6BE6F09A
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 00:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YWaapvaVIeY82h1oAZ58BAJqPw5dd4gINH04i2Bt3Cw=; b=ummJTO/Xbezcd+
	AWssfsFa+CXwjgD0Cip0k3wdE2t4MsiAvqVI2GtyG0sSUfdnqZNycrtzfr2NPLP5nhc86A+CF3zAY
	r0rK76eG7k4t4qnPdB3NxhZzwWuYS4jLdwnv66lOPef3AKbueb3fsyooYaHEZL9/FXLuH54LQ4eD+
	l6zQ8DRvsI5DYMKDaPhfjMoROYf4mK+oXsJ88loO3403WpObST+v1H0AFJDWgavGlWdQl1na+Lf3Z
	gwfuyBDQaChbCJACjws0NcJ8wgMn9XviqDRP4dtwawF1eb/LYRGZqK3AYDLqxsYHSBa9+ASCZ/Qgg
	jgde3tZrz3242g8SVryQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t71vi-00000008c6G-4C1Q;
	Sat, 02 Nov 2024 00:23:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t71vf-00000008c5K-31uw
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 00:23:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730507025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVZopAEbNBIrE6Pzb3BRalzXXCBqMKqri4Yq7OKfFwA=;
	b=Z06QaMoVYq20EfSvoe1W/TEOOZDAbONhgdwcM06nysRrZiC8LtgsBSrUt0V611i6H23dXJ
	I3yajQcsO/LjEDYHCv+1ZAMVlwllspw0mIVLGaJw+roVzOlATA1TxltFQvYXaGVlqIaBg1
	UkXtwiJDzLyopGGNX9zhsHz79cF10KY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-dCoGU5loNI6vRHz0pLacCw-1; Fri,
 01 Nov 2024 20:23:42 -0400
X-MC-Unique: dCoGU5loNI6vRHz0pLacCw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 603EB1955D94;
	Sat,  2 Nov 2024 00:23:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C399719560A2;
	Sat,  2 Nov 2024 00:23:38 +0000 (UTC)
Date: Sat, 2 Nov 2024 08:23:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
 <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_172347_855409_E39DFDA3 
X-CRM114-Status: GOOD (  11.80  )
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

On 11/01/24 at 05:18pm, Borislav Petkov wrote:
> On Thu, Oct 31, 2024 at 11:41:12AM +0800, Baoquan He wrote:
> > Should I send the fixing patch alone and clean up the useless argument
> > 'size' later, or squash them into one patch?
> 
> First the fix, then the cleanup.

Sure, will do. Thanks a lot.

> 
> Btw, that fix wants to go to stable no? Seeing how it breaks certain machines
> with IMA and kdump and SMe...

Yeah, it should be added to stable. Distros may get both SME/IMA set not
as early as the bug introduced, while anyone doing so in an earlier kernel
will see the problem.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
