Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84978C04A6A
	for <kexec@archiver.kernel.org>; Fri, 21 Jul 2023 08:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ETZ1kfszXpudeKkZKMFYKRUK25PUOuX/RL4SuK9LtWw=; b=uCL5zJRXwOzXkq
	TImpuUdM/WRB2kw71t/e9K5W7DikHm+hvJbnPXA2q/FTkFyNWuQ0iVSjwc5SjWzWTkPTgsWw2eRwd
	NUfVycNRwJEr5TIuPoBhmF9fUwrDq2OyeakLEmtVMZeBNE0EyFBKY8RNylXX8Jna236g6Of9VVSXN
	gM5jgjZU0EvyXvEgztcxfxRmK4IIP/Q8nFDrIMfKr2F7ZHXDRG6J8UrDEEENPa8J5qlRBnYmH8OeR
	AAn4Lnda1EsMKNm8V7C+IVSyQn6701kwsVz2zR/BYEsz533g++bOa+syMeF2zrTmwvBVtBNPrhXW/
	J6qRhGyn5XVIg1drJGAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMlOO-00DLSf-1u;
	Fri, 21 Jul 2023 08:21:40 +0000
Received: from [45.249.212.51] (helo=dggsgout11.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMlO9-00DLHF-17;
	Fri, 21 Jul 2023 08:21:27 +0000
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6jF462Mjz4f44Sj;
	Fri, 21 Jul 2023 16:21:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgAHoZT2P7pkhprcOQ--.24672S4;
	Fri, 21 Jul 2023 16:21:13 +0800 (CST)
From: thunder.leizhen@huaweicloud.com
To: Dave Young <dyoung@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/3] arm64: kdump: Restore the write protection for the crashkernel memory region
Date: Fri, 21 Jul 2023 16:17:23 +0800
Message-Id: <20230721081726.882-1-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
X-CM-TRANSID: gCh0CgAHoZT2P7pkhprcOQ--.24672S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyDGrykWr4UAw4rtF1kZrb_yoW8Xw47pa
	yUu343Gr1DJFs7Jwn3Zws7uw15Cw48Gry5XwsIkwn09rnxur1vyrnIqFnFgFW8GrySvay7
	XFW5trnIg3W8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0
	rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
	04iUUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_012125_626757_BB54A546 
X-CRM114-Status: UNSURE (   7.67  )
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

From: Zhen Lei <thunder.leizhen@huawei.com>

Unlike in the past, the low memory allocation direction of the crashkernel is
changed from top-down to bottom-up. As long as the DMA zone has sufficient
continuous free memory, the allocated crashkernel low memory must meet the
requirements. The allocation direction of crashkernel high memory remains
unchanged, that is, top-down. As long as the high memory(above DMA zone) has
sufficient continuous free memory, the allocated crashkernel high memory must
meet the requirements. In this way, with the restoration of the original
page-level mapping and the implementation of the arch_kexec_protect_crashkres()
function, write protection for the crashkernel memory region can be supported.

Of course, if the high memory or low memory cannot meet the initial requirements,
that is, fall back is required. In this case, write protection is not supported
because the newly allocated memory is not page-level mapped.

Because the original retry process is eliminated, the new process looks clearer
and is a simple sequential flow.


Zhen Lei (3):
  arm64: kdump: Allocate crash low memory in the bottom-up direction
  arm64: kdump: use page-level mapping for crashkernel region
  arm64: kdump: add support access protection for crashkernel region

 arch/arm64/include/asm/kexec.h    |   8 ++
 arch/arm64/kernel/machine_kexec.c |  26 ++++
 arch/arm64/mm/init.c              | 216 +++++++++++++++++++++++-------
 arch/arm64/mm/mmu.c               |  21 +++
 4 files changed, 219 insertions(+), 52 deletions(-)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
