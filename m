Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF22C282EC
	for <kexec@archiver.kernel.org>; Tue, 11 Mar 2025 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SyAWrxEwUsWnM7LVGAbr1T8GXaCm2RFT3dQ++j9eSpM=; b=YLlaanbm/91vIl8GcDXIUJRCBo
	KHrWIqrP7tzpLaYMXWBKjuCzwW0AKGcc4pp9+VFz8PY9lxtoSgBXXtHYZLmeDmniaRWgdituDDA43
	KG8i9QDT3X1o990/G7UTc/A5Yll3vkAn28YXWa0VMyZCWyiATPQ26I9JM1BN0c9z9XqYjQte9/qPI
	/oL+6EnSEaTFGkFsEHY55rp4fiSf/FDuwhp1aoFup8OPfn5bj1zUwHYj5USXzdLIl5eL+lkMHmHuB
	QvOrIGdhCcDxoSfiLwJT0plVx+h4l8RHqnQDQIHPycdNf+YL3v1H62SFZMsW2e5/ZQABkkl+7LLvu
	208Gbu4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trx1j-00000005MF0-2I9g;
	Tue, 11 Mar 2025 10:39:59 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwzr-00000005Lyx-1wyb
	for kexec@lists.infradead.org;
	Tue, 11 Mar 2025 10:38:04 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-38f403edb4eso2879260f8f.3
        for <kexec@lists.infradead.org>; Tue, 11 Mar 2025 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741689481; x=1742294281; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SyAWrxEwUsWnM7LVGAbr1T8GXaCm2RFT3dQ++j9eSpM=;
        b=QrG3J1nHMv/nRZ3h9sSe0rrx4r1ydvvqFsZR21i1trggh1irVlYF7soRrNCgwSJAXT
         c1ZTCHU8FnhELDEALjBe5lNMYFQe2mzHTX9cRLVq5Szqu8kboZgAEGJh6ygbwK25ypsp
         n8d0TERAPz41OJxL2FTp1uKhbi8BhVUBPlqpl9G4LaCay+Ylvzbypc3J4Qa5dbj9kMDC
         EbdD07mzR2/Q8PeHrpdYc8q9+X6fByGUygEQ/WpEFBdChAD2FB21DHTK9X86Tzi0+Y0m
         CnXD0APjHSt07CJWpP5PrkN3SRnVTimUzTxX/oc3mU1rTF6fmaN1TvykdvSabDlYT8H0
         ysZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741689481; x=1742294281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyAWrxEwUsWnM7LVGAbr1T8GXaCm2RFT3dQ++j9eSpM=;
        b=J0i88lr/O1gLVoj2uWPlX6paIMxRbklxIHPmKSifkRfPEcaNSv1z19EAbUFiBSJSjt
         r+OwuXh6LszysRpG+dqswDlsQjNHyhaelQFeKiaRAPo3kQ+C5JK2SU9ud3l0hb2aLSpo
         diImh6+M7+q2nakn8pKzqm8ept2+1Q4lH/1+s2+L6LShPF8orZREd9zzuUCtX2BQwtKu
         OivNtX+dGnVyGOQ1qBTJlqVR8cb74m+GxhQ9b+dNElXKlzwEOAmxE3jTXSJVzW0R8Imp
         Zobanjf+LRnTVfGbI2VXdEa+6unJKOYVGeHwwyrjXnm6qDfiTfqZwP8CoUI2dMrmFDJX
         QrWw==
X-Forwarded-Encrypted: i=1; AJvYcCWsjcm+IUnJuvSiAWBdRgpP+P0MUNvSRQPg5N7qhGs5yiZtXfg3CQJMP2EahVX80HgtDUJ1/w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwdH5yMRNrBkKwcrVNbCGhc8Fnc7Si3mArVCLFJ1SDo98UGzTa7
	5pw5bxKlFkgQMDR8lnMm003iToVKL49gAdUYHjlRTkj+JeMipCQ2F90KBAtAJyk=
X-Gm-Gg: ASbGncugZxA3cUrT+3a0NaDN8hYromIk+KcUAlaJraa2W4jlwHMGKTJbUJaG7rxP6RU
	eK6RoWpi2NMyajqHf96k9rlONL0MkPXKmwvXFbRrnmm5wZW+CSDR4s7WWyywX9d91DjS3nmKq47
	Atq8B//ebj9ix9ialGHORjsHDxaRjVxNokhk0HwI8L6d1KyYJtSfy9+1HG5kc/JDXTR4G//uB+g
	YAWV1Db36eqkTkVQfNNpADWxLjs8y9dJS4VYKdj7pll1RAxvfFf2jebGzQ7FAnI55wkRNVBDxBO
	T6/wu80qPgnmfjXOWpB8w6w2iRJybZczaoZaIxsGoFgU2og=
X-Google-Smtp-Source: AGHT+IF/j8vaXxrz6NQ9qVToImBHcx1sXj5BHKod2F3PwyhmwrRzoNCSAtC5+f+03GzQ5ewdWZTRdg==
X-Received: by 2002:a05:6000:2c5:b0:391:10c5:d1a9 with SMTP id ffacd0b85a97d-39132d82751mr12162685f8f.31.1741689480756;
        Tue, 11 Mar 2025 03:38:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195casm18059782f8f.53.2025.03.11.03.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:38:00 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:37:58 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Todd E Brandt <todd.e.brandt@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
Message-ID: <Z9AShs1dEO0jrgjL@pathway.suse.cz>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_033803_506117_F101D05F 
X-CRM114-Status: GOOD (  16.10  )
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

On Wed 2025-02-26 16:59:00, Marcos Paulo de Souza wrote:
> Hello, I've being working on some patches that help to clarify the suspend/resume
> of printk machinery. The last patch on this patchset address one issue regarding
> suspended consoles and blanking.
> 
> This is a part one patchset that I would like to see merged before I send more patches
> that will rework the suspend flag (a global suspend flag istead of per console) and
> the removal of CON_ENABLED flag later on (I've created a function that will forcibly)
> register the console instead of using this flag.
> 
> Please review!
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Looks good to me. I could fix the typos when pushing.

Well, there is one more thing. It seems that the simple graphic logger
was merged for 6.14-rc1. And the console_stop()/console_start() API
is used also in drivers/gpu/drm/clients/drm_log.c.

It is actually the code which motivated this rename, as already
pointed out by John, see
https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/

Well, I am going to update these two locations when pushing this
as well. Let's just get this change done.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

