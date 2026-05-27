Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08583CD4F54
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 08:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=23tNGzKufb9LUZc/tsRFVwpewXfb7+y8vSwqWTbtWSk=; b=DjlD4u76/nBN0JxzddHrq6eWcY
	jYQlWbdYSWt5IrKoyLpWADr2e3V865fR2DTZ5I8XTSIN2C/v6metZfTsiFZxGw615/l3wU0u7CvlL
	QiZUgnpjx11iha3p094UwgeqEgHe2o522Anul3ljfSR+qIi41mt5L69QriD1n9auisAyMEyu0RYBd
	ZY+2tUjDMZBjeS0Vq5JaqjkyN2nw1MTd4UXYkimTsj4oDqMvgGWvWP/8XfY89euyFEuXHTBaAwXfg
	3dGbeQoVBqxkaztix+P/Z0PlEan7PBydACYiw5h7r3Saa3d4ZhwFaSDMoKh9JF3VwcIPF/FpboOZU
	Pm0XdULA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS9fG-00000003Y60-2DIG;
	Wed, 27 May 2026 08:30:58 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS9fE-00000003Y5g-0E8T
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 08:30:57 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gQN9n5B5fz5B104;
	Wed, 27 May 2026 16:30:53 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl1.zte.com.cn with SMTP id 64R8Umr9014294;
	Wed, 27 May 2026 16:30:48 +0800 (+08)
	(envelope-from luo.haiyang@zte.com.cn)
Received: from mapi (szxl2zmapp07[null])
	by mapi (Zmail) with MAPI id mid18;
	Wed, 27 May 2026 16:30:50 +0800 (CST)
X-Zmail-TransId: 2b096a16abba25c-41f3b
X-Mailer: Zmail v1.0
Message-ID: <20260527163050630HR4Ri1nkGfW93wsEmfqOO@zte.com.cn>
In-Reply-To: <20260527072709.GA51310@horms.kernel.org>
References: 20260521120643491yZJMsKq2fLbFcvtV5ukN1@zte.com.cn,20260521120946097C8qpZkVC2mBT_ozYEHlhp@zte.com.cn,20260527072709.GA51310@horms.kernel.org
Date: Wed, 27 May 2026 16:30:50 +0800 (CST)
Mime-Version: 1.0
From: <luo.haiyang@zte.com.cn>
To: <horms@kernel.org>
Cc: <kexec@lists.infradead.org>, <zhang.run@zte.com.cn>, <cai.qu@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NCAyLzRdIFJJU0NWOiBGaXggaW5jb3JyZWN0IHZpcnR1YWwgYWRkcmVzcyB0cmFuc2xhdGlvbiBpbj8gY3Jhc2hkdW1wIGxvYWQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 64R8Umr9014294
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: luo.haiyang@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 27 May 2026 16:30:53 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A16ABBD.002/4gQN9n5B5fz5B104
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_013056_242472_717D2723 
X-CRM114-Status: UNSURE (   6.19  )
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

SimonHorman <horms@kernel.org> wrote:
>On Thu, May 21, 2026 at 12:09:46PM +0800, luo.haiyang@zte.com.cn wrote:
>> From: Luo Haiyang <luo.haiyang@zte.com.cn>
>> 
>> The kexec shows the following crashdump log:
>> 
>> Elf header: p_type = 1, p_offset = 0x80100000 p_paddr = 0x80100000 p_vaddr = 0xcff000 ...
>> Elf header: p_type = 1, p_offset = 0x100000000 p_paddr = 0x100000000 p_vaddr = 0x80bff000 ...
>> Elf header: p_type = 1, p_offset = 0x87ffff000 p_paddr = 0x87ffff000 p_vaddr = 0x800bfe000 ...
>> 
>> Obviously, phys_to_virt returns an incorrect virtual address (vaddr). On the RISC-V architecture,
>> the linear address mapping is defined as:
>> va = pa + kernel_map.va_pa_offset (kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base)
>> Both PAGE_OFFSET and phys_ram_base can be read from /proc/kcore.
>> 
>> Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
>
>Hi,
>
>Unfortunately this patch seems to be somewhat mangled
>and does not apply. Could you look into that?

Seems something got broken, I've resent the patch. Could you please see if it works?

Thanks
Luo haiyang

