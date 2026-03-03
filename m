Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AC3E67A6A
	for <kexec@archiver.kernel.org>; Tue,  3 Mar 2026 05:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GP/GiWYeS0pMiBqvJFMNVE6SyM3tMRMwuL8KlnPDFIo=; b=c+pKbvBy/LYlTzMJui//Cf3tmg
	zHWTvXTqgtG3gdGWd2SuDlsGIWUKFyCSUPdhxgT/dOEoKVJhiQBsrWj0+OpQDlIqHdmh8tHd3EZFN
	QFXZ3d2Cm5amNGKKIga0G96mfHgAfXKEYfrJ0UAENvFQbJ02VhgtpBlextEcwKyorodv4EAN0AyVI
	GUYLnxL3pmMsIUG3psIR8Y5Bx5IDX3+P+txLYUZ466gmDhvGXqk+GVXBESGxxKf5Nujg1f/7W57/h
	JagYHJups917pP7iKmL6necIxBaWfuFazAK3JsNMJwpRT7qtTu+hHS+NtvI+VrSoI0AFnC1m25qH+
	6xuzzDqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxI7j-0000000EWxQ-3Tpq;
	Tue, 03 Mar 2026 05:16:47 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxI7e-0000000EWwn-0PGY
	for kexec@lists.infradead.org;
	Tue, 03 Mar 2026 05:16:43 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so58933355e9.1
        for <kexec@lists.infradead.org>; Mon, 02 Mar 2026 21:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772515000; x=1773119800; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GP/GiWYeS0pMiBqvJFMNVE6SyM3tMRMwuL8KlnPDFIo=;
        b=wBzN8ZkrtMjbEpMhlPjDhW5QTOaBMvDU52gA8OgKOxiurV5CQajrSV3bqtD92iYboD
         Mgq9ZfHCJFoOSAWkIkS70Za7upXPj+/a+Fo/nKfvmjVk1mgypC+Qj99grvu7qouy/+SP
         +FDblcpOG75BX/JW/NP86BHA7MSUTar/KO1ZkfrWL2LC1oKdbR9J6/kvffPXvwJYe1TF
         U5Kw4B88l1bHVXQFmTMhJTcjdkU5mV6m7Q2pziM87A+PfzkVVDLy4opfaAvsmAWYQk2f
         ECCbcqrIte1/uGC2TD/WLYH7ihLmFqtIlPFlBDPXGa0TRX1PtBdRnn+9c/KpXS0uFNhQ
         5ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772515000; x=1773119800;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GP/GiWYeS0pMiBqvJFMNVE6SyM3tMRMwuL8KlnPDFIo=;
        b=OoguYJiyjd6g77CHm4tg2fQcwisq8pPdWJ+0KzLOXIQCPBS72ebfr1XVfDveVXCDyB
         znSOnZSvAzu+zsI9JVqgTDBg9lBYLwAfKMY3uczOHpAgNeahhWKcS7zKuXfJcbq1MhDX
         zcwMzd9L/gKGN/euD32IRcn6Dp0tJX9rsXRbfILnvcEh87qlVZdUNWO0Z1ThjGYcOD78
         9/IMSnj93u9WgaPOTRQEkr/Ew5Y+p2A3nsH0TrhEC02fHX9OC7PV1NLCXG4hyCN6IWxf
         PkbQWvbiqu42LYbnTClkqdMYekb4wdEgU1AReBtL1sFV6Z6l7oSB8FZ7eq1ydqhWONi5
         z17A==
X-Gm-Message-State: AOJu0YzXdLFWTeBOs//CYgHqPC4x1RJ+EHr/yBRMJb5RJ5HigI1wIEy0
	7SBJGGYoB/iKSLNSUWs22wMsj/boRRT4+hqIiBWkMr8uGjZ4vxhw2py4NHBlHXKK29I=
X-Gm-Gg: ATEYQzwg7MpuVWgnhpSlV0tCghLLaRssQ0fPHGR6G//QrMhr6ajoHVU0eGQ6Mf32P48
	8w0wK7m+wA8gYK7teY3xKDwYyNef9MZ+DAmOCUUDDm280LQYf0kvOsLuykFmbX/rSfgYIxUPSim
	6UFNOBGZpUG2RvaFeQSvxJVykdQDr990rGYbvuxY91ntitRoZPnLb1OCP/wQ4kI98CJ0yuGADR4
	J8+nMa6C811F0t+SpZguK5kM2LWLh0+PjnQpdnZTZF6QXCOD7qQ4t6T5od3pO0guythRHdEF5hr
	TCdf6XUzRqQcEuFQVqaXJLtQOj/4O00Q4ov8O1BPy87d5eA9iCOyWCLACJiNtb8v5oVglXab25n
	EEu/Ff7XgOtDygxJ3RG2ePbaVe9FXwK/CRUQAIhyt7/BAqP/5PscItRigR5ST0bDKXYLMGzJQtV
	wk1nTonefTOhqZ+GjYJA/WipoNXOjC6p2qSYkYsD4=
X-Received: by 2002:a05:600c:3108:b0:483:887:59b0 with SMTP id 5b1f17b1804b1-483c9c1cd2bmr278984465e9.35.1772514999496;
        Mon, 02 Mar 2026 21:16:39 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485133a9511sm8016005e9.17.2026.03.02.21.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 21:16:38 -0800 (PST)
Date: Tue, 3 Mar 2026 08:16:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org
Subject: [bug report] kho: update FDT dynamically for subtree addition/removal
Message-ID: <aaZus68Dao_6Ckwf@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_211642_155674_EEA8C01F 
X-CRM114-Status: UNSURE (   6.30  )
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

[ Smatch checking is paused while we raise funding. #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Pasha Tatashin,

Commit 8e068a286aef ("kho: update FDT dynamically for subtree
addition/removal") from Nov 14, 2025 (linux-next), leads to the
following Smatch static checker warning:

	kernel/liveupdate/kexec_handover.c:777 kho_add_subtree()
	warn: return mixup? 'err' vs 'fdt_err'

kernel/liveupdate/kexec_handover.c
    767 {
    768         phys_addr_t phys = virt_to_phys(fdt);
    769         void *root_fdt = kho_out.fdt;
    770         int err = -ENOMEM;
    771         int off, fdt_err;
    772 
    773         guard(mutex)(&kho_out.lock);
    774 
    775         fdt_err = fdt_open_into(root_fdt, root_fdt, PAGE_SIZE);
    776         if (fdt_err < 0)
--> 777                 return err;

Why return err (-ENOMEM) here instead of fdt_err?

    778 
    779         off = fdt_add_subnode(root_fdt, 0, name);
    780         if (off < 0) {
    781                 if (off == -FDT_ERR_EXISTS)
    782                         err = -EEXIST;
    783                 goto out_pack;
    784         }
    785 
    786         err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
    787                           &phys, sizeof(phys));
    788         if (err < 0)
    789                 goto out_pack;
    790 
    791         WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false));
    792 
    793 out_pack:
    794         fdt_pack(root_fdt);
    795 
    796         return err;
    797 }

regards,
dan carpenter

