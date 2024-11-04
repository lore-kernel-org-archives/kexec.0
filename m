Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C054D132A2
	for <kexec@archiver.kernel.org>; Mon,  4 Nov 2024 10:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Subject:To:
	Message-ID:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JieCqOkc3AUWDXGFnV+XSdFHnpLFjCBbtG+PcIMPOkM=; b=1shwhFzI7ywsR9
	kWmoUtdsEot3iG7hsjSwTWoDCRXICs4XZPFfZeoH1i30Mjp20fYas9CpFv8uLfAcYOnaDNO2CNZpt
	apKSJADlJuFN+AUFZUw56yGBDrZ2vPlly6hdR0HwoaiEslyVP/K2QOnRG10O3Mc8WoWrOlmaFv9bR
	yoRCw90vWi9KAMB9MdxjN5tmwftNqJx74W4EUYk2UrlpnuqZMYHKYBDiiOCMJ0+XEOgj+WTYp2SGH
	nUhIDrWVxo+gEkxWuif6vFu8Ubi/rrn/SCxhWxTaqk++ftjNo9cqRaZMAauum5Lh5sD2PLQjox51y
	7+cyt4Vn5WgW5TUaQ1NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7tzq-0000000DG4X-1zL2;
	Mon, 04 Nov 2024 10:07:42 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7tl0-0000000DDqS-3lRD
	for kexec@lists.infradead.org;
	Mon, 04 Nov 2024 09:52:23 +0000
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-720e94d36c8so925882b3a.1
        for <kexec@lists.infradead.org>; Mon, 04 Nov 2024 01:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730713941; x=1731318741; darn=lists.infradead.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
        b=PfnbaiJ0JFy5u3IqGElPcKEHKJTve+dz1PX0KrBTfjY0AIXYymxwz78lY1acm/Ooei
         ShjtV/Ah7Nh70c8J75MmAS2hxTGR3DfQh4wPhyOGxzrNh+SCu9QrN9F8T5RDn4/R1VlG
         /q4YiTi7dQWTuCy/OuXqLYBElcZv0zLDj6cKMG6hafOIEkUnL6WVqFnmTWVgBlKzzTs5
         oaLgVgps9cwQ/JbimZRX1NflEcuIjtuTshHB6XACyGOE/jPF876aR7ga8YefgcyNqd4H
         xkJ3tqDEIehQQwQsRlZkJ38yo+Qpjns05R76eotTNWlyD6RzGDdW5KVX8BofWKWVyixR
         2Ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730713941; x=1731318741;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
        b=G6PEh74T9qaSewpIs+/wIi6WoRMwBgXddTsHY+zPQmxW2gWTPvg0jIZ3865FxOLnn+
         Qy+hx7OGqmN8UoUL/OsgDV+z4GlpbpEIDxBRh2u7y0P/yhPaEMDGHzhlVWsxWRE4ZzND
         tLLVARe+c8upP/SoQ+YVVTIUbcKln6X1c6iZItZMAXvQlSxUAerQUuWdJEuuDIKgjt90
         oijb9VmHup+6qkAz9kb7BvMqgXXXj91raavSHXT2jJKSg79p5Jf6O7dhqFdQgXzzdUvy
         /vln9D8Bo8rlWxVWRAuOonALLboDtJsX+ZmlSpEG1ZHE8E39MW65efHJxL+FI2lSgbNY
         LAcQ==
X-Gm-Message-State: AOJu0Yx/t2rRXEGPQaJH0LcRbx0IT9ldI/Um5ezWlRyCer+TX/x/2IHc
	6seXElzSgngkg5D/YcxigKAmqu3N/KNRUCey3oGF1FijWyAjvtlRoDvN01mi
X-Google-Smtp-Source: AGHT+IHoIhbONJPckLkQIWTusvHEkXkYntns6J5S9VvXSROa9ZDI9HZ5d/loIDDszK8iQkUWqNNMyw==
X-Received: by 2002:a05:6a20:6a0e:b0:1d9:25e2:d908 with SMTP id adf61e73a8af0-1dba4237597mr16696563637.25.1730713941323;
        Mon, 04 Nov 2024 01:52:21 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee697b5355sm3888516a12.94.2024.11.04.01.52.20
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2024 01:52:20 -0800 (PST)
From: Debbie Magoffin <sagormolla048@gmail.com>
X-Google-Original-From: Debbie Magoffin <dmagoffin@outlook.com>
Message-ID: <03c01f2e548e0f33fb7d189f61a408578f64d8ea5f9b7dcb355089a789cf3cea@mx.google.com>
To: kexec@lists.infradead.org
Subject: Yamaha Piano !!
Date: Mon, 04 Nov 2024 04:52:11 -0500
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_015222_941057_3A3487BD 
X-CRM114-Status: UNSURE (   2.73  )
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
Reply-To: dmagoffin@outlook.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello,

I am offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please do not hesitate to contact me.

Warm regards,
Debbie

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
