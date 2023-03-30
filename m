Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A587C77B60
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 15:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ve2vU/rP0PPZzyPJZMWZgOM0E7o2FKsIhlN3wKkGbFI=; b=Fdt0LXuQjb3adB
	KhE4+Wk4UpBfhzCmVAGMVWARbJVJEp1UnB50mEPnF+sL2sSmlULaM1+UPv3cr7eodkWm44vPqRPU7
	n3sqorybA5NgMpCnFmnN/aP7qh6rdKE2+9R7yrSYetPv2H79stPtV77Gb/imE0Wx4FhdvA3lJM/MK
	dwxun2Ib3/afVW3wTJEPZSUt3SnS45+MnpJLfymuzdjCZKcwK1Q5BoRtWjly9Lj9Q/CTrKuc5fbsv
	0ih9HS/WpJYT/KeZASBpNKNwE1AEAzxhFFlXQwZ4yS3czggx44AWQNFGEC8K572wLN4lwb/h8RVXt
	6rpKBTlFeg4wzVzXg7kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phuFT-004IFZ-2f;
	Thu, 30 Mar 2023 15:31:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phuFP-004IDu-2P
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 15:31:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1FC03620D1;
	Thu, 30 Mar 2023 15:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01CCC433A4;
	Thu, 30 Mar 2023 15:31:29 +0000 (UTC)
Date: Thu, 30 Mar 2023 11:31:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Eric Biederman
 <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Philipp Rudo
 <prudo@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>, Simon
 Horman <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
Message-ID: <20230330113127.3011e021@gandalf.local.home>
In-Reply-To: <20230330151826.GDZCWoQkQBj4BYbwWw@fat_crate.local>
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
	<20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org>
	<20230330111523.4b98c8ce@gandalf.local.home>
	<20230330151826.GDZCWoQkQBj4BYbwWw@fat_crate.local>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_083131_823096_B126711D 
X-CRM114-Status: GOOD (  15.92  )
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

On Thu, 30 Mar 2023 17:18:26 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Mar 30, 2023 at 11:15:23AM -0400, Steven Rostedt wrote:
> > > Make sure that the .text section is not divided in multiple overlapping
> > > sections. This is not supported by kexec_file.  
> 
> And?
> 
> What is the failure scenario? Why are you fixing it? Why do we care?
> 
> This is way too laconic.
> 

Yeah, I think the change log in patch 1 needs to be in this patch too,
which gives better context.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
