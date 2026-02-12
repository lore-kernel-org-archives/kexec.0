Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AD1EB491D
	for <kexec@archiver.kernel.org>; Thu, 12 Feb 2026 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BVBtdpurmpISIWqOJSTlNhu6Q9/g7LJUy4KVjqUl2oA=; b=2xFWtOkTsbdPl5DZ91KtbN/XkO
	DoaGYSkapoE2RPdPHp412QqvCWfIxZi1Oy9/usrQkjg/OeOsbCPtg1F0Oryk8NcSJASEHbsk5sjqJ
	jIMMZ+JWsNWa7HCv3DA85K8TiUw6APdxpsBaBdi87cjQjKEs912s0uY9FPztzMHlI+OuxpmsyurK4
	vZHoThnT/Yjou3Yx/UvIQB2yKa+77BwiUye4ud7kixGPKQ8oY0Fl7sLqYoveT+W1f0ZyLXUqrw+TS
	+FtjOHur7zuRvabuom0mgNvuw7blTPPZps/Eb8ItZlq4RJJ+hZ/lyP/vNHR0y4lXtETnbHuDJRCdL
	SMn1u+Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqWIn-0000000275B-1Gos;
	Thu, 12 Feb 2026 13:00:13 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqWIm-0000000274p-2aff
	for kexec@lists.infradead.org;
	Thu, 12 Feb 2026 13:00:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B28D3600AD;
	Thu, 12 Feb 2026 13:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C42C4CEF7;
	Thu, 12 Feb 2026 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770901211;
	bh=O5e7fgGGsspQKmJs+VnIOdoxwBywu0PNxcVSDMoHR1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MAiS7gpRChWMkBleP0fbfSBAS5JNHzbs5ICrudjJXMMMjh4MHvlq5PemVLmqQ4MHB
	 b/MDSCX1rfLU7xJFGa4SzX8vukk6y1M57V3/A1bYZEV56rPQTOl6Pn61Qz3VsgMYQu
	 nEsqFt3UOaAMRljHco7HCmC47DuKsNfJ7Ao929/JTI1OfGC1RqR0sIv38NZyOH8EGQ
	 yLoo+35f/z5nYObdiNKFaHIsop4GYh2OOg12HNiPuUfg7GxWKB+PQEaI9q+LNzDMqE
	 tLyz3+5ZgO4YszChx6U1WAhW/dc5SXOXX6BCSQZGex85g+eELXTgP9pKJY2qP+wl+0
	 N78Y17TCV6Vlg==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: graf@amazon.com,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  akpm@linux-foundation.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  ran.xiaokai@zte.com.cn
Subject: Re: [PATCH v3 1/2] kho: fix missing early_memunmap() call in
 kho_populate()
In-Reply-To: <20260212111146.210086-2-ranxiaokai627@163.com> (ranxiaokai's
	message of "Thu, 12 Feb 2026 11:11:45 +0000")
References: <20260212111146.210086-1-ranxiaokai627@163.com>
	<20260212111146.210086-2-ranxiaokai627@163.com>
Date: Thu, 12 Feb 2026 14:00:08 +0100
Message-ID: <2vxztsvmqfqf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Feb 12 2026, ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> kho_populate() returns without calling early_memunmap() on success
> path, this will cause early ioremap virtual address space leak.
>
> Fixes: b50634c5e84a ("kho: cleanup error handling in kho_populate()")
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Thanks.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

