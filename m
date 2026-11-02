Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794D606A324
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v/gHo+7l;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KZJfN+8m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	List-Unsubscribe-Post:Date:To:From:Subject:Content-Transfer-Encoding:
	MIME-Version:Content-Type:Message-ID:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Owner;
	bh=1DyJmok05cXbGQ2nzjHpRkp7DSFdk9Z/LIHidC2Jpb0=; b=v/gHo+7lIcfEy1wEWsYA6bcsnl
	D5JBs1DW/KVlAgqSPNzmtAcPTKbZvS4tVkxu3KJMauR06FLYImx26TwfIw06aN/RTyjkhkmEMlrWl
	sOvV3zlTMDAQZ82QM5Lwj6iPcV10uMEjkIJYU6ptIatoZvKAkxvsV3Tmb8Kbt/eqdU/3Vq5sa+uvW
	rPShRQMitj9kIz4wEoFNOFoL9zQCBisd8h3jWEekjqXlUmTBnDho4AzqOUbr5n3zcWPTHlRpITgx1
	7KEdVGq2prJCnQVDYDPi64OVcQy0ceSoY6WU9KK4dLtba7/IyUFZ1Ak+XVBC+UUejIo9YYlIalHvm
	/pE21dBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO0mZ-00000000aDM-3uMe;
	Mon, 02 Nov 2026 22:45:39 +0000
Received: from out162-62-58-69.mail.qq.com ([162.62.58.69])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO0mR-00000000aCK-3stm
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 22:45:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793659521; bh=1DyJmok05cXbGQ2nzjHpRkp7DSFdk9Z/LIHidC2Jpb0=;
	h=Subject:From:To:Date:List-Unsubscribe:Reply-To;
	b=KZJfN+8mK0tlk7rvG5dwnC8ycQjEmg6bqksaa3ZQsmB9MIo76jk9zresq6xQy1XWL
	 KMNJtrs5iUA5v4TWmXY/AcxWgCmLwvLa4KC+QxXWh0Q8BPCAsZb5z54Wf9HZB7Vj88
	 36e7nMljsjszfUVI2S3tIS5vMeN/Pg8kI/RT+9nU=
Received: from [172.30.83.242] ([47.117.125.210])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id B239AC46; Tue, 03 Nov 2026 06:44:35 +0800
X-QQ-mid: xmsmtpt1793659510tkbojwr8x
Message-ID: <tencent_D775503C0D9CAB407C8FAA2E2CD1DE55F306@qq.com>
X-QQ-XMAILINFO: NTYxQXVJjmCbPoHi3EDYhSQrG3JIr+2a4PEthL5LvgkmRkX8fO/Uks9bUP205M
	 o2Gy5nUFajTl72F/IUh1qkgtMOs28md0NrL6/rCBEwqFxkfbJgdSsgBwxVf3nM4qZgQm2efytQon
	 7iav0+J/QpvcCTbnPVXtCx+h/PsqSo8lapZggfP4gxWn79px2zzyp21gj+TlHgzX3M37f2KjbGwj
	 xY+hZ+VBj5xAA/YVnFKvjNAoEjiB5iqBDoXoAP6qNQW2OK8jmwbg1KcLB9AqwY4cc/AtmzPhUU3D
	 7sgU+nbbqlqrHXXfE6UckS0Mk4p9kRfgWqXdbv5bpSD1XkrkK8MINhqF8JkUoKIuqgRprwPxdMPS
	 C/woT+iEDljs5CJkrIIGG/Y30aobUNL8AY8lOM05RI4Fs6zZx7kEJMhRcINjXFJ5d2wkzmp3JGAj
	 JqTajGtbVA9ZZdsypN2VeDgRwm+2iXaMpkW+s2FmGdZ2ha0YWb2w7AbyQLpKKlTmWc9GicUK2j8w
	 RT+EFjzpVy5aobuDikjCNzhzma6uC0Vf++9/NHO3nv/0FmGuf2mA+FY82+eo+OkljWY0uhYPmmNU
	 LJ3vdiZQWpXRDtx1pEIpy2Lr+vLIQ8p0pyfspHBg2mm75C4udtGCmo8aqOtU6oGRUjaBkaxmTvBG
	 IxySi0dqTbypWEf9fFW1KlwW8AFvbu8olFmVUyDrZFWzvJ1HoOoVUVKbkYdcoF/rxrP6xCFsskhz
	 Syl5PBXq/KKyPWNQkXEmWZeKHcBou0IINC8jqp/BacMPXUf8dC3dtr/zbf4lr45CVI0FzE3UvPEe
	 xtxBf3ftixPUZBVtYfSoqM4QZRoep7xgFjRcX5QgHyvhRRFK6IWztbFe6UU0nwxBdmkVX5ZxzDNX
	 Fr8Hodr08FRmkwLtpiaH/Xd859KQ5BGyqZsGe/BS4Bpk/Z3+MTqGent2nVzPVHyq1SZGB053KVuJ
	 2axQLh5Cspi/plrMjGpdpY62Yhr+VXyNsP3tiGH/aKx9FVDflWm+4koyiHQeBUwt9S7jT+lk7Hg+
	 odA5szPbm+dhnVfo8AqKlRcjWY5dkF2JlJF55bU+sNhjpdWrVYrfiHW9AsqMr4M57teexYZQkroT
	 hJlTojAfxOyheTbsLHeWv6EIWyOCJj1FvaaWkWlCn90UWkNbmdL5ai0n6ChDqTogCBMjMUcEOq1T
	 qxthjzdheNW3Pd+JvN8NjgxOiPbmmPVYP3ynI4NE+IqzwnLIn3WHG6LG4982By/QU4Vao=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-USESPAMBG: true
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Subject: =?utf-8?q?token8341_=E2=80=94_an_API_partner_for_your_project?=
From: =?utf-8?b?ODM0MVRva2Vu5bel5Y6C?= <3823142483@qq.com>
To: kexec@lists.infradead.org
Date: Tue, 03 Nov 2026 06:45:20 +0800
X-OQ-MSGID: <179365952067.2910646.9722969813923200848@qq.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_144532_499245_06750609 
X-CRM114-Status: UNSURE (   2.67  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: 0.7 (/)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: wuqiong@token8341.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PYZOR_CHECK,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

5L2g5aW977yMCgrmiJHku6zlubPlj7AgdG9rZW44MzQx77yIdG9rZW44MzQxLmNvbe+8ieaPkOS+
myBBSSDlpKfmqKHlnosgQVBJIOiBmuWQiOacjeWKoe+8jArkuIDkuKoga2V5IOiwg+eUqCBEZWVw
U2Vla+OAgUtpbWnjgIHmmbrosLEgR0xN44CB6YCa5LmJ5Y2D6Zeu44CBTWluaU1heCDnrYnmqKHl
novvvIwK5a6M5YWo5YW85a65IE9wZW5BSSBTREvjgIIKCuaDs+i3n+S9oOiBiuiBiuaYr+WQpuac
ieWQiOS9nOWPr+iDveOAguWbnui/meWwgemCruS7tuWwseiDveaJvuWIsOaIkeOAguiwouiwou+8
gQoKLS0tCuWQtOeQvAp0b2tlbjgzNDEKaHR0cHM6Ly93d3cudG9rZW44MzQxLmNvbQoKLS0K5LiN
5oOz5YaN5pS25Yiw5oiR5Lus55qE6YKu5Lu277yf54K55LiL6Z2i6L+Z5Liq6ZO+5o6l5LiA6ZSu
6YCA6K6i77yM56uL5Y2z55Sf5pWI77yaCmh0dHBzOi8vdG9rZW44MzQxLmNvbS9nby91L2EyVjRa
V05BYkdsemRITXVhVzVtY21Ga1pXRmtMbTl5WjN6RmhlQjZtVGMK77yI5Lmf5Y+v5Lul55u05o6l
5Zue5aSN5pys6YKu5Lu244CB5q2j5paH5YaZ44CM6YCA6K6i44CN5Lik5Liq5a2X77yM5oiR5Lus
5ZCM5qC35Lya5aSE55CG44CC77yJ


