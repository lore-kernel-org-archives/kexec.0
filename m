Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12930C25B76
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=NnVvmZ5VH/IMAvXeGh+LZk3v64qFJeEiF+dp4s6utrc=; b=hG4
	ZOS5O7MCGUTvSPZUC/uFzRUy80PQjBTbsL+J49OI5UgapKMcmmgSwmSAk+/7LCdgRDPob1fYgT1aV
	+Lz8rd/MRwkIFElPWKx1MWeWSAINp9mEEkX8rfNTKoUbPD0ujxVma0NMeqe8yw9Wo/OxsRrDjxhNs
	jnqojm/wq+77Jq7bJhQTooBCZoCY4wEGsFkdB2+WPxy5l7HbDSUd+2TALFp1aKMRbDMZ/QZQzU05R
	+uo0epGFeIei85l8/88vaRrr4spadGjFfPm839oGUrZa0iym9UVQYDr4Hc3vHPYnRcHkYFBmpennJ
	VZ/hoBIJ/h/yfNgeSZf4OcpdnplhF0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEv5c-000000076zA-0Q3q;
	Wed, 05 Jun 2024 18:10:24 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEv5Z-000000076xL-1TMK
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 18:10:22 +0000
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-52b9d062526so153222e87.3
        for <kexec@lists.infradead.org>; Wed, 05 Jun 2024 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1717611018; x=1718215818; darn=lists.infradead.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2Ue2h+0IQuQj8waJVEN0I5HIVelpZkuCZ6sQOM2Le0=;
        b=buSTDKUJ/UW/kstqW26ICzRujOxbmuwziFglBEB8tGpJk1hFaCj680OT1WGmYRe7jz
         z08IKb8FK8neKHRETPFiDodjhGAanoxO+owurX3UFy7s4ibIFZ20TdrBRvD8DbT1Dp4O
         fsJyqCp4YCQZ8RY6ZNsopHcLS5LvW9WAfv4vAsXrHplYpp8W9axI3SNa1IMleMYBFJhd
         Eoj/e/DVRzetX+ObdOtBlbOznDt9eJm4L4HaNhZLtoAq2tkOdsoTZeinhumGzQKRmfI0
         182GLT7Lq+SkvyLqqKEi4BguWLB71mmKhqp8lzTnRLpXbnljrYfl7QZf08F6mHFHvtTC
         ziLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717611018; x=1718215818;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2Ue2h+0IQuQj8waJVEN0I5HIVelpZkuCZ6sQOM2Le0=;
        b=UfkP5k0Ffj/fZxPnL5Zzldxhq+lQ6aHWeR+6rohInFCrQ7zZf8kkO8OQL25JlJDQus
         fSAXNXCnB0zX4wzoUhQ8eLN7B+W0gG78LEoYOnzLIXD+a52jvuSiAG+06mtLaqd3+44T
         Hk7qz89JnaDvrsMDgTlMPvC3R+9HQIQEAGrHd3+m6JHiGqiX4VaL7CIuSu3G6yKvIpRp
         4FqKCOcQp0iIwMaiZLT/jFPRhYFOrFsQZWI9fEYNHj56PvpGCCIuUbSsM4UQPi2j8cNZ
         ulqhfvu7crru1hMZS9X1r40/sCK7LjdCOpz4DdcYwUvtIT45JzZ5+cD1Vse3Gj2YBHAd
         H8UA==
X-Gm-Message-State: AOJu0YwuvPT+AF0QSsFujNdFpz2Ynk8lt/vJ06hIUlLpkXbUmwhnDEZc
	089az9U0F/HEnXf6aBATE9Mhn+o+c/gEPNKZ76T4bdflRyO7zdw5LRvGjc1NEFOtCQawe3JYQj1
	ZFr6qLc/h1poxeOsIBqD1zKU+/V8mDARLAufFzEzWkPXNoLJ6uw==
X-Google-Smtp-Source: AGHT+IFvO6Ix4+KfMJZ2O7nfJbt6Cce1odU6kcLcA8KXTRnjLnr9/eaBkxd602brfDB+ZQmLy+tuArpoxAbyO5DYnQc=
X-Received: by 2002:ac2:5190:0:b0:528:ab83:3ee with SMTP id
 2adb3069b0e04-52bab4e3a1emr1888010e87.31.1717611018253; Wed, 05 Jun 2024
 11:10:18 -0700 (PDT)
MIME-Version: 1.0
From: Prasad Koya <prasad@arista.com>
Date: Wed, 5 Jun 2024 11:10:07 -0700
Message-ID: <CAKh1g55PTX=tXoiQB8sKiZ1T+bBnCE4W67fFi5G8zEfh-nKq2g@mail.gmail.com>
Subject: enhance makedumpfile to dump process list from vmcore
To: kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_111021_462249_F3E58097 
X-CRM114-Status: UNSURE (   7.27  )
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

Hi

We use makedumpfile to read the dmesg buffer from the vmcore. We are
working on adding a feature to makedumpfile to extract the "process
list" from /proc/vmcore. Our main use case is to save the processes
that were running at the time of kernel crash to a file on the
permanent storage from the kdump kernel. We intend to read a handful
of useful data for each running task: pid, parent pid, real parent
pid, priority, nice value, RSS, VM size, command, utime, stime, OOM
score.

Process list from vmcore can probably be read using crash utility, but
in our embedded system using makedumpfile to do that job makes sense
for us.

If such an option is useful for the general users of makedumpfile,
we'd like to get more inputs and contribute to this feature.

Thank you
Prasad

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
