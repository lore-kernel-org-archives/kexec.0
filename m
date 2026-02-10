Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26F3EA8115
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8WjuB1ouym1wo/KEjTHENRCgQ/UfyIRZH7SsAgVNj+I=; b=0mbChu8O28flp59lvy/lkCjSis
	zZvGYJyZ4I2BKDDe20yLJA/3aJGYCdyNsaAxLmtUEkFCYvumbMTCjEVUi4wyFrHG91HSvjhAv39oK
	cBzX5Guz4em1zxbQLfpnbQshbvcWJ9fOQn4rgSfkQS1M/T481G+i1zLnFuZSeSN9rT7CMLEyt+eLJ
	c8TQk8YhwlSwWasukgP5FNOIBLdNbjcuF3EnC+JKNfZKynzxeV7AlYbd7joVYmquH9WHwGL9RgUz8
	qxF/kIWL3UWQfnZlGhQ/B8ZiyABmjTLdnsdDZJeYj/hcn8xSBjtBJA0w+L/mktSAhyzesI1V80Lvu
	ia+BYLMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpo3Y-0000000H0Xx-0twB;
	Tue, 10 Feb 2026 13:45:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpo3V-0000000H0XN-3vNT
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 13:45:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A8D3439E8;
	Tue, 10 Feb 2026 13:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B7AC116C6;
	Tue, 10 Feb 2026 13:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770731129;
	bh=UiB4cdtuv+0naMTeccJX5N93CPAw51/JaqNcoV4zvQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c+FNjQ/k6DxcaBj3u8nCXsgF+qR8qI5/JZNA+al9t07HxZPquukG6/3JTaG/GdUf+
	 0mpSuXjS9hPiec/0YhKAfDeVk/b0Lma8BW5FObxZDhilUcfn+HL4cPRoyIHawxFBYD
	 5JDUXg2sgnOnp9M4SzAHJWx8MwdmjJdssl0G5BCiWm/A2XpX1qlMJq7N8Smg4fpoZV
	 OmNEdZyoweFmJDZKZfAn6lQq+TrSyJtDBmAOj9ES8YXBFoVH4Ed05ei01a4t6pMpN/
	 6fJQO70fK45+mbWpwMjmEH6t6W6sxXY1NNT1yV7Hof71+nk5PISIS6zYVpBb7RP7Mm
	 anRL+9IZrNLVA==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: graf@amazon.com,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  akpm@linux-foundation.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  ran.xiaokai@zte.com.cn
Subject: Re: [PATCH -next 2/2] kho: remove unnecessary WARN_ON(err) in
 kho_populate()
In-Reply-To: <20260206043121.197564-3-ranxiaokai627@163.com> (ranxiaokai's
	message of "Fri, 6 Feb 2026 04:31:21 +0000")
References: <20260206043121.197564-1-ranxiaokai627@163.com>
	<20260206043121.197564-3-ranxiaokai627@163.com>
Date: Tue, 10 Feb 2026 14:45:26 +0100
Message-ID: <2vxzqzqssoeh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_054529_996241_F4E98871 
X-CRM114-Status: UNSURE (   5.41  )
X-CRM114-Notice: Please train this message.
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

On Fri, Feb 06 2026, ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> The following pr_warn() provides detailed error and location
> information, WARN_ON(err) adds no additional debugging value,
> so remove the redundant WARN_ON() call.
>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

