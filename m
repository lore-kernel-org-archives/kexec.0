Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2507BC04FDF
	for <kexec@archiver.kernel.org>; Wed,  9 Aug 2023 02:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AGp9YjwVU6XSYiDMw93nSUF2SK3WTv1uBB9B0yPjBKc=; b=lDt2CFcRwISpbv
	YCLYKNlsKau9ItoTY3FM43H1XwRGWC89Vdz74UtuGPAUR/BQRS9SAfgZiZvsMcHpYzqyKGAtIA4he
	/d9R13Mb4R1gABQG6lHKdGUOp5c+yjeFbK7WhSn83WEPDeItRI+9zJ07SUpAIjr3vmFWlNqvKys6D
	uZ33dSBEkrUZmxOq6RwmY3hszPwHsYS6quT+9xjOsacOYXLKeAEHDhwYmb07xG5aQG6/xGJsMAFqv
	zEE4tZurVRuADn661vtiK6Rel/JwnKJAdsJTe4w1HQ36E52RpuWE13LI+LtbSuCCaYmYC83heBnWk
	Xdyc/7/85b003xLDKDmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTYg1-003sCJ-1O;
	Wed, 09 Aug 2023 02:11:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTYfy-003sBk-1v
	for kexec@lists.infradead.org;
	Wed, 09 Aug 2023 02:11:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691547111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rv4Ker0R0fL8fxtzfnNJmiV4bNdRsYizF32IMrCh0MU=;
	b=HrFaoz5LT3iAT/5dLFpYwyPlHMasW6Aiix+kZ2P0Hf7DxBUp/mxipxuVnM+QoIL1MA0I5A
	trKHsF745IT4Z77S4E4eQoPBeFBovBVBmS8k9qTjCdqZ0D9QjuPTNRzGSikIfwlFyjg7WS
	mszfkUEcAMp3ZzIWWP1sY15MUDB7s38=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-yBSQL6PeNT2imycNOchykw-1; Tue, 08 Aug 2023 22:11:50 -0400
X-MC-Unique: yBSQL6PeNT2imycNOchykw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F34B80CC34;
	Wed,  9 Aug 2023 02:11:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 62F204EA54;
	Wed,  9 Aug 2023 02:11:49 +0000 (UTC)
Date: Wed, 9 Aug 2023 10:11:46 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, piliu@redhat.com
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kexec reports "Cannot get kernel _text symbol address" on arm64
 platform
Message-ID: <ZNL14lnrHvzbpRQu@MiWiFi-R3L-srv>
References: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_191154_727155_BB25151A 
X-CRM114-Status: GOOD (  11.04  )
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

On 08/08/23 at 07:17pm, Pandey, Radhey Shyam wrote:
> Hi,
> 
> I am trying to bring up kdump on arm64 platform[1]. But I get "Cannot get kernel _text symbol address".
> 
> Is there some Dump-capture kernel config options that I am missing?
> 
> FYI, copied below complete kexec debug log.
> 
> [1]: https://www.xilinx.com/products/boards-and-kits/vck190.html

Your description isn't clear. You saw the printing, then your kdump
kernel loading succeeded or not?

If no, have you tried applying Pingfan's patchset and still saw the issue?

[PATCHv7 0/5] arm64: zboot support
https://lore.kernel.org/all/20230803024152.11663-1-piliu@redhat.com/T/#u

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
