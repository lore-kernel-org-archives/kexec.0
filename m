Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA635F532E5
	for <kexec@archiver.kernel.org>; Tue, 24 Mar 2026 06:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=; b=s3+S/MPu1D3u7Yoj8Iqos5w4Ii
	Jn3GLL4YcyOyvvYcKQtTIWXRVFqtz0rRkgLBYi3YCTFUvnmze9oUYIbNFpUoWpT6dKMDftuHj0Ijd
	pbG2S46qT04Z8Hso9GJ3ZsvXjHJk2vquAzoWIri6E4qDsvsQJIKDsThHyC2cZgw7EN9nye778XByM
	QnzyLMt51ko4s+0f2MLZiRNaLACHDybg8dskuuemsy0SMtnLxTY76ZjykOINUCWH3dNoXYAvPJDbz
	kNVTQlmD+ywQj4g0s6s8b6O6VAbfWoARZqHWvTi+2yFowqkhZavr3m5gUjbrObEFVHEFsTovKaFVj
	ufIZS9kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vTf-00000000mzK-2VOA;
	Tue, 24 Mar 2026 06:42:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vTe-00000000mxh-1DGP
	for kexec@bombadil.infradead.org;
	Tue, 24 Mar 2026 06:42:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=; b=YowLD4SamcsKgekvVHz3TEY4iL
	lPETt0H3HinIfj5wsAdYx6BS886F3HTTi0jmErYFyKjFe8b5NaOVcwam/l18O5t8KcarxLSxYZISF
	hzyioxf7WQ25cAIzBO5gUmWCtHmdn29aTQ6oV3Z/+P13cP0hdKASdcD5XbPADOuHisZsHK7xYZ5RG
	oh3sQ4VBFLT1XRU6UDLSxCxVnaTDshrMg3tBwrUujqgVQSigzxqZGb6XATZkSGHE0Z/HUzKcj8nYq
	/kQHkXYOlNCKZ19UBBZ5RZsTQGp/cvLDJiYdAWP35eB5O1DF18FcskdwVDkWB75izzCojTxJ4Hnmw
	s7F/zzpQ==;
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by casper.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vTb-0000000DZIt-1UCN
	for kexec@lists.infradead.org;
	Tue, 24 Mar 2026 06:42:57 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so9768295e9.1
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774334572; x=1774939372; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=JwgOy+ma435u7fbi/MGfi9ZxlqH1omLnW78BwEg27UmwIeu55zTiQugHrD+yEIGosh
         le7mMIiWjGEJHIdjvWzk7tevCe022mnNVI5uD995JiTJswln1xQLpuS5WRyWwHtwCQhf
         E72r2PY68ptJu+GfBZi6/hwwlDsaMJ5MdrdhlSjjYVpvcC2LSx13NaYIMaWeor8vNC54
         +RJyCyQXc+HJBvQOwgVkklR/lHet7D0wbyH1oevQ/8hQ1PZhOFXh8CYpo/jd19zxl7JX
         QTVgd8DiZxQ4prtVn22o5W7cAsDy+BhJgN/tZQ2d14q/FSYbPKNpOpRUU5k+jHvYqXqS
         NnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334572; x=1774939372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=dgjPsRc6477JxQ3eH2mnHSddjvOMIOs+iPen5XpCRUOjm5m8mfvOdii64iDx9UUb4L
         NVWZyXn0q5fajQauuUK8SNkie+ZsSeYXjXlQNTM26Ma+jhFSfXJjiE8TGWu2LMM/ySFr
         Xq82YYOKJ1t2Co3WMlPLBAUFaeve6wW0sf9TfKbWAJDhn3kaec0cdfGBVqw6xmOcTI7p
         vbdQuFmfHs1LC6YuiF3RWaQF4a4Qzr7ssjX+e41FsJuIXTIT4Oi/Qk/RiF1O19Zajcfk
         1GWouoqJeI6tG09+09Qm/OjUqc2tgflitOoOvskp11oKPuyd772zWT35U5RywBD6+ILM
         7VjQ==
X-Gm-Message-State: AOJu0YxoWd7VLm9K00lvigTF1FWrzKAxPvD5JZ7ubpfssWbJVQNZISbO
	NGjgBp2UlKr9bZukxi90ZiavB0mrTopdVyGcs/BvlvIkTceKc7u2xwGS
X-Gm-Gg: ATEYQzy9sBsbL0573yaAoHu43NLUL4uf9b8XzZ0T0xvhcq8HFRUjXJNpBBG4ufnbgej
	2mY0azCmNuaudKTBIfa1PZHcwp+FnJfHksGyaKj7JHnWhzREXBR0ATDB6OKmqIZBtVg7xVypwRJ
	03a2qtt9b9RZmAbMHzkUevPzOjqgkFIlfM2bhrkICMPJbaGH1GTzquXLcPS/i86zBl9FgZKlpBu
	soiANfEHoAP1WfTrP6AwgN3bXD9zfzIyRH9IQtni4vq1tPeXcVjaVvTdZ8NUukfoVFO7hfH7hIH
	TAHAYvAG3XjBvQC14ajrDk55BQ1Qz869xm2XNqNvu+0ifoB/x/Fzl/M3jSz3ask9sJcIeKCEumL
	OhxmQrPp57mrmTZMQf4a3Uih6AL1HxTBJWoEYwwZrFZzLCy3Sbgz8tqSAAKRt6Fo/NzlDdTUAvr
	sO5tAZyAj0q+Wv1h91tt8=
X-Received: by 2002:a05:600c:8b31:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-486fee304c4mr210200845e9.29.1774334572299;
        Mon, 23 Mar 2026 23:42:52 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48711116cbfsm10881105e9.35.2026.03.23.23.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 23:42:50 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: dmatlack@google.com
Cc: kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 00/24] vfio/pci: Base Live Update support for VFIO device files
Date: Tue, 24 Mar 2026 09:42:47 +0300
Message-ID: <20260324064247.3271583-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_064255_421482_923AE750 
X-CRM114-Status: UNSURE (   4.50  )
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

Please, remove me from CC list in future versions of this patchset

-- 
Askar Safin

