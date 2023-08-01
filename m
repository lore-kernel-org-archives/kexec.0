Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7436CEB64DD
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 07:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZvBO5hY2AHZExmtUcQRmHSTgverBlLgyQ0ngklU12KM=; b=B6d7kuv8CvyvHn
	SOFZ4SinwKuSwPO4IaUosfwyslLsLYwNIeWOTIODYr81oHC2j87HkHhsyZjAsZLb22epJY0lhC+yD
	1ShgU8+WJtWtjzIi0rNTjETjTfr1M42OFSP8RYqtUm9R250E+AT84qAHPkpu94S1c9CelPHl0YHbC
	oMYgWTYGtXX9RfA/PF5hAYQ+1TO5+pWl2cYYplDEIriPEP2EwjS9D1usJ7MEiQJFGAV3Zda1XTt6K
	1HeEuMwpghneM+6maNsZEhTysY8JxoWyTpuy5FW4Wurbub/NUARE2I3opMGyPYnPk1hPrQiPobVp9
	+Y3vm5XTckBQTzgpBh+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQjNA-000VoE-1W;
	Tue, 01 Aug 2023 07:00:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQjN8-000Vms-0A
	for kexec@lists.infradead.org;
	Tue, 01 Aug 2023 07:00:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 502C6612FB;
	Tue,  1 Aug 2023 07:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A945C433C8;
	Tue,  1 Aug 2023 07:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690873244;
	bh=pfCt1+dS9bkLEcPLmEWr+EA9pE3dxjWWj6bK/HAuOgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSne1kK+eantM8XXU2VGZJBxtVlRhHy4I2+1U+JSDzJldR3jW7FZvKsZdBwwwfAoY
	 7ikCS70Q5ziTL9bWECEJ5Z4yYl5xcsPQ7TiU6FVAxxYf+y2ile4QokM+PycZMBt6T+
	 7mfIEwIiQFi27zxxS0PUxC0yt/uumzwf3a1Y5YuSrVyF+iu5vY/bZSe2B9p2NJZNV1
	 I14ha8BJoTlRtIzsi8+7BmNgRdh0VRXvs1VIQ0jkk14sYLPkJgaVVGTPWAy87VeJB4
	 qxEpJySsyWhLYPvskNSkQWjw67uamUwhKH2iigglE2OysLnhad4kfy9MjcDgLZhSWb
	 GdeF3pdTrmfSw==
Date: Tue, 1 Aug 2023 09:00:41 +0200
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Jeremy Linton <jeremy.linton@arm.com>,
	horms@verge.net.au, ardb@kernel.org
Subject: Re: [PATCHv6 3/5] kexec/zboot: Add arch independent zboot support
Message-ID: <ZMitmSZPqnH+/70s@kernel.org>
References: <20230724022142.6425-1-piliu@redhat.com>
 <20230724022142.6425-4-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230724022142.6425-4-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_000046_140660_28E5B52D 
X-CRM114-Status: GOOD (  12.79  )
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

On Mon, Jul 24, 2023 at 10:21:40AM +0800, Pingfan Liu wrote:
> From: Jeremy Linton <jeremy.linton@arm.com>
> 
> The linux kernel CONFIG_ZBOOT option creates
> self decompressing PE kernel images. So this means
> that kexec should have a generic understanding of
> the format which may be used by multiple arches.
> 
> So lets add an arch independent validation
> and decompression routine.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> [Modified by Pingfan to export kernel fd]
> Signed-off-by: Pingfan Liu <piliu@redhat.com>

Hi Pingfan,

unfortunately this causes a build failure on hppa.

../../kexec/kexec-pe-zboot.c:31:10: fatal error: kexec-pe-zboot.h: No such file or directory
   31 | #include <kexec-pe-zboot.h>
      |          ^~~~~~~~~~~~~~~~~~

Link: https://github.com/horms/kexec-tools/actions/runs/5723580523/job/15508425790

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
