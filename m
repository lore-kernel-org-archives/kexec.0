Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03C2C02181
	for <kexec@archiver.kernel.org>; Mon, 13 Jan 2025 06:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZZnNet0O5J4fr5ksmkTFL+zBQeWgwnCVvi2QzKkoRdU=; b=2TGapNh/CGSGENyGI07JTxHenb
	BoSJ5aXi8/6lrEFjs0UURDofY7oEGHaCWY2JKWWQ8FFACqC5ZjnxGWyX1VjdWcQy4Z4K98IFwBlNW
	T305zxPbZ6oa5y8p4XVOkQJtugQyc14uH6UJyV5x2NYTat5LZgRHThBVca2ajirWeNzVvhDIJkrzN
	UdYAT8gX8TvdncL9KQbMAu/GmfXg01mGgHqCvxq/SbZhebvEXLSnAuyDeibwzdlGHlWpfJDzBSKJ5
	VMCm01CDLqTGmqOwzKU1ZZDzztk4+oehzJYFKdSzY0OaZQjTBEnusDDq62UTGUIW4Yp5Z48rtYMIr
	9tD5YX5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXECA-00000004AEL-3Evq;
	Mon, 13 Jan 2025 06:45:06 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXEC8-00000004ADh-17xG
	for kexec@lists.infradead.org;
	Mon, 13 Jan 2025 06:45:05 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-215740b7fb8so187435ad.0
        for <kexec@lists.infradead.org>; Sun, 12 Jan 2025 22:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736750703; x=1737355503; darn=lists.infradead.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZZnNet0O5J4fr5ksmkTFL+zBQeWgwnCVvi2QzKkoRdU=;
        b=Eq46SdT65s+qnVZP/6/mx4LV8owgyddvtqrGQnuiHPBZQZ9dkrtxzCbMPtZliCQFlw
         jDPkksgXjfbqR1tEeolGqn5BuuZTioSs0off2EG34TBLlbWPgXG5xvbPYtnTlzDpz4W3
         BEF63VSB2fWc3rq3UvMqsX2WzgQpQjddhf0Oo8o2ZSNZp/oX30QXtclJpniI2vDPjBQM
         8eUt9LkNiWPz/gDm+6rR56Xhskf2zQ0BYMgCmtQigtloNBuT1yZ+rgjx30Kxd3Q26YK9
         kO9/GrjZMoEsLSdD8GXX+arN652+uZ4KxDJW8q4PMkcNH8keQwtf3JL7J/46T/41obZt
         hGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750703; x=1737355503;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZnNet0O5J4fr5ksmkTFL+zBQeWgwnCVvi2QzKkoRdU=;
        b=bamcCBMtji3zUr7qbsLLOs7SBJW5hNgBXzMP2Lw3vviusEXmw58xqWWPTdgj5uH3OV
         FPwWtsg9WtZmXB6Zi6vVeiXgLJhMmgK6ELwDEZW8BDuJN9lsDKjxhKUbr+ob114vNBed
         Yugj6N6IIzxJZbbCiGcdIVXjZteaPruAbU5azCrGC6d/94ZZygJDGtyeRaYFzUIwpeSZ
         o76iVJN7fDs6tMIZQAlRdvlpFDhJeOp3h/Hx/y5TsN6ByDnJKbntm8HzuqXqtWvmTPvS
         imOq8qgWSRqTfg4hvAl4GhmdYiaQnSeqLWlgh1svUCdmx1D2tZ0t5wfJyfBeWIIDqy5T
         OV0A==
X-Forwarded-Encrypted: i=1; AJvYcCVkVdwaImmucrnbQcSRxhbYofekL60aqiFgpRQK4OduHmhjEBPdyfOf0pL7o9pNJBg0h/7YzA==@lists.infradead.org
X-Gm-Message-State: AOJu0YylO7cM3HjGYjgUiCXtmtPGjTxO6ZsYTDb9BVecheR0ndlqABF4
	F+ViwqR7kFZ1eaYr6NBu5IMvtC7bl7o0cNp7eQo81THj7r6VMkWGfH0YwlzQSw==
X-Gm-Gg: ASbGncuI/pTqeIVeb3rO12bT95irNycdDBnCys3bzw6oAsxCe8aVldu/aYQNV/QBt3x
	yWtSXRJ8lo8Q3U6SFmLAP9mQWeIFSxrkrPL5Yl7VIgm0OwjRiNVT6PKenH5i0H0a+kkQ8NK7laR
	Rnn0pG6fHbvQyIz06Re4+wDO1NcD4vETxLB1FQmoYeU5vfvNs72tNTdG7jgdvK0PVpK5uSVFU4G
	1YUIB/BQBscW822mX5IRDH8vuKeyV8iAGdRKFumL4I5kI8dGn7A4ru8nTmLl/2BlTOmemgXszEv
	jlqgkDRY
X-Google-Smtp-Source: AGHT+IGL+pHkY1VHr8C+yY6kE6AVLN8i8ufZa09c1W8jXuDlws5MB+tk0sh10TkTVDfS3p8xQEv/Hw==
X-Received: by 2002:a17:903:2592:b0:216:27f5:9dd7 with SMTP id d9443c01a7336-21aa338c670mr5266085ad.11.1736750702450;
        Sun, 12 Jan 2025 22:45:02 -0800 (PST)
Received: from [2620:0:1008:15:6978:efe1:738:5b77] ([2620:0:1008:15:6978:efe1:738:5b77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658bb4sm5208254b3a.86.2025.01.12.22.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:45:02 -0800 (PST)
Date: Sun, 12 Jan 2025 22:45:01 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: James Gowans <jgowans@amazon.com>, Dave Hansen <dave.hansen@intel.com>, 
    Matthew Wilcox <willy@infradead.org>, Pasha Tatashin <tatashin@google.com>, 
    Alexander Graf <graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, 
    Jason Gunthorpe <jgg@nvidia.com>, Frank van der Linden <fvdl@google.com>, 
    Vipin Sharma <vipinsh@google.com>, David Matlack <dmatlack@google.com>, 
    Junaid Shahid <junaids@google.com>, 
    Vishal Annapurve <vannapurve@google.com>
cc: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
    Pratyush Yadav <pratyush@kernel.org>, linux-mm@kvack.org, 
    kexec@lists.infradead.org
Subject: [Feedback Needed] Hypervisor live update biweekly meeting time
Message-ID: <2908e4ab-abc4-ddd0-b191-fe820856cfb4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_224504_328293_F1C0D9AE 
X-CRM114-Status: UNSURE (   9.76  )
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

Hi all,

Following up from discussions at the end of last year on two topics from 
the Linux MM Alignment Sessions, memory persistence across kexec[1] and 
Kexec Hand-Off (KHO)[2], we'd like to start up a biweekly series dedicated 
to this topic to accelerate alignment and progress.

We discussed this in-session as a mechanism to accelerate discussion on 
pertinent topics as well as get regular status updates on progress.  This 
obviously does *not* replace upstream discussion on the mailing list, but 
is rather meant to accelerate it.  Regular summaries for each session will 
continue to be posted on linux-mm and kexec mailing lists.

Per the attendees on the Cc list, the ideal time is likely biweekly on 
Mondays at 8:00-9:00am PST (UTC-8).  Since next Monday is a holiday in the 
United States, we'd start Monday, January 27 (this will also avoid the 
holiday in February).

I'm planning on inviting everybody on the To and Cc lists of this email.  
If you are also interested in attending, please email me *privately* so I 
can add you to the invite and shared drive.  If you are listed and are not 
interested in attending, same thing :)

If this time does *NOT* work for you, please also email me privately so we 
can try to develop another slot.  Given the number of people involved, and 
how geographically distributed we are, our mileage may vary.  The time of 
day, 8am PST, is basically etched into stone given this is the most 
convenient time for the people on the Cc list :)

Thank you!

Time zones

PST (UTC-8)		8:00am
MST (UTC-7)		9:00am
CST (UTC-6)		10:00am
EST (UTC-5)		11:00am
Rio de Janeiro (UTC-3)	1:00pm
London (UTC)		4:00pm
Berlin (UTC+1)		5:00pm
Moscow (UTC+3)		7:00pm
Dubai (UTC+4)		8:00pm
Mumbai (UTC+5:30)	9:30pm
Singapore (UTC+8)	12:00am Tuesday
Beijing (UTC+8)		12:00am Tuesday
Tokyo (UTC+9)		1:00am Tuesday
Sydney (UTC+11)		3:00am Tuesday
Auckland (UTC+13)	5:00am Tuesday

[1] 
https://lore.kernel.org/linux-mm/CAPTztWZ26YQmtDbXowUzrRUSb2mmbQksztHfbRYYTgDm9Gc_og@mail.gmail.com/T/
[2] 
https://lore.kernel.org/linux-mm/52e189fa-bbb4-f031-8a64-716ddee14599@google.com/T/

