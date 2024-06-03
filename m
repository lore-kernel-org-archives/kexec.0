Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2E5C25B76
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vm5pkaILmjPbWemtJmlGp2rC+XTgHeKJb4HtHz6MY1o=; b=yvWU2LU8UWvznT
	2lZI9s+O9TIwpfR5KonK8LakbCKE7euWrZyU6xPY5t1WiB1leDAC861iu7JxmniNcgzB+W/MHpl0S
	Jnlc7xeoCHnhMplVS7ikUZQrOmJfzv+WtDfNIWJmxA/MV0Rn0Z7tfNrLSWiUrtDiG23r5tOyZtcRe
	DwbGCtlxex27VPI07kZho4aVL3Z2PQ0beQJ7/NuuAG5fn1MQhPhFvwoiVq/BCELXLhZjU9oP5UuJM
	uxe2UVwi3kxYY3ioRi1sLdxp43Z4cFw4/NFQ01GL0+nAWRAS0MjB+DHcf+2OhrO/6XUl0NAH5/Fqn
	MpERWvb4adXBOC4WV9gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEC4D-0000000Ha7e-06p6;
	Mon, 03 Jun 2024 18:05:57 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEC4A-0000000Ha61-26gB
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 18:05:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id ACE04CE0E9F;
	Mon,  3 Jun 2024 18:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF0EC2BD10;
	Mon,  3 Jun 2024 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717437951;
	bh=Dy+lf/3b6dIoc9kvOoHlNf6GzHpK4tZ07CGvpZt/z8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTMEk4cZmYjHdVYOHdszyfpnRLwl6VUVwvKFFqZTitx8zrGmbawppoMCAkkLJ+Jz7
	 k/qtpG2UYlBeLZZXlQMSJMyq7ayKZjuvCuVdzDD/LclT/4lIAG7IHD+JcALEnidIFq
	 ZLyT81laKAvJEpIIJNMLNiFQX4GRFosW1ntn67AiKp7I6LEOfx1jXp2DS2TFYHno70
	 gDY5E+BVWImGN/lH08xrGc7an8Zahpe99lK8ARlqr7+yfYNh++/6u9uIBe0BPkaoty
	 JBul48zToTeTw5gll3R04pFYLU4UjfEOCxZ6TJbLMBeN4+zP2IVKQPZ8mrGYfJcOjq
	 uDXrRqewX41GQ==
Date: Mon, 3 Jun 2024 19:05:48 +0100
From: Simon Horman <horms@kernel.org>
To: Ming Wang <wangming01@loongson.cn>
Cc: kexec@lists.infradead.org, chenhuacai@loongson.cn, gaojuxin@loongson.cn
Subject: Re: [PATCH] kexec: loongarch: add multi crash kernel segment support
Message-ID: <20240603180548.GH491852@kernel.org>
References: <20240520013241.3787014-1-wangming01@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240520013241.3787014-1-wangming01@loongson.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_110554_753105_A6AFF922 
X-CRM114-Status: UNSURE (   6.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, May 20, 2024 at 09:32:41AM +0800, Ming Wang wrote:
> Production kernel may reserved multiple crash kernel segments, like:
> 'crashkernel=4G,high crashkernel=256M,low'.
> So we should pass multiple mem=<size>@<address> parameters in capture kernel.
> 
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> Signed-off-by: Ming Wang <wangming01@loongson.cn>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
