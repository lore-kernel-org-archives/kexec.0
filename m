Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15B0CA0FE5
	for <kexec@archiver.kernel.org>; Fri,  1 Sep 2023 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Subject:Message-ID:In-Reply-To:
	Date:MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=wFCABbM62EWCr46XmJA8HU5RQEOlttXr/ipb1/WWxoE=; b=lApta2zzjVyvD8
	XcWlFvHKEvjD5b5gwfuOcWUTfpJC9x0bQsKk/FqHTKGYrxp2fFB1B1Q3tDtpZ+I+SeMmFgCv3LoUP
	ZdGPDRh5XUdk/qrWTW+38+OJbJ266AMrC2WyVJAJCgWhsPniol3UeN4ddR3wRVf8M+MXvIllru/um
	8aAQh6035Q6M4kSvmpUSZJ+Y2U9TinR8EETalRAba5ZfJsyjATpUXjDBG4x4JtIc1CIBWTYAaXhpc
	wEhcnfTbX7v79yvvbA+Onbh+f/38FXIEkdF7djzltTRuw4jl61CBbikppOErLV87ffKX2JPCvHI1p
	ssrxZ1BQFyu5jH0V6QHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qc4wy-0000wT-1Z;
	Fri, 01 Sep 2023 14:16:40 +0000
Received: from mail-pl1-f198.google.com ([209.85.214.198])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qc4wu-0000vL-2R
	for kexec@lists.infradead.org;
	Fri, 01 Sep 2023 14:16:38 +0000
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bf703dd21fso23028215ad.3
        for <kexec@lists.infradead.org>; Fri, 01 Sep 2023 07:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693577794; x=1694182594;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcvgDbvbUw5Qcf0anbgZcfJ9WNarMzjdamecOvB7IYI=;
        b=IJR1CdZ6KQyVjRDAE66W/fzSkBFSbrx4NJl3AbCfZh08wVzb09EEQ+AZQvNuBIRR5N
         xAVtV4uZ5nb83+wXwhw3PYBC0wdDtn3HXOqsQpbx9nkQUgOm+qYJBHaV5VhCZuSfeb8D
         LH7Y8i/fBu0kUVgyPrcnB6jz59ht+JtYYLml8ZsyiydYaf4ZW29/5hzud2GsdsKmK10M
         xEs3H/raT3Myr35BhmW3eNYjZuH+CxO1WteewEoMRXFKuqAuYiopdKJB0QmJst4VPyi2
         6A6E1izyY3OjHtk+GYnrucbR7RQ+uYSwPwGv0570rAvyE1h8MwxcE7xs9Y9i3qgHFcMT
         uuag==
X-Gm-Message-State: AOJu0YwiWJtjVO4KFlS2+s5nN1GLxfMQ/NHKGr8Mm2c8FawUAAmIn6Dz
	BADNsNQ62hSiOUc63KyYg05mej9r5fFMHLQiqP2KGUDd4XPk
X-Google-Smtp-Source: AGHT+IFc7YjlSjHvDvP7cirzcdCjKk2D/fDe+yk6UxvIvAemHVScjMtitmUI/slD7b32dT0fMgTPgbdH3RXPR+jluBVxNY9SvuDQ
MIME-Version: 1.0
X-Received: by 2002:a17:902:dacb:b0:1b8:929f:1990 with SMTP id
 q11-20020a170902dacb00b001b8929f1990mr922243plx.6.1693577794354; Fri, 01 Sep
 2023 07:16:34 -0700 (PDT)
Date: Fri, 01 Sep 2023 07:16:34 -0700
In-Reply-To: <0000000000001f4d4806037fc7b8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5052e06044cced1@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in free_unref_page_prepare
From: syzbot <syzbot+7423f066b632d9ff23d5@syzkaller.appspotmail.com>
To: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, bhe@redhat.com, 
	dyoung@redhat.com, hughd@google.com, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
	lrh2000@pku.edu.cn, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	nathan@kernel.org, ndesaulniers@google.com, pcc@google.com, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com, vgoyal@redhat.com, 
	willy@infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_071636_793787_4D3399FC 
X-CRM114-Status: UNSURE (   3.75  )
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

syzbot has bisected this issue to:

commit 3a77b282e256d880791a4c5aa10ede13d6417425
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Wed Aug 16 15:11:58 2023 +0000

    mm: free up a word in the first tail page

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13297387a80000
start commit:   7271b2a53042 Add linux-next specific files for 20230818
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a97387a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17297387a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=7423f066b632d9ff23d5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112386f3a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15044717a80000

Reported-by: syzbot+7423f066b632d9ff23d5@syzkaller.appspotmail.com
Fixes: 3a77b282e256 ("mm: free up a word in the first tail page")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
