Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553ECC433EF
	for <kexec@archiver.kernel.org>; Tue, 21 Jun 2022 11:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	Subject:To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=83hFnUG3neCO6ZmVECasvvn+RWDWhLUTbr59M7KRu1I=; b=BLw3ovTvAmlHPq
	Ba8OB12mtzJDhKAkSmGNClddJp+Ev1/uSMXSq8+RZVBSusPeSUKBqAQBvjyEseKTRZlv6ZKegDSN3
	zI064Q7aBOubjzAOYHbloNJfQdKJHRII1Lk/bXn14jgTj+q8tty0NkueB1LdlvCukPidPzyjiXInE
	/Os23jm+bGhs3fQACeYTPFm8aLd10cZ13tPqWQELPYlMxMdlmMiWpNHC3UIS6gKo6X78PR240xi3y
	VkBPnFG4gUcfvvgI6nZLqAwNwRDTuL1cAGcro3QX2Pjf1z5ujphjyx8FE6/nSM03kdnPzfVA5wuyd
	KyW8U0QW6qJtvj2LkOTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3bhx-0050gd-FF; Tue, 21 Jun 2022 11:06:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3bhw-0050ft-00
	for kexec@bombadil.infradead.org; Tue, 21 Jun 2022 11:06:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=uUZIMU47P6dJU2wQrlHidzKhjU0X5Ew56yOxpmDv6FA=; b=bB2Ya4u00+D5EHRmX+PNterCjQ
	tPiUOzGaV5gD8WQE04bmkx3kPFYK2c37GnPduAbHzFoTl2d11vNabASKFuem7QGuZYeP9qd8YJr+K
	aajH9tARKl9QFyHRadjOboEM6BXXkrmZmb6q0FOM9exRDT5HxNai53r6e6GJNiJw5zZu6LVFfyOo/
	NYjYlpwcVtDkPjgKRMEiGuW2JrIi262wmfDwpNRR5qUOnMR7tHD4/Yk9W0PsVcNBJ50rdQjkHMVEx
	7GfFBKInAbsBL7j3iSjG7dVYG2wwCXCmVsuSRcZNk72gLPHByjA0a2axjigWRejWraECi8G2Ls7EJ
	crpnU2qA==;
Received: from static.163.53.161.5.clients.your-server.de ([5.161.53.163] helo=quickfundit.com)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3bfn-00AJoB-TT
	for kexec@lists.infradead.org; Tue, 21 Jun 2022 11:05:16 +0000
From: "Quickfundit" <sales@quickfundit.com>
To: kexec@lists.infradead.org
Subject: QUICK LOAN
Date: 21 Jun 2022 04:03:34 -0700
Message-ID: <20220621040333.5DFC8FC70B4CCFF5@quickfundit.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_120447_776772_09BA3EDB 
X-CRM114-Status: UNSURE (  -2.13  )
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
Reply-To: info@quickfundit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Have you applied for a Loan before and been denied ? Do you need 
a Loan to start that dream business ? Then worry no more, 
QUICKFUNDIT https://www.quickfundit.com Offers Business loan, 
Debt Consolidation Loan, Personal Loan with a 15 years repayment 
period at the lowest interest rate of 5% for small and big time 
projects/businesses.

We offer loans ranging from $10,000 (Ten thousand Dollar's) to  
$2,000.000 (Two Million Dollars) With six months defer grace 
period for Repayment.

We've developed a lending program that makes it easy for us to 
meet up with our clients' needs.

Interested Applicants are advised to contact us via Email for our 
application form. info@quickfundit.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
