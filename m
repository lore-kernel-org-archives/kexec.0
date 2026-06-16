Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D947CD98E1
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tWXK2MgnxD76uTnjz4VT2lfsHJfH4SLRFX57lXEkaNw=; b=K7OHxj3Clu06gr1EYsfWfCPNJ8
	1unIbaDsrA1l3UDF489V4n3gvSq3STJlfhkXwqdnWQt+OBbmQk86bkB+ZXOxynMcM+Bteo/FuUTqS
	ucC8Hih8SObDY1Fg8MkYObz/VHosRQDqoMEQyke9LKKA5huM7/23zmlFx8//QiQPSL6eGm6HwCiib
	3k3x8/TAJwV5d68LstfuztOVShSSo8EqKp/+5BKbtz4YRidjDjaN9+PA5lWuXz7JQTJaU7mLSpkEd
	RBeKPMNBkiaeyXCWxvl2uNlfTAgduWgWAXCwadkP2+KG/PHbBrNWvxQo9KHx4r7SyX46TurlqE1ve
	Zmf1ylQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZXYp-0000000GAbg-2EH9;
	Tue, 16 Jun 2026 17:26:51 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZXYn-0000000GAbV-0q6O;
	Tue, 16 Jun 2026 17:26:49 +0000
Message-ID: <6513c228-859d-4a04-853d-2d1d531b4610@infradead.org>
Date: Tue, 16 Jun 2026 10:26:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] driver core: async device shutdown infrastructure
To: David Jeffery <djeffery@redhat.com>, driver-core@lists.linux.dev,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>,
 Pasha Tatashin <tatashin@google.com>,
 =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
 Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>,
 John Meneghini <jmeneghi@redhat.com>,
 "Lombardi, Maurizio" <mlombard@redhat.com>,
 Stuart Hayes <stuart.w.hayes@gmail.com>,
 Laurence Oberman <loberman@redhat.com>, Bart Van Assche
 <bvanassche@acm.org>, Bjorn Helgaas <helgaas@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>, kexec@lists.infradead.org
References: <20260616152219.6268-1-djeffery@redhat.com>
 <20260616152219.6268-4-djeffery@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260616152219.6268-4-djeffery@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/16/26 8:22 AM, David Jeffery wrote:
> +	core.async_shutdown=
> +			[KNL]
> +			Format: <bool>
> +			Enable or disable asynchronous shutdown support. When
> +			enabled, on system shutdown unrelated devices flagged
> +			as async shutdown compatible may be shut down in
> +			parallel and asynchronously. When disabled, device
> +			shutdown is performed in a serially and synchronously.

			            performed serially and synchronously.

> +			Enabled by default.

-- 
~Randy


