Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2898CD5BB1
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 16:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HsdW9LaIbycHjvJhgWJNxPtg5fqLkG+dKkTc85kX3Yc=; b=eGTK1+8AjV3zoGGhd7Fojm2pj2
	6lc+j+OW5nr2Imgy3Xzj1YG8N453bC4/iAYBERrZIQ5D4OX+l1+Ujim/YjyLerPPUuZahIKOeEZ1x
	PXJHyBt/U0jOtMvb5Yo3AZaFIYTKTf+CtHXmQTbFAK3VroxugSpjSKJdAH9IjGUfhg0FMLlFcMcH+
	xISi4ddo4KEdvQMjgW3m4f88PfJc5oJLwyDz24YcxM8Xccw3dmKhAefg8K2AeJ0BpbVEpz4uC8NAj
	KFsm4ZNMSaNUIjgPxqbjURn05gfqUNIccyz0yfKCrFJFpsSFY6okzIpAue7+4UHlfVBFRQF6xRisU
	vbCd7OzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRY9Y-0000000012o-37Fd;
	Mon, 25 May 2026 16:27:44 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRY9X-0000000012e-409k
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 16:27:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5963F6008A;
	Mon, 25 May 2026 16:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A325C1F000E9;
	Mon, 25 May 2026 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779726463;
	bh=HsdW9LaIbycHjvJhgWJNxPtg5fqLkG+dKkTc85kX3Yc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fDqfQFCb+eYFk9xywS6U4h2pRlFR0jCbXLZUn6U4B4boj4uEg4X+4Fw08pozOuqAm
	 5uMrvrvD7eSQZgh715hfz8YP22Ed6d8DdlB8VArKNPEeCWBK1+l+XNrhxxMwVbWgE2
	 AYwYlcPS7UhlgWlXE3dM/JcMa5rJ4bw1SG7eEybeuQiwPY5xZV7xNo/dOiX3MmhOUV
	 1W4FzU0kU2rlKRdhiifFG8Z7USHLqq3jxqyJe5KWiYkfBPbWMBKRxZiKdW1oiqbdy2
	 KI4ojdsWS848YFWYatTjKp+lVhO36l5hEUI3uLlB5k8Sp0vN5CeYhgfRc0+Gm5V/Sh
	 TVa5FYTXpNitw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v2 03/10] liveupdate: Extract
 luo_session_deserialize_one helper
In-Reply-To: <20260514222628.931312-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Thu, 14 May 2026 22:26:21 +0000")
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
	<20260514222628.931312-4-pasha.tatashin@soleen.com>
Date: Mon, 25 May 2026 18:27:39 +0200
Message-ID: <2vxzy0h75u9w.fsf@kernel.org>
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

On Thu, May 14 2026, Pasha Tatashin wrote:

> Extract the logic for deserializing single entries for sessions into
> separate helper functions. In preparation to a linked-block
> serialization for sessions.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

