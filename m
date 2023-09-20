Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AB0CE79CE
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2+X+m8QjsKoX5KumDT4QlUiBzviavFRLb7sKa/zdcHY=; b=fn7L0ruPvzzctM
	LzEI1nSCgux+OPITYN8JXUBJvtmfhtLOEpSCeOM3e28CDs8/A/Whz8rNhzVQQmwDh3bmGecfy7V5y
	HWq+IkicAIhs/L+CENLSWPLBe2seNW5/Z5DAZDOQxjcT8LGNUiCINNvP3IgCja9Aty5TIJLZWA/BC
	9uN06SJGY5TOtnLBiOYeaHlIJAKWQwaeZ9LSyuFgKRzeiu504BM7ncfjEDRU/Nkh63g5SaTShs2Kv
	Pzfa5P6htgMhgh86sK9YLMqFheZL690T/aaNDSCnBQpjmZ95u0ojWFXw1R895ac1e6Emv5nxXh0wD
	FE/VgvyMlg4sIOqqK8mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qivaH-002tio-37;
	Wed, 20 Sep 2023 11:41:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qivaF-002ths-0d
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 11:41:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 513A7614A9;
	Wed, 20 Sep 2023 11:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C548C433C8;
	Wed, 20 Sep 2023 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695210087;
	bh=1PgwhM8TmPi1bqsh/BlDscMOzwbDTb4fNY7QfHGZTEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIDid6aTHzbtFn2Gg1BHnw1aCy+NmM50kAMR1h8SI2bRVyX7O2TlMtf5rP5ylMbng
	 THCDK5twcZ8g9IsOmz6lfYilCmaxy+H7eJJKgACpZuJ+lSMHHxpUmNNt6FiiuNZyze
	 KHYM0Cnh0ElnE4ySLEp2J1tp3D5fqHqWRRIj9LCJj4BabQZpf7nhGqo0Oc7UW5zafZ
	 /GE1rrW+C9KX64Oyvf9G5VZXM07HJPwOCgxoXUWdOQwGA/mPlrpr02njK9Kp0+9fyS
	 n+JdI8QVUrA131zIJk7LxrCHNNcbZKjvZh36Pw8nmb4b5owr3Pqw2dqglN4Vnc+1Yx
	 nN2fIO1zpzzPw==
Date: Wed, 20 Sep 2023 12:41:23 +0100
From: Simon Horman <horms@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, Kexec-ml <kexec@lists.infradead.org>
Subject: Re: [PATCH] kexec: update manpage with explicit mention of clean
 kexec
Message-ID: <20230920114123.GD224399@kernel.org>
References: <20230707052929.427625-1-hbathini@linux.ibm.com>
 <63e65749-4ec7-c618-72d3-1568992fff7a@linux.ibm.com>
 <20230828074810.GY3523530@kernel.org>
 <ZOxr7VjBhBe6WW91@MiWiFi-R3L-srv>
 <70462450-b31f-fdfd-031f-debb89c118ac@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <70462450-b31f-fdfd-031f-debb89c118ac@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_044131_303047_5E23ACCC 
X-CRM114-Status: GOOD (  31.86  )
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

On Mon, Sep 11, 2023 at 12:04:08PM +0530, Hari Bathini wrote:
> 
> 
> On 28/08/23 3:12 pm, Baoquan He wrote:
> > On 08/28/23 at 09:48am, Simon Horman wrote:
> > > On Mon, Aug 28, 2023 at 11:46:14AM +0530, Hari Bathini wrote:
> > > > Any comments on this, please..
> > > 
> > > Hi Hari,
> > > 
> > > Sorry, I had missed this.
> > > 
> > > > On 07/07/23 10:59 am, Hari Bathini wrote:
> > > > > While the manpage does mention about kexec boot with a clean shutdown,
> > > > > it is not explicit about it. Make it explicit.
> > > > > 
> > > > > Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> > > > > ---
> > > > >    kexec/kexec.8 | 12 ++++++++++--
> > > > >    1 file changed, 10 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/kexec/kexec.8 b/kexec/kexec.8
> > > > > index 3a344c5..87e4ab5 100644
> > > > > --- a/kexec/kexec.8
> > > > > +++ b/kexec/kexec.8
> > > > > @@ -95,8 +95,16 @@ then you would use the following command to load the kernel:
> > > > >    .RB "\-\-append=" "root=/dev/hda1" "\ \-\-initrd=" /boot/initrd
> > > > >    .RE
> > > > >    .PP
> > > > > -After this kernel is loaded, it can be booted to at any time using the
> > > > > -command:
> > > > > +After this kernel is loaded, assuming your Linux distribution supports
> > > > > +kexec-based rebooting, it can be booted to, with a clean shutdown, using
> > > > > +the command:
> > > 
> > > Perhaps user-space would be better than "your Linux distribution".
> > > But perhaps that is just kernel developer speak and makes less
> > > sense to others.
> > 
> > Agree, linux distrobution doesn't make sense here. And since this is a
> > kexec man page, does it really need to make this change? We know
> > kexec-tools loaded a kernel, we will use kexec-tools to trigger the
> > reboot. Wondering why we need to stress distros or kernel or kexec-tools
> > supports the kexec-based rebooting. 'with a clean shutdown' seems a
> > little helpful though.
> 
> Yeah. Users did express that lack of clarity on what is the cleaner
> approach to use kexec boot after load. That prompted this patch.
> I am ok with "user-space" or "your linux distribution".
> 
> Simon, do you want to respin with "user-space" change instead?

Yes, I think that would be best.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
