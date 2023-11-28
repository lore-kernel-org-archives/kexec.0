Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B469C4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 23:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VDbPkQxplJmxplne8oz1XooiyQ5x9QhSBu6+IJ3nzQY=; b=4mPRO28RBDXthE
	zSvsn2gnt+yH7S2NMPfE1B461LszRpeU9oYwRM5ZvAwGw5xtMDaeJFyzdQKx7YbTQuyyd5ah7KaFL
	5ulwn4eOS9viJM9CP/n5jwSJfEhYU58OxzoUf/UIMZxKeS9M2birc+VuSsPEgmvXL7vKz/rIud6N6
	TOzGDBBjeLVsAsKW21gji5k7YoaAx7+IRTf44kq0l/AUq22uoJrHkQtkn8bVGBtS/BMAmCQI7BFuF
	VUAd8aTA7f/kka2Ua8RlCj07eIN/TKLaGxq1x+dloEFpII5vPH4spaI8MlCbiDGv3f1cTTo3cnD+1
	HnBYRx1i5K5h74C5XYBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r87cV-006bcv-2k;
	Tue, 28 Nov 2023 23:35:59 +0000
Received: from sonic311-25.consmr.mail.ne1.yahoo.com ([66.163.188.206])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r87cS-006bbb-2n
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 23:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701214553; bh=Bc2KPXc7blYbEIDH86NzFbr1OPgQO8AjJMQ2HT74sw8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=U8h3fdTTKnh+tXKLfLwQKQgTMI9wurO37bVvF55+JEJFCIVO6Ozbbt70ztL/yRGGJHixf6xsNGyA/U7xG6H/jvNn2j55bWWpcMJe6TYLWnVU8Da4oSeB07OoLmpETZ6Y8bTtJOj7501/G5yF7hRyO4kEgtR1r1YwPgoEX2tpbAJ2A34B1/75sZCxvK98+rMuMNLKCUpYbtDNysmB69uLYbyUaqYVfRqDylKmdvR1JTLXOk+x62cZDijEFhrp9KUauon19j/BRAryillnkYNtckh5pTsPIjOzYakrGseh+nDhp8AJpUMfRTxRu3XlDjTEKnBfZNIDAe3HQ35AJsdDCQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701214553; bh=K32rrAF69yY7Iy9z2Kv0/QJMEMfNSLJetrav4zXxl4Z=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SDXdiLzLZLmoxFq3AHjaPJ7mlvheK5PbAv++xCnOsjDb6S8tw9RddiiO/XiO9WiIRym/mZoYJDnSwFlggEyZNldBpbUCUlQsQmmXvdz/nh2xiXPYBkpFUgU+zohzILtMqxMsXEheL36iJE5IrAm/L3RJ4imklNl0Hjlw9HF5YP5GcoT9IHI/ngq0TP5eThoxgaUaJu4Mea1qTGstCv9SqVHZeuDV4bPCoV7KWzlvsThth2R/N5Wl7QYLFH/ao6YO2yfZnB9OmVfyjKQNQ6TDxnQfXRpZvAtpOETDWI5Uup9JI/q1lksvoKrMS4Y3iyC+h2mnYES3QeLOZ5LTcwEwDg==
X-YMail-OSG: L.Ba3fQVM1nV9KEPQyqyTD9L_c40CMec37f2.y7YZX3p2FblIv6CukH5rWUyvMd
 KWVBoO8JgL8Imz76eF18fXxNJMOj8Gz1tJYT.VxXyz0t85I_hN_NYQsMl4raleUF8JmFzBRnE9py
 gorYwUiQvamqthkR5b6zKNm2i8iZKDkmIeVM8m_NoiG.q.jpHtMRQbBV56j6Men5XWivx43PX1ft
 sEmZOVeM9YJEYd2P8DPmiTLUzby2_LzOgbtE0oz7Y2Me2OhIfpuJ9ELmSPnOsQEVpUGaA18WqkI2
 uZMWRx7I12D65GIhM2IPWNvOedexCu4AbDyGdTWEgSb.oMaLPmQYUpytHKTwN0F969IM1HhT8j2L
 jOtDn103V3PM7KgHevaCEZkLRqW9A5l4sMQc1gOLczWY_jM1umz7qjdS2wSwXx_PDGIM1SvSlcve
 QVyWZHN98a5FPL5QkJ2HH8FdOhEm5KEofsWlduDCgaoJjVmWSoUE1YBpNgmCIvNpjqWu1w.q.6Sb
 5wmKx1kXLu.L.2XmexMwwMaRZeiT3Rug0PuHoNH0exG3M5.Jl_QidEClX7gN7GA79KLycPcumE4Y
 f0cjNF8yjJBYVbvGLU3ubZOb5OCZQ1.CLT.CLDzQcPLJ7ozIQL1jK7Og_wsmFkteJAKKdhyA9keM
 Gnbb_hXQewCwpDqxVCkWL.nC90nBIiXAXB1eOMBZdRM_GZ4LzPxbH43lPbQvNxyW1nKQ_U.AbWA.
 QDP8PugsMnQpmx6GJS3u3XYgsmN5HtZlBr_RfNBWu7caMs8RlSSYJk9I7qSeuQnh2Z9zRjE1Y1rY
 W0qDe2WikSahVq39BcCwjtThH6ILodqtQkEkXeLbLsZToZQv9DlKW4zpI67QiI.RUp55TimN1tpE
 OLF_jtUjJ2.W0YBGDt35..4Pj94aHLpi8CCjGnDyxbpBpMGGTS0Vv4MhXUMaW5xukkgfBD8DDC4o
 FPW6iF4HZq.WFMV7OTDG2WzUSf5OIOoffF275q2DkxAY0hX_jOxv7j8PROOo7uYEWHl9xkWBA4UX
 iZjldzX0AIbiI_oU5tqxALYaoJ04i6fg.2AHmvM3swmezyjYIXvvYVwirRzQo4AU2nnde1JOAJNs
 F1G2hxIPNm9KFYcGE1znH.F5JJN1irrgMjypBnE9m5NNHh7_DDhkBu8QMn43dYKeXAn8YPnj4z2f
 J6U6hJPSubBaOSB.KMgsn3e3g0UopS86IWdmgjGfjJwzTetDCIZjWXHPLtM2gpf46BBd15.nhgno
 zj6DWI41JA7UL815Bh60.TlTnW7zMzX7RtB049oSd4cjZabejz0Bjmypo_FzIkad8SlRQ2j41HS4
 nIdpg8iuRDg8VvcWMnJ4th44ZVkLA8CpJJxFC4TIrZb.Kgq.2wPGPPaShvoda2TRRXj5iiNTCEsk
 vdyhmdj7KTtrJ.7kX_yTON55rIPKUwxM34a8mTh3EBf4HdeKyt0q6hHk8PHmpxGXNmZMABadD8aN
 RpgrY.FAWA6wi9AHbnyJDCt064vbEvmWKlSmfY.DtxIjQd7tlzjbjugMPGjLysReCDHKHrBgusOM
 6t34GOZgQZUFXkz1CqChX4ZsIhgVtuyMAsmvCw_nSsQcPH5nBcjvBJ4peYAjIbbY..DEq19ee2Kk
 uuLgMl0HaqSrLCDh9mwTztN7AKIKUTm39v1Ea9IPZ3jOyUNVvaCpC2N_PUF6zmVKoyiDrNAyO_4P
 EFXhYGmj3J.s.QQ9oIkXE0gnMg09bz9lUNGfosvRw2yPcelCeKq.neE836NhPfaBg.4hdpQRFipA
 chs6LYawiRUg3Oli.mZDtGsDqC6t1exl4DNMqwe9orq_m.1zTY0hH9OmkMWQzKNpM0Ev_J6HjCUU
 9Zxru1JLaKVq0.nmL6y9xqt2iRci3o7KchaOBuARnqGSzneyjkvtmzohCCnTFjXC5HSjzf6GVaXB
 zNn8uwkTsp7I2H6wItxY9WLGtJv._s9J3LdBCtTkw2wpu5xfj8vYeT3lDO7q_JIv5imAHTsaJARc
 nBEW31QnG3jX35VqR0iokQ02H6AzBb27JszxCIs4WWasKkf57CZZDCe98w7vsXZ_lTO22wxPYdNw
 0ft3z2I9iS7L3TdV9MJLxjedMXrvTXkAaKjk7tAwE0mEpcxRLDtpxgbJphZYXzLwupJKxBOa957k
 fIpO_seH31lc3sm60yPmC9D5K4sZblicLLw978df63Ha_eVA9oKJAlXB9Eqvqf4np4BXtn9urwWF
 j3ibFs39XXFURacX2ocXlzDPoE08mB6360Xr87OqWHpg7FI2qWkBsqFLwA2FGcDUkLjd7Uz4PEWw
 46ec2bb35dg--
X-Sonic-MF: <eric_devolder@yahoo.com>
X-Sonic-ID: 8ba60698-3fd8-470f-99c4-b0f740ba3e4f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Nov 2023 23:35:53 +0000
Received: by hermes--production-bf1-5d8dc66654-5vp49 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ca74304065a9f2006ba282ef404c19e0;
          Tue, 28 Nov 2023 23:35:49 +0000 (UTC)
Message-ID: <f876d8e6-cb93-4d22-9837-eae2764e7b07@yahoo.com>
Date: Tue, 28 Nov 2023 17:35:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kernel/Kconfig.kexec: drop select of KEXEC for
 CRASH_DUMP
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 akpm@linux-foundation.org, ignat@cloudflare.com, agordeev@linux.ibm.com
References: <20231128054457.659452-1-bhe@redhat.com>
From: Eric DeVolder <eric_devolder@yahoo.com>
In-Reply-To: <20231128054457.659452-1-bhe@redhat.com>
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_153556_964591_241746D7 
X-CRM114-Status: GOOD (  18.46  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On 11/27/23 23:44, Baoquan He wrote:
> Ignat Korchagin complained that a potential config regression was
> introduced by commit 89cde455915f ("kexec: consolidate kexec and
> crash options into kernel/Kconfig.kexec"). Before the commit,
> CONFIG_CRASH_DUMP has no dependency on CONFIG_KEXEC. After the commit,
> CRASH_DUMP selects KEXEC. That enforces system to have CONFIG_KEXEC=y
> as long as CONFIG_CRASH_DUMP=Y which people may not want.
>
> In Ignat's case, he sets CONFIG_CRASH_DUMP=y, CONFIG_KEXEC_FILE=y and
> CONFIG_KEXEC=n because kexec_load interface could have security issue if
> kernel/initrd has no chance to be signed and verified.
>
> CRASH_DUMP has select of KEXEC because Eric, author of above commit,
> met a LKP report of build failure when posting patch of earlier version.
> Please see below link to get detail of the LKP report:
>
>      https://lore.kernel.org/all/3e8eecd1-a277-2cfb-690e-5de2eb7b988e@oracle.com/T/#u
>
> In fact, that LKP report is triggered because arm's <asm/kexec.h> is
> wrapped in CONFIG_KEXEC ifdeffery scope. That is wrong. CONFIG_KEXEC
> controls the enabling/disabling of kexec_load interface, but not kexec
> feature. Removing the wrongly added CONFIG_KEXEC ifdeffery scope in
> <asm/kexec.h> of arm allows us to drop the select KEXEC for CRASH_DUMP.
> Meanwhile, change arch/arm/kernel/Makefile to let machine_kexec.o
> relocate_kernel.o depend on KEXEC_CORE.
>
> Fixes: commit 89cde455915f ("kexec: consolidate kexec and crash options into kernel/Kconfig.kexec")
> Reported-by: Ignat Korchagin <ignat@cloudflare.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>   arch/arm/include/asm/kexec.h | 4 ----
>   arch/arm/kernel/Makefile     | 2 +-
>   kernel/Kconfig.kexec         | 1 -
>   3 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
> index e62832dcba76..a8287e7ab9d4 100644
> --- a/arch/arm/include/asm/kexec.h
> +++ b/arch/arm/include/asm/kexec.h
> @@ -2,8 +2,6 @@
>   #ifndef _ARM_KEXEC_H
>   #define _ARM_KEXEC_H
>   
> -#ifdef CONFIG_KEXEC
> -
>   /* Maximum physical address we can use pages from */
>   #define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
>   /* Maximum address we can reach in physical address mode */
> @@ -82,6 +80,4 @@ static inline struct page *boot_pfn_to_page(unsigned long boot_pfn)
>   
>   #endif /* __ASSEMBLY__ */
>   
> -#endif /* CONFIG_KEXEC */
> -
>   #endif /* _ARM_KEXEC_H */
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index d53f56d6f840..771264d4726a 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -59,7 +59,7 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= entry-ftrace.o
>   obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o patch.o
>   obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o patch.o
>   obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
> -obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
> +obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
>   # Main staffs in KPROBES are in arch/arm/probes/ .
>   obj-$(CONFIG_KPROBES)		+= patch.o insn.o
>   obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 7aff28ded2f4..1cc3b1c595d7 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -97,7 +97,6 @@ config CRASH_DUMP
>   	depends on ARCH_SUPPORTS_KEXEC
>   	select CRASH_CORE
>   	select KEXEC_CORE
> -	select KEXEC
>   	help
>   	  Generate crash dump after being started by kexec.
>   	  This should be normally only set in special crash dump kernels

I have run this change against the kconfig regression script, and it did 
not find any differences!

Reviewed-by: Eric DeVolder <eric_devolder@yahoo.com>




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
