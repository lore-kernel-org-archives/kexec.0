Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFFAC3DA78
	for <kexec@archiver.kernel.org>; Sat, 14 Jan 2023 00:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IY+v2qTF310OxuMBBlWUDNX3P6/5spgAhC2BA/nSu88=; b=lUv5RYggEUB84f
	ZsVI1Qq10/0ToNSFOohztQq+uOh81wg6nqZLHfWb1GBOAoXgmW3d8PjgPncrc8LWmYcD1TpPcloTD
	hVmABFvXMfOdmgyFQssQAm6JiFtK+1Ci0rDE+1HeBsnaULE2Fg8F+3zBY1YIQxxazPAJh7rKRGbaH
	cVC9JL7xpPYizxgGy8oNr7edQCxJtFV8vL6ppRljd90q9nL6kcMKdsMwWO595RGsysdtIVpZ65PXS
	YrI2EPa4MW2JFgHzf4Oi7pGbtQGTHIWz267ahRgysd3rfzNa+rwTo6kn442anpXJL9ZasJ4LnDejg
	GYEn1Sb1wLGweX+kpQeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGUrc-004wI3-BV; Sat, 14 Jan 2023 00:57:40 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGUrY-004wHa-O1; Sat, 14 Jan 2023 00:57:36 +0000
Date: Fri, 13 Jan 2023 16:57:36 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: hch@infradead.org, djwong@kernel.org, song@kernel.org,
	rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
	ebiederm@xmission.com
Cc: mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 05/24] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <Y8H+AC+S95eFy/Bs@bombadil.infradead.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230114003409.1168311-6-mcgrof@kernel.org>
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

On Fri, Jan 13, 2023 at 04:33:50PM -0800, Luis Chamberlain wrote:
> +#ifdef CONFIG_PM_SLEEP
> +static bool super_should_freeze(struct super_block *sb)
> +{
> +	if (!(sb->s_type->fs_flags & FS_AUTOFREEZE))
> +		return false;

This is used.

> +	/*
> +	 * We don't freeze virtual filesystems, we skip those filesystems with
> +	 * no backing device.
> +	 */
> +	if (sb->s_bdi == &noop_backing_dev_info)
> +		return false;

I however had dropped this and forgot to update my branch.

> +
> +	return true;
> +}


So the call to super_should_freeze() is removed and the check for the
flag is open coded.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
