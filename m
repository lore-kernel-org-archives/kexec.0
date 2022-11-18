Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3A5C433FE
	for <kexec@archiver.kernel.org>; Fri, 18 Nov 2022 08:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SNxLdc7kbikdRg203DcA1k3dGrWNT7+nkauk+JNRxnM=; b=Q5yl4MDdj/Hcay
	kJd1GXc62/vOYsWSlN7i9sH2vkSyPmjOv4EPlYDsO6feRcaqC7HoWr+tx0cOfpPgVHeIkK5thYeAo
	AlkmSHJA61qkYJ2Zwv4IDqSywYCK6v9J1nFS+LqjlPSOi65G14KkpN8Nbgc/ujzXiVqmDhkrC3haa
	NDjVwLAiY8mAO4zpIK8DbdLzOuuve7jxgG+YQI5g/gKx65YGT78zCcqQdicv00MLfJjUIetP4EH+y
	eAW33rP+CM93/+yMhxLsTa9s1RKjSF5PHYdQ6s0tuF5D29b39IZXyaaPUE7udhaPOgq8jZhHYxLqO
	5VnXtgZQhYgCfNHv/awQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovx9p-002tt5-3m; Fri, 18 Nov 2022 08:55:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovx9n-002tsQ-IM
	for kexec@bombadil.infradead.org; Fri, 18 Nov 2022 08:55:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0BgaW9t8GFER5QecxVkFsHrVi3gO/4V5KAZgJaiRYBs=; b=FjMM6V1ozcYFu1kdJP/fq/PWl0
	4y00MaUg/1FZhnxQ2ACDq2VntddoqFD57KYzdat0fL4knXCWPZE+JF1zdH1QliuCk0lVJBFTwvqt/
	zWOj/okmMazapAbBVQBeFVmlSacj2H9Z7SboBQFcZPLHee/dQm2DVwi6JQbsAQNX4InemZMrax3TT
	fn3iARCnRiAKrLdm6zNRIumV5NmZQoJ+N850Qu33OcOBS8XAfqz3FP72VxSUvy8CqRNzDfQxov01v
	3Dygjr3kc0Vwm88l2LVi/Nw3ydBG/G+px8FRPduu9lAF2rxnXddUbw3Pp1KbmAsKDUMjqrYchB88z
	ODJ6E8Wg==;
Received: from mail.axisfairfi.com ([94.177.230.134])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovx9j-001vIJ-R2
	for kexec@lists.infradead.org; Fri, 18 Nov 2022 08:55:29 +0000
Received: by mail.axisfairfi.com (Postfix, from userid 1001)
	id 73B578288E; Fri, 18 Nov 2022 08:55:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=axisfairfi.com;
	s=mail; t=1668761710;
	bh=0BgaW9t8GFER5QecxVkFsHrVi3gO/4V5KAZgJaiRYBs=;
	h=Date:From:To:Subject:From;
	b=hvwgii88j7ooQ3Fo72xrei/xtyMLf10eG6/Y4rxJ621/j2kbfT9bgWVxilIbekQJI
	 9ANQyvUGKAF4GkjQciB6sgTqprAuZMf8SCc/udDd35EKEnWvyuWIkFn1LkcEW5G0+k
	 CjLUZLKA+hP8Em7LK7zLFPxa0CtQ2LGJxhNA8GcVViGUeQ4kJ/HYaQM4DYQv81NgDK
	 INIt6RiPbYhWOrroaxhucgTf+ut+PGFD2ul62znPLM0gckZcvHTmMcPB+2bcCv/80p
	 jqJnkuiQA4GPk8cuX/yxQAN71z3het5sgzcI0qtxHzBx4vhztZNVXc2yExERbwvlk0
	 WW+mY5Y/QNiNg==
Received: by mail.axisfairfi.com for <kexec@lists.infradead.org>; Fri, 18 Nov 2022 08:55:10 GMT
Message-ID: <20221118074500-0.1.b.gvq.0.7f4cn0rwnd@axisfairfi.com>
Date: Fri, 18 Nov 2022 08:55:10 GMT
From: "Zbynek Spacek" <zbynek.spacek@axisfairfi.com>
To: <kexec@lists.infradead.org>
Subject: Silikonmischungen
X-Mailer: mail.axisfairfi.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_085528_189647_ED0EF6BC 
X-CRM114-Status: UNSURE (   1.09  )
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

Good morning,

do you need intermediates for processing, plastics (e.g. rubber) or silicone mixtures?

We provide a wide range of silicone rubbers with various properties, silicone mixtures from renowned manufacturers such as Wacker, Elastosil LR and dyes, stabilizers, primers and anti-adhesive additives.

We also produce technical silicone compounds with increased resistance to oils, resistant to high temperatures and water vapor, conductive and many more.

We provide fast order fulfillment, timely deliveries and cost optimization.

Can I introduce what we can offer you?


Zbynek Spacek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
