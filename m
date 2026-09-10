Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CD0C88E42
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 09:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TETpEQSBazyu3WU9EzA6S7Fuo4OZmYrVUZduaHo9NxY=; b=QNK9HU3sgeb1CADv5e6+a6tt03
	dpLRZU6x3JlvpsbO0/92hmQKvj/9nKVLsMfBaqfOxEZOGECa7hLjPAYqHSd9SgFZxaccmBfPatHvA
	sdJP32/YUNNhE3KcU+ShOsyP9qQiseCthJO6Mk4lwCLz3yD959AQ0rXZf9cNyIu1xJCmNsd2vC/NF
	FU3XoLjYDVeCqnDaFNkBG1d7A82jrrhjHPQS4B1qYZkVZCJH1VmiL0JBcEVaLh3twcg+PFVq6EGo4
	vMaBtaweeJGpCzOLg9UEuYPSllH2cvJt4i9NE2vKg2ESlGsle/lh2KTh/hPU2qcTXSG5v0DdDlEfW
	GLmE6dfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4bQc-0000000DwBh-29dO;
	Thu, 10 Sep 2026 09:50:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4bQb-0000000DwBA-0SP3;
	Thu, 10 Sep 2026 09:50:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D70843876;
	Thu, 10 Sep 2026 09:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39FE1F000FF;
	Thu, 10 Sep 2026 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033844;
	bh=TETpEQSBazyu3WU9EzA6S7Fuo4OZmYrVUZduaHo9NxY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Lrmn4N9fA7xxEfXhhqevBTEJ6tLHSJw7+z3izH0+ZfTLJ5CtxSYdo5etGAxobiixj
	 klaXd6b4oSLXLSR090imvTEv8hLtMSu4P7rNx4ARrYjc4mEexM8pjh5PFaTNImudI+
	 uAe1CjkyK6jLBEQoQweXaJSFQM4oTwVpz1xXWCKD3Sp/4h0F67mV38XSekYJ0KOI50
	 Vn8cdvcfvAicDkkqCMHSvLtO2bGXU6LkT75N/+CiWrczrv3YX/cOUCziOcuyJl6ic3
	 VkpAwh7xlSp1vc7zOMKsSAUqisCi8tYmvrD7NuClS4w8Xw+95LgbJkRFhEB/Dyp2en
	 2mf2VHFOQZ8Hg==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, Paul Walmsley <pjw@kernel.org>, 
 Pratyush Yadav <pratyush@kernel.org>, linux-riscv@lists.infradead.org, 
 kexec@lists.infradead.org, Baoquan He <baoquan.he@linux.dev>, 
 Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20260905145835.501635-1-sourabhjain@linux.ibm.com>
References: <20260905145835.501635-1-sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2] kexec_file: remove unused
 arch_kexec_locate_mem_hole hook
Message-Id: <178903383428.3691424.5770723322056518060.b4-ty@b4>
Date: Thu, 10 Sep 2026 12:50:34 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
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

On Sat, 05 Sep 2026 20:28:35 +0530, Sourabh Jain wrote:
> kexec_file: remove unused arch_kexec_locate_mem_hole hook

Applied to kexec-7.4 branch of liveupdate/linux.git tree, thanks!

[1/1] kexec_file: remove unused arch_kexec_locate_mem_hole hook
      commit: 06ce2863e7d28bcee539b90c87960edda742fe18

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kexec-7.4

--
Sincerely yours,
Mike.



