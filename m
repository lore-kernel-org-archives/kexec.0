Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8590DC54E66
	for <kexec@archiver.kernel.org>; Fri, 15 Mar 2024 08:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R65wILg4gbBTOLWI08DLRfEWv1aOcJsHU76q2tn7DCs=; b=b1y2N7nYQs3547
	0lv2Cfttjn7TFr2lWaybahZPYjJ4/tx7AxYSod2bbhtV/VxrqMSLoUDLyb413LCBXcg2RPwoxUkwJ
	VFsp9LiIMHUvw4bJkvu4mN6HlOMiEnADtAdECqxCLXccowfPmlzHu6b/rGFEEk0j4bHxcQabG90cT
	LwoorvsF5IHk9ByW0YFCa2POb/kEo8PNyhXOSpzDk/9z0moVeq2lzmu4s/I0r9AbzWt9BI5ytPh1k
	PQvOEcar63vX9xmy0e3dhnEli1YWb07SKcWPKDJi/IcY5r8PbO2THXDAeidfBtHp031CtCiwHZN5d
	/F0lmNwFCU2Z79dRIZPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl363-0000000HBsX-2Kwg;
	Fri, 15 Mar 2024 08:39:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl360-0000000HBrA-1lcn
	for kexec@lists.infradead.org;
	Fri, 15 Mar 2024 08:39:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 38E4060BB8;
	Fri, 15 Mar 2024 08:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326DAC433C7;
	Fri, 15 Mar 2024 08:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710491958;
	bh=KoyPZgWUrQdIPeMgAamDv2IPIsnAoKsj6NO7eBIENfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUjsPedFszlGDY44N8ARo8Ohxz2fUSsp/qpNEWGqHc/uvg8ToEYS5Eh/kJg3tZED/
	 Cha8Jr0r5Pi0wldX7qYcusp8QbssPuRT4rLqzHI1hs6A319GDQMlc+yX93ac0jyN9Y
	 Nf++1/LVAdhClZNg13FKb2eEnv4anLyUlj9iLbcCT8EigVtXSGFrQKRRf8GSWPgj6k
	 AMIrARX/9Q5LVDWO24rnjkbV6j5f39R3Rpr0/Tu1DJekQP8eKEHNZCgmTr/D8auzmO
	 V4vJ82Zuwf17RetiuL04wtkD7KTrqeAUhCsfYU/SKBsWqdmwgtmUzbRdSEFqCobp53
	 rzcv71G5FZXSw==
Date: Fri, 15 Mar 2024 09:39:14 +0100
From: Simon Horman <horms@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] kexec_file: add kexec_file flag to support debug printing
Message-ID: <20240315083914.GA101331@kernel.org>
References: <20231114152030.240945-1-bhe@redhat.com>
 <20231127133218.GA3354982@kernel.org>
 <ZfQCxkuFX+Cb7fhQ@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZfQCxkuFX+Cb7fhQ@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240315_013920_522919_3A925AC6 
X-CRM114-Status: GOOD (  17.39  )
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

On Fri, Mar 15, 2024 at 04:11:50PM +0800, Baoquan He wrote:
> On 11/27/23 at 01:32pm, Simon Horman wrote:
> > On Tue, Nov 14, 2023 at 11:20:30PM +0800, Baoquan He wrote:
> > > This add KEXEC_FILE_DEBUG to kexec_file_flags so that it can be passed
> > > to kernel when '-d' is added with kexec_file_load interface. With that
> > > flag enabled, kernel can enable the debugging message printing.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > 
> > Thanks,
> > 
> > this looks fine to me.
> > But perhaps the corresponding Kernel patch should land first?
> > Let me know what you think.
> 
> Ping, the relevant kernel patches landed in mainline kernel, please help
> merge this patch.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
