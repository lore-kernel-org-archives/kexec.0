Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1729C6FD1F
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 05:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	Subject:To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mg/2AJ2dz5oa/5/DlsLrCxbPEdnPm5lN7SAMyPFhQWk=; b=ugbH21BJ6/Gt+3
	nx+4GC62eDwZ9JQ1rzHzghBvhYPiVFsjHe/r4JLiTuvAiYIRl35fyw7uW3Zrfj/VhhNyoAPfkmgk8
	ytk5qq0ORhJiGSKPUk0cMUDwzwVSba0soORY/3IqFdQEJbTq+HhsS/0ddpbMqQFYoerEBSEvwGbqb
	Ho0/Z0Ddpuj+eIvPOu26+t2zY5zKkqljll4VXjyBcOwjEdgLtI5fwT8jBMZsPGFRJcn0TctlzBrMJ
	asiq9noCckVB9A8Pq4dnBn4gR0VoTdPRsJ8rviBaeUZiPphmMurfKWx2SDH/eWgC7rTdQE9/3G7HV
	e0h9JgevjnER40r7pviw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbxV8-0097S2-MR; Tue, 14 Mar 2023 05:47:10 +0000
Received: from [103.30.145.160] (helo=defaultworkshop.klidefectmanagement.com.novalocal)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbxV6-0097RQ-30
	for kexec@lists.infradead.org; Tue, 14 Mar 2023 05:47:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=asda.co.uk;
	s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=CUnUapyHbG5DSlIkstpGJe2p88YppvEIAg//5dTj4cc=; b=Y
	jPU7PlOK2czjF335/vZvQ1pMBVm3co5oNUoqeEMNoh9/A8Fls4rZkCsEKpGPODnl4M9KgRpH1cOxC
	blCxyaNnuUeCbo7K2oCk0OVwOy/sOZHTbEZxGZLU9D67hzEt/ykr86h7NxuNDl6Ya/kVK6KClCx5w
	vr2Y6FMzC3L5ReTM=;
Received: from ec2-52-11-215-80.us-west-2.compute.amazonaws.com ([52.11.215.80] helo=asda.co.uk)
	by defaultworkshop.klidefectmanagement.com.novalocal with esmtpa (Exim 4.94.2)
	(envelope-from <sales1@asda.co.uk>)
	id 1pblws-0005rK-Rm
	for kexec@lists.infradead.org; Tue, 14 Mar 2023 00:27:03 +0700
From: ASDA Stores Limited <sales1@asda.co.uk>
To: kexec@lists.infradead.org
Subject: First quarter procurement order/enquiry
Date: 13 Mar 2023 17:27:02 +0000
Message-ID: <20230313152049.AB984FFE9A5DF9F0@asda.co.uk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_224708_195044_046AC6E3 
X-CRM114-Status: UNSURE (  -0.47  )
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
Reply-To: sales@asda-c.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Dear kexec
I'm a procurement manager  with ASDA Group (the owners of ASDA 
Stores) and your company product has caught our interest. 
Therefore, we request you send
list and prices of your hot selling items (products) for our 
evaluation/pick.

Soon as we receive your reply, we shall send you our company 
profile and buying proposal. You can also check our website below 
for detailed info of our purchase area and trading capacity.

Your immediate response E-mail:  sales@asda-c.com   shall be 
appreciated.

Best Wishes

Ms Stelle Montgomery
Purchasing Dept.
ASDA Stores Limited
Tel:  +44 7418367220
WhatsApp: + 44-7502985874
Website: www.asda.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
